'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    const merchants = [
      {
        name: 'Electricité Nationale',
        type: 'electricity',
        accountNumber: 'ELEC001',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Eau Potable',
        type: 'water',
        accountNumber: 'WATER001',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Internet Plus',
        type: 'internet',
        accountNumber: 'NET001',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Télécom Mobile',
        type: 'phone',
        accountNumber: 'PHONE001',
        createdAt: new Date(),
        updatedAt: new Date()
      }
    ];

    await queryInterface.bulkInsert('Merchants', merchants, {});
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Merchants', null, {});
  }
}; 