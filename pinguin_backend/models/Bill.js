const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  const Bill = sequelize.define('Bill', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    type: {
      type: DataTypes.ENUM('electricity', 'water', 'internet', 'phone'),
      allowNull: false
    },
    customerNumber: {
      type: DataTypes.STRING,
      allowNull: false
    },
    amount: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false
    },
    status: {
      type: DataTypes.ENUM('pending', 'paid', 'failed'),
      defaultValue: 'pending'
    },
    dueDate: {
      type: DataTypes.DATE,
      allowNull: true
    }
  });

  return Bill;
}; 