const jwt = require("jsonwebtoken");

const User = require("../models/User");
const ApiError = require("../utils/apiError");
const asyncHandler = require("../utils/asyncHandler");

const auth = asyncHandler(async (req, res, next) => {
  const header = req.header("Authorization");

  if (!header || !header.startsWith("Bearer ")) {
    throw new ApiError(401, "Authentication required.");
  }

  const token = header.replace("Bearer ", "").trim();
  const secret = process.env.JWT_SECRET;

  if (!secret) {
    throw new Error("JWT_SECRET is not defined.");
  }

  let decoded;

  try {
    decoded = jwt.verify(token, secret);
  } catch (error) {
    throw new ApiError(401, "Invalid or expired token.");
  }

  const user = await User.findOne({
    _id: decoded.userId,
    "tokens.token": token,
  }).select("+password");

  if (!user) {
    throw new ApiError(401, "Authentication required.");
  }

  req.token = token;
  req.user = user;
  next();
});

module.exports = auth;
