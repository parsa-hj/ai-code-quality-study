const express = require("express");
const router = express.Router();
const {
  register,
  login,
  logout,
  logoutAll,
} = require("../controllers/authController");
const authenticate = require("../middleware/auth");

// POST /api/auth/register
router.post("/register", register);

// POST /api/auth/login
router.post("/login", login);

// POST /api/auth/logout  (requires auth)
router.post("/logout", authenticate, logout);

// POST /api/auth/logout-all  (requires auth)
router.post("/logout-all", authenticate, logoutAll);

module.exports = router;
