const Task = require("../models/Task");
const ApiError = require("../utils/apiError");
const asyncHandler = require("../utils/asyncHandler");

const parseBoolean = (value) => {
  if (value === undefined) {
    return undefined;
  }

  if (value === "true" || value === true) {
    return true;
  }

  if (value === "false" || value === false) {
    return false;
  }

  return undefined;
};

const createTask = asyncHandler(async (req, res) => {
  const task = new Task({
    ...req.body,
    owner: req.user._id,
  });

  await task.save();

  res.status(201).json({
    success: true,
    data: task,
  });
});

const getTasks = asyncHandler(async (req, res) => {
  const {
    completed,
    priority,
    sortBy = "createdAt:desc",
    limit,
    skip,
  } = req.query;
  const match = { owner: req.user._id };
  const completedValue = parseBoolean(completed);

  if (completedValue !== undefined) {
    match.completed = completedValue;
  }

  if (priority) {
    match.priority = priority;
  }

  const [sortField, sortOrder = "desc"] = sortBy.split(":");
  const sort = {
    [sortField]: sortOrder === "asc" ? 1 : -1,
  };

  const tasks = await Task.find(match)
    .sort(sort)
    .limit(limit ? Number(limit) : 0)
    .skip(skip ? Number(skip) : 0);

  res.json({
    success: true,
    count: tasks.length,
    data: tasks,
  });
});

const getTaskById = asyncHandler(async (req, res) => {
  const task = await Task.findOne({
    _id: req.params.id,
    owner: req.user._id,
  });

  if (!task) {
    throw new ApiError(404, "Task not found.");
  }

  res.json({
    success: true,
    data: task,
  });
});

const updateTask = asyncHandler(async (req, res) => {
  const allowedUpdates = [
    "title",
    "description",
    "completed",
    "priority",
    "dueDate",
  ];
  const requestedUpdates = Object.keys(req.body);
  const invalidField = requestedUpdates.find(
    (field) => !allowedUpdates.includes(field),
  );

  if (invalidField) {
    throw new ApiError(400, `Cannot update field: ${invalidField}.`);
  }

  const task = await Task.findOne({
    _id: req.params.id,
    owner: req.user._id,
  });

  if (!task) {
    throw new ApiError(404, "Task not found.");
  }

  requestedUpdates.forEach((field) => {
    task[field] = req.body[field];
  });

  await task.save();

  res.json({
    success: true,
    data: task,
  });
});

const deleteTask = asyncHandler(async (req, res) => {
  const task = await Task.findOneAndDelete({
    _id: req.params.id,
    owner: req.user._id,
  });

  if (!task) {
    throw new ApiError(404, "Task not found.");
  }

  res.json({
    success: true,
    message: "Task deleted successfully.",
  });
});

module.exports = {
  createTask,
  getTasks,
  getTaskById,
  updateTask,
  deleteTask,
};
