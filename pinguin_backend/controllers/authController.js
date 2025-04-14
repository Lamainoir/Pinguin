const jwt = require('jsonwebtoken');
const User = require('../models/User');

const authController = {
  async login(req, res) {
    try {
      const { phone_number, pin } = req.body;

      // Vérification des champs requis
      if (!phone_number || !pin) {
        return res.status(400).json({
          message: 'Phone number and PIN are required',
          error: 'Missing required fields'
        });
      }

      // Recherche de l'utilisateur
      const user = await User.findOne({ where: { phone_number } });

      if (!user) {
        return res.status(404).json({
          message: 'User not found',
          error: 'Invalid credentials'
        });
      }

      // Vérification du PIN
      if (user.pin !== pin) {
        return res.status(401).json({
          message: 'Invalid PIN',
          error: 'Invalid credentials'
        });
      }

      // Génération du token
      const token = jwt.sign(
        { id: user.id, phone_number: user.phone_number },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );

      // Réponse
      res.status(200).json({
        message: 'Login successful',
        token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          phone_number: user.phone_number,
          balance: user.balance
        }
      });
    } catch (error) {
      console.error('Login error:', error);
      res.status(500).json({
        message: 'Error logging in',
        error: error.message
      });
    }
  },

  async register(req, res) {
    try {
      const { name, email, phone_number, pin } = req.body;

      // Vérification des champs requis
      if (!name || !email || !phone_number || !pin) {
        return res.status(400).json({
          message: 'All fields are required',
          error: 'Missing required fields'
        });
      }

      // Vérification de la longueur du PIN
      if (pin.length !== 4) {
        return res.status(400).json({
          message: 'PIN must be 4 digits',
          error: 'Invalid PIN length'
        });
      }

      // Vérification si l'utilisateur existe déjà
      const existingUser = await User.findOne({
        where: {
          [Op.or]: [
            { email },
            { phone_number }
          ]
        }
      });

      if (existingUser) {
        return res.status(400).json({
          message: 'User already exists',
          error: 'Duplicate user'
        });
      }

      // Création de l'utilisateur
      const user = await User.create({
        name,
        email,
        phone_number,
        pin,
        balance: 0.00
      });

      // Génération du token
      const token = jwt.sign(
        { id: user.id, phone_number: user.phone_number },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );

      // Réponse
      res.status(201).json({
        message: 'Registration successful',
        token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          phone_number: user.phone_number,
          balance: user.balance
        }
      });
    } catch (error) {
      console.error('Registration error:', error);
      res.status(500).json({
        message: 'Error registering user',
        error: error.message
      });
    }
  }
};

module.exports = authController; 