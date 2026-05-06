const express = require("express");

const auth = require("../middleware/auth");
const authController = require("../controllers/authController");

const router = express.Router();

router.post("/register", authController.register);
router.post("/login", authController.login);
router.post("/logout", auth, authController.logout);
router.post("/logout-all", auth, authController.logoutAll);

module.exports = router;
