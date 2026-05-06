const errorHandler = (error, req, res, next) => {
  if (res.headersSent) {
    return next(error);
  }

  if (error.name === "ValidationError") {
    const messages = Object.values(error.errors).map((item) => item.message);
    return res.status(400).json({
      success: false,
      message: "Validation failed.",
      errors: messages,
    });
  }

  if (error.code === 11000) {
    return res.status(409).json({
      success: false,
      message: "A resource with that value already exists.",
    });
  }

  if (error.name === "CastError") {
    return res.status(400).json({
      success: false,
      message: "Invalid resource identifier.",
    });
  }

  const statusCode = error.statusCode || 500;

  return res.status(statusCode).json({
    success: false,
    message: error.message || "Internal server error.",
  });
};

module.exports = errorHandler;
