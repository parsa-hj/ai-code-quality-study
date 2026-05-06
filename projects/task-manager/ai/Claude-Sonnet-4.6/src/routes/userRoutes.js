const express = require("express");
const router = express.Router();
const {
  getProfile,
  updateProfile,
  deleteProfile,
  uploadAvatar,
  getAvatar,
  deleteAvatar,
} = require("../controllers/userController");
const authenticate = require("../middleware/auth");
const upload = require("../middleware/upload");

// GET  /api/users/me
router.get("/me", authenticate, getProfile);

// PATCH /api/users/me
router.patch("/me", authenticate, updateProfile);

// DELETE /api/users/me
router.delete("/me", authenticate, deleteProfile);

// POST /api/users/me/avatar
router.post("/me/avatar", authenticate, upload.single("avatar"), uploadAvatar);

// DELETE /api/users/me/avatar
router.delete("/me/avatar", authenticate, deleteAvatar);

// GET /api/users/:id/avatar  (public — serves binary image)
router.get("/:id/avatar", getAvatar);

module.exports = router;
