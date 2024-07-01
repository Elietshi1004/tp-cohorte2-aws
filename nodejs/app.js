const fs = require('fs');
const express = require('express');
const app = express();
const port = 5000;

// Créer le fichier de log
const logFile = 'nodejs_server.log';

// Middleware pour enregistrer les interactions dans le fichier de log
app.use((req, res, next) => {
  const logEntry = `[${new Date().toISOString()}] ${req.method} ${req.url}`;
  fs.appendFileSync(logFile, logEntry + '\n');
  next();
});

// Route home
app.get('/', (req, res) => {
  const logEntry = `[${new Date().toISOString()}] GET /`;
  fs.appendFileSync(logFile, logEntry + '\n');
  res.send('Hello World');
});

// Route help
app.get('/help', (req, res) => {
  const logEntry = `[${new Date().toISOString()}] GET /help`;
  fs.appendFileSync(logFile, logEntry + '\n');
  res.send('This is the help page');
});

app.listen(port, () => {
  const logEntry = `[${new Date().toISOString()}] Node.js server started on port ${port}`;
  fs.appendFileSync(logFile, logEntry + '\n');
  console.log(`Node.js server running on port ${port}`);
});
