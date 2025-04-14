const { Sequelize } = require('sequelize');
const UserModel = require('./User');
const TransactionModel = require('./Transaction');
const MerchantModel = require('./Merchant');

const sequelize = new Sequelize(
  process.env.DB_NAME || 'pinguin_money_transfer',
  process.env.DB_USER || 'root',
  process.env.DB_PASSWORD || '',
  {
    host: process.env.DB_HOST || 'localhost',
    dialect: 'mysql',
    logging: false
  }
);

const User = UserModel(sequelize);
const Transaction = TransactionModel(sequelize);
const Merchant = MerchantModel(sequelize);

// Set up associations
User.associate({ Transaction });
Transaction.associate({ User, Merchant });

module.exports = {
  sequelize,
  User,
  Transaction,
  Merchant
}; 