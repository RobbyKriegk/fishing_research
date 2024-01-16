const express = require('express');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

const app = express();
const port = 3000;

app.get('/database-data', (req, res) => {
  fs.readFile(path.join(__dirname, 'database_data.json'), 'utf8', (err, data) => {
    if (err) {
      console.error(`Error reading file from disk: ${err}`);
      res.status(500).send('Internal Server Error');
    } else {
      res.json(JSON.parse(data));
    }
  });
});


app.get('/trigger-python', (req, res) => {
  // Execute the Python script when the endpoint is hit
  exec('python main.py', (error, stdout, stderr) => {
    console.log(`stdout: ${stdout}`);
    if (error) {
      console.error(`Error executing Python script: ${error}`);
      return res.status(500).send('Internal Server Error');
    }

    try {
      // Parse the JSON response from the Python script
      let jsonData = JSON.parse(stdout);
      res.json(jsonData);
    } catch (parseError) {
      console.error(`Error parsing JSON: ${parseError}`);
      res.status(500).send('Error parsing JSON');
    }
  });
});

app.use(express.static('public'));

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});
