const User = require("../models/User");
const ApiError = require("../utils/apiError");
const asyncHandler = require("../utils/asyncHandler");

const register = asyncHandler(async (req, res) => {
  const user = new User(req.body);
  await user.save();
  const token = await user.generateAuthToken();

  res.status(201).json({
    success: true,
    data: {
      user,
      token,
    },
  });
});

const login = asyncHandler(async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findByCredentials(email, password);

  if (!user) {
    throw new ApiError(401, "Invalid email or password.");
  }

  const token = await user.generateAuthToken();

  res.json({
    success: true,
    data: {
      user,
      token,
    },
  });
});

const logout = asyncHandler(async (req, res) => {
  req.user.tokens = req.user.tokens.filter(
    (entry) => entry.token !== req.token,
  );
  await req.user.save();

  res.json({
    success: true,
    message: "Logged out successfully.",
  });
});

const logoutAll = asyncHandler(async (req, res) => {
  req.user.tokens = [];
  await req.user.save();

  res.json({
    success: true,
    message: "Logged out from all sessions.",
  });
});

module.exports = {
  register,
  login,
  logout,
  logoutAll,
};
