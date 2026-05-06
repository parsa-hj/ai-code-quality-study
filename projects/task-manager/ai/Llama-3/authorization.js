const express = require('express');
const app = express();
const auth = require('./auth');

  // Define the authorized routes
app.use((req, res, next) => {
    const authHeader = req.headers.authorization;
    if (!authHeader) {
      return res.json({ message: 'Unauthorized' });
    }
    const token = authHeader.split(' ')[1];
    const user = await auth.login(token);
    if (!user) {
      return res.json({ message: 'Invalid token' });
    }
    req.user = user;
    next();
});

app.get('/tasks', (req, res) => {
    // Only authorized users can view tasks
    if (req.user) {
      res.json(req.user.tasks);
    } else {
      res.json({ message: 'Unauthorized' });
    }
});

app.post('/tasks', (req, res) => {
    // Only authorized users can create tasks
    if (req.user) {
      res.json(req.body);
    } else {
      res.json({ message: 'Unauthorized' });
    }
});