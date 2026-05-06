const User = require("../models/User");

const register = async (req, res, next) => {
  try {
    const { name, email, password, age } = req.body;
    const user = new User({ name, email, password, age });
    await user.save();
    const token = await user.generateAuthToken();
    res.status(201).json({ user, token });
  } catch (error) {
    next(error);
  }
};

const login = async (req, res, next) => {
  try {
    const { email, password } = req.body;
    const user = await User.findByCredentials(email, password);
    const token = await user.generateAuthToken();
    res.json({ user, token });
  } catch (error) {
    // Use 400 for bad credentials (not 500)
    res.status(400).json({ error: error.message });
  }
};

const logout = async (req, res, next) => {
  try {
    req.user.tokens = req.user.tokens.filter((t) => t.token !== req.token);
    await req.user.save();
    res.json({ message: "Logged out successfully" });
  } catch (error) {
    next(error);
  }
};

const logoutAll = async (req, res, next) => {
  try {
    req.user.tokens = [];
    await req.user.save();
    res.json({ message: "Logged out from all devices" });
  } catch (error) {
    next(error);
  }
};

module.exports = { register, login, logout, logoutAll };
