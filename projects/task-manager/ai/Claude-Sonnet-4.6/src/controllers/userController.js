const sharp = require("sharp");
const User = require("../models/User");

const ALLOWED_UPDATES = ["name", "email", "password", "age"];

const getProfile = (req, res) => {
  res.json(req.user);
};

const updateProfile = async (req, res, next) => {
  const updates = Object.keys(req.body);
  const isValid = updates.every((key) => ALLOWED_UPDATES.includes(key));

  if (!isValid) {
    return res.status(400).json({ error: "Invalid update fields" });
  }

  try {
    updates.forEach((key) => (req.user[key] = req.body[key]));
    await req.user.save();
    res.json(req.user);
  } catch (error) {
    next(error);
  }
};

const deleteProfile = async (req, res, next) => {
  try {
    await req.user.deleteOne();
    res.json({ message: "Account deleted successfully" });
  } catch (error) {
    next(error);
  }
};

const uploadAvatar = async (req, res, next) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: "No file uploaded" });
    }

    const buffer = await sharp(req.file.buffer)
      .resize({ width: 250, height: 250 })
      .png()
      .toBuffer();

    req.user.avatar = buffer;
    await req.user.save();
    res.json({ message: "Avatar uploaded successfully" });
  } catch (error) {
    next(error);
  }
};

const getAvatar = async (req, res, next) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user || !user.avatar) {
      return res.status(404).json({ error: "Avatar not found" });
    }
    res.set("Content-Type", "image/png");
    res.send(user.avatar);
  } catch (error) {
    next(error);
  }
};

const deleteAvatar = async (req, res, next) => {
  try {
    req.user.avatar = undefined;
    await req.user.save();
    res.json({ message: "Avatar deleted successfully" });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getProfile,
  updateProfile,
  deleteProfile,
  uploadAvatar,
  getAvatar,
  deleteAvatar,
};
