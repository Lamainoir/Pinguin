const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  const Transaction = sequelize.define('Transaction', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    type: {
      type: DataTypes.ENUM('transfer', 'bill', 'recharge', 'withdrawal'),
      allowNull: false
    },
    amount: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false
    },
    recipientPhone: {
      type: DataTypes.STRING,
      allowNull: true
    },
    status: {
      type: DataTypes.ENUM('pending', 'completed', 'failed'),
      defaultValue: 'pending'
    },
    description: {
      type: DataTypes.STRING,
      allowNull: true
    }
  });

  Transaction.associate = (models) => {
    Transaction.belongsTo(models.User, { 
      as: 'sender',
      foreignKey: 'userId'
    });
    Transaction.belongsTo(models.User, { 
      as: 'recipient',
      foreignKey: 'recipientPhone',
      targetKey: 'phone'
    });
    Transaction.belongsTo(models.Merchant, { 
      foreignKey: 'merchantId',
      allowNull: true 
    });
  };

  return Transaction;
}; 