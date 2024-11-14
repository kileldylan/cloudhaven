const bcrypt = require('bcryptjs');

const password = '12345'; // The password you want to hash

const saltRounds = 10; // Number of rounds to process the data for hashing

bcrypt.hash(password, saltRounds, (err, hash) => {
  if (err) throw err;
  console.log('Hashed Password:', hash); // This will output the hashed password
});
