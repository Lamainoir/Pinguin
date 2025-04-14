const { DataTypes } = require('sequelize');
const bcrypt = require('bcrypt');

module.exports = (sequelize) => {
  const User = sequelize.define('User', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
      validate: {
        isEmail: true
      }
    },
    phone: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false
    },
    pin: {
      type: DataTypes.STRING,
      allowNull: false
    },
    balance: {
      type: DataTypes.DECIMAL(10, 2),
      defaultValue: 0.00
    }
  }, {
    hooks: {
      beforeCreate: async (user) => {
        if (user.password) {
          user.password = await bcrypt.hash(user.password, 10);
        }
        if (user.pin) {
          user.pin = await bcrypt.hash(user.pin, 10);
        }
      }
    }
  });

  User.associate = (models) => {
    User.hasMany(models.Transaction, { 
      as: 'sentTransactions',
      foreignKey: 'userId'
    });
    User.hasMany(models.Transaction, { 
      as: 'receivedTransactions',
      foreignKey: 'recipientPhone',
      sourceKey: 'phone'
    });
  };

  User.prototype.validatePassword = async function(password) {
    return await bcrypt.compare(password, this.password);
  };

  User.prototype.validatePin = async function(pin) {
    return await bcrypt.compare(pin, this.pin);
  };

  return User;
}; 