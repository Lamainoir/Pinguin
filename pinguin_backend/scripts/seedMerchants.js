const { Merchant } = require('../models');

const merchants = [
  {
    name: 'Electricité Nationale',
    type: 'electricity',
    accountNumber: 'ELEC001'
  },
  {
    name: 'Eau Potable',
    type: 'water',
    accountNumber: 'WATER001'
  },
  {
    name: 'Internet Plus',
    type: 'internet',
    accountNumber: 'NET001'
  },
  {
    name: 'Télécom Mobile',
    type: 'phone',
    accountNumber: 'PHONE001'
  }
];

const seedMerchants = async () => {
  try {
    for (const merchant of merchants) {
      await Merchant.findOrCreate({
        where: { accountNumber: merchant.accountNumber },
        defaults: merchant
      });
    }
    console.log('Merchants seeded successfully');
  } catch (error) {
    console.error('Error seeding merchants:', error);
  }
};

module.exports = seedMerchants;