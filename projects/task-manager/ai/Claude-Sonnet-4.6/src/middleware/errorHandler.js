// eslint-disable-next-line no-unused-vars
const errorHandler = (err, req, res, next) => {
  let statusCode = err.statusCode || 500;
  let message = err.message || "Internal Server Error";

  // Mongoose validation error
  if (err.name === "ValidationError") {
    statusCode = 400;
    message = Object.values(err.errors)
      .map((e) => e.message)
      .join(", ");
  }

  // Duplicate key (e.g. unique email)
  if (err.code === 11000) {
    statusCode = 409;
    const field = Object.keys(err.keyValue)[0];
    message = `${field} already exists`;
  }

  // Invalid ObjectId
  if (err.name === "CastError") {
    statusCode = 400;
    message = "Invalid resource ID";
  }

  // JWT errors
  if (err.name === "JsonWebTokenError" || err.name === "TokenExpiredError") {
    statusCode = 401;
    message = "Authentication required";
  }

  // Multer file size / type errors
  if (err.message && err.message.startsWith("Only .jpg")) {
    statusCode = 400;
  }
  if (err.code === "LIMIT_FILE_SIZE") {
    statusCode = 400;
    message = "File size must not exceed 1 MB";
  }

  res.status(statusCode).json({ error: message });
};

module.exports = errorHandler;
