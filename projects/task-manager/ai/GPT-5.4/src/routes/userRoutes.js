const express = require("express");

const auth = require("../middleware/auth");
const userController = require("../controllers/userController");

const router = express.Router();

router.get("/me", auth, userController.getProfile);
router.patch("/me", auth, userController.updateProfile);
router.delete("/me", auth, userController.deleteProfile);

module.exports = router;
