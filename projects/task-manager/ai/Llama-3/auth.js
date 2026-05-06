const express = require("express");
const app = express();
const bcrypt = require("bcrypt");

// Define the User model
class User {
  constructor(username, password) {
    this.username = username;
    this.password = bcrypt.hashSync(password, 10);
  }
}

// Create a new user
app.post("/register", async (req, res) => {
  const { username, password } = req.body;
  const existingUser = await User.findOne({ username });
  if (existingUser) {
    return res.json({ message: "Username already taken" });
  }
  const user = new User(username, password);
  await user.save();
  res.json(user);
});

// Login a user
app.post("/login", async (req, res) => {
  const { username, password } = req.body;
  const user = await User.findOne({ username });
  if (!user) {
    return res.json({ message: "Invalid username or password" });
  }
  if (bcrypt.compareSync(password, user.password)) {
    res.json(user);
  } else {
    return res.json({ message: "Invalid password" });
  }
});
