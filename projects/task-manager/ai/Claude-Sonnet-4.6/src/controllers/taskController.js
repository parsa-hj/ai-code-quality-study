const Task = require("../models/Task");

const ALLOWED_UPDATES = ["title", "description", "completed"];

const createTask = async (req, res, next) => {
  try {
    const task = new Task({ ...req.body, owner: req.user._id });
    await task.save();
    res.status(201).json(task);
  } catch (error) {
    next(error);
  }
};

const getTasks = async (req, res, next) => {
  try {
    const match = { owner: req.user._id };
    const sort = {};

    // Filter by completion status
    if (req.query.completed !== undefined) {
      match.completed = req.query.completed === "true";
    }

    // Sort: ?sortBy=createdAt:desc
    if (req.query.sortBy) {
      const [field, order] = req.query.sortBy.split(":");
      sort[field] = order === "desc" ? -1 : 1;
    }

    const limit = Math.min(parseInt(req.query.limit) || 10, 100);
    const skip = parseInt(req.query.skip) || 0;

    const [tasks, total] = await Promise.all([
      Task.find(match).sort(sort).limit(limit).skip(skip),
      Task.countDocuments(match),
    ]);

    res.json({ tasks, total, limit, skip });
  } catch (error) {
    next(error);
  }
};

const getTask = async (req, res, next) => {
  try {
    const task = await Task.findOne({
      _id: req.params.id,
      owner: req.user._id,
    });

    if (!task) {
      return res.status(404).json({ error: "Task not found" });
    }

    res.json(task);
  } catch (error) {
    next(error);
  }
};

const updateTask = async (req, res, next) => {
  const updates = Object.keys(req.body);
  const isValid = updates.every((key) => ALLOWED_UPDATES.includes(key));

  if (!isValid) {
    return res.status(400).json({ error: "Invalid update fields" });
  }

  try {
    const task = await Task.findOne({
      _id: req.params.id,
      owner: req.user._id,
    });

    if (!task) {
      return res.status(404).json({ error: "Task not found" });
    }

    updates.forEach((key) => (task[key] = req.body[key]));
    await task.save();
    res.json(task);
  } catch (error) {
    next(error);
  }
};

const deleteTask = async (req, res, next) => {
  try {
    const task = await Task.findOneAndDelete({
      _id: req.params.id,
      owner: req.user._id,
    });

    if (!task) {
      return res.status(404).json({ error: "Task not found" });
    }

    res.json({ message: "Task deleted successfully" });
  } catch (error) {
    next(error);
  }
};

module.exports = { createTask, getTasks, getTask, updateTask, deleteTask };
