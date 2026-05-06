const User = require("../models/User");
const ApiError = require("../utils/apiError");
const asyncHandler = require("../utils/asyncHandler");

const getProfile = asyncHandler(async (req, res) => {
  res.json({
    success: true,
    data: req.user,
  });
});

const updateProfile = asyncHandler(async (req, res) => {
  const allowedUpdates = ["name", "email", "password"];
  const requestedUpdates = Object.keys(req.body);
  const invalidField = requestedUpdates.find(
    (field) => !allowedUpdates.includes(field),
  );

  if (invalidField) {
    throw new ApiError(400, `Cannot update field: ${invalidField}.`);
  }

  requestedUpdates.forEach((field) => {
    req.user[field] = req.body[field];
  });

  await req.user.save();

  res.json({
    success: true,
    data: req.user,
  });
});

const deleteProfile = asyncHandler(async (req, res) => {
  await req.user.deleteOne();

  res.json({
    success: true,
    message: "User account deleted successfully.",
  });
});

module.exports = {
  getProfile,
  updateProfile,
  deleteProfile,
};
