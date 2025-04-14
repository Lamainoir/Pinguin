const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  const Merchant = sequelize.define('Merchant', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false
    },
    type: {
      type: DataTypes.ENUM('electricity', 'water', 'internet', 'phone'),
      allowNull: false
    },
    accountNumber: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    }
  });

  return Merchant;
}; 