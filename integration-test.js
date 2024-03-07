const axios = require('axios');

axios.get('http://localhost:3000')
  .then(response => {
    if (response.status === 200 && response.data === 'Hello, world!') {
      console.log('Integration test passed successfully.');
      process.exit(0);
    } else {
      console.error('Integration test failed: Unexpected response.');
      process.exit(1);
    }
  })
  .catch(error => {
    console.error('Integration test failed:', error.message);
    process.exit(1);
  });
