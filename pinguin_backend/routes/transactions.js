const express = require('express');
const router = express.Router();
const { Transaction, User, Merchant } = require('../models');
const auth = require('../middleware/auth');
const { Op } = require('sequelize');

// Get all transactions for a user
router.get('/', auth, async (req, res) => {
  try {
    const transactions = await Transaction.findAll({
      where: {
        [Op.or]: [
          { userId: req.user.id },
          { recipientPhone: req.user.phone }
        ]
      },
      include: [
        {
          model: User,
          as: 'sender',
          attributes: ['id', 'name', 'phone', 'balance']
        },
        {
          model: User,
          as: 'recipient',
          attributes: ['id', 'name', 'phone', 'balance']
        },
        {
          model: Merchant,
          attributes: ['id', 'name', 'type']
        }
      ],
      order: [['createdAt', 'DESC']]
    });

    res.json(transactions);
  } catch (error) {
    console.error('Error fetching transactions:', error);
    res.status(500).json({ message: 'Error fetching transactions', error: error.message });
  }
});

// Send money
router.post('/send-money', auth, async (req, res) => {
  try {
    const { recipientPhone, amount, pin } = req.body;

    // Verify PIN
    const isValidPin = await req.user.validatePin(pin);
    if (!isValidPin) {
      return res.status(401).json({ message: 'Invalid PIN' });
    }

    // Check if recipient exists
    const recipient = await User.findOne({ where: { phone: recipientPhone } });
    if (!recipient) {
      return res.status(404).json({ message: 'Recipient not found' });
    }

    // Check if sender has sufficient balance
    if (req.user.balance < amount) {
      return res.status(400).json({ message: 'Insufficient balance' });
    }

    // Create transaction
    const transaction = await Transaction.create({
      userId: req.user.id,
      recipientPhone,
      amount,
      type: 'transfer',
      status: 'completed',
      description: `Transfer to ${recipient.name}`
    });

    // Update balances
    const newSenderBalance = req.user.balance - amount;
    const newRecipientBalance = parseFloat(recipient.balance) + parseFloat(amount);

    await req.user.update({ balance: newSenderBalance });
    await recipient.update({ balance: newRecipientBalance });

    // Refresh user data to get updated balances
    await req.user.reload();
    await recipient.reload();

    // Get transaction with details
    const transactionWithDetails = await Transaction.findByPk(transaction.id, {
      include: [
        {
          model: User,
          as: 'sender',
          attributes: ['id', 'name', 'phone', 'balance']
        },
        {
          model: User,
          as: 'recipient',
          attributes: ['id', 'name', 'phone', 'balance']
        }
      ]
    });

    res.status(201).json({
      message: 'Money sent successfully',
      transaction: transactionWithDetails,
      senderBalance: req.user.balance,
      recipientBalance: recipient.balance
    });
  } catch (error) {
    console.error('Error sending money:', error);
    res.status(500).json({ message: 'Error sending money', error: error.message });
  }
});

// Pay bill
router.post('/pay-bill', auth, async (req, res) => {
  try {
    const { merchantId, amount, pin } = req.body;

    // Verify PIN
    const isValidPin = await req.user.validatePin(pin);
    if (!isValidPin) {
      return res.status(401).json({ message: 'Invalid PIN' });
    }

    // Check if merchant exists
    const merchant = await Merchant.findByPk(merchantId);
    if (!merchant) {
      return res.status(404).json({ message: 'Merchant not found' });
    }

    // Check if sender has sufficient balance
    if (req.user.balance < amount) {
      return res.status(400).json({ message: 'Insufficient balance' });
    }

    // Create transaction
    const transaction = await Transaction.create({
      userId: req.user.id,
      merchantId,
      amount,
      type: 'bill_payment',
      status: 'completed',
      description: `Payment for ${merchant.name} bill`
    });

    // Update user balance
    const newBalance = req.user.balance - amount;
    await req.user.update({ balance: newBalance });
    await req.user.reload();

    // Get transaction with details
    const transactionWithDetails = await Transaction.findByPk(transaction.id, {
      include: [
        {
          model: User,
          as: 'sender',
          attributes: ['id', 'name', 'phone', 'balance']
        },
        {
          model: Merchant,
          attributes: ['id', 'name', 'type']
        }
      ]
    });

    res.status(201).json({
      message: 'Bill paid successfully',
      transaction: transactionWithDetails,
      userBalance: req.user.balance
    });
  } catch (error) {
    console.error('Error paying bill:', error);
    res.status(500).json({ message: 'Error paying bill', error: error.message });
  }
});

module.exports = router; 