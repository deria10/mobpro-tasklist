const Task = require('../models/taskModel')
const mongoose = require('mongoose')

// Get All Tasks
const getTasks = async (req, res) => {
    const tasks = await Task.find({}).sort({ createdAT: -1 })

    res.status(200).json(tasks)
}

// Get a Single Tasks
const getTask = async (req, res) => {
    const { id } = req.params

    if(!mongoose.Types.ObjectId.isValid(id)) {
        return res.status(404).json({ error: 'Task Not Found' })
    }

    const task = await Task.findById(id)

    if(!task) {
        return res.status(404).json({ error: 'Task Not Found' })
    }

    res.status(200).json(task)
}

// Create New Tasks
const createTask = async (req, res) => {
    const {title, description} = req.body

    // add doc to DB
    try{
        const task = await Task.create({title, description})
        res.status(200).json(task)
    } catch (error) {
        res.status(400).json({error: error.message})
    }
}

// DELETE a Tasks
const deleteTask = async (req, res) => {
    const { id } = req.params

    if(!mongoose.Types.ObjectId.isValid(id)) {
        return res.status(404).json({ error: 'Task Not Found' })
    }

    const task = await Task.findOneAndDelete({ _id: id})

    if(!task) {
        return res.status(400).json({ error: 'Task Not Found' })
    }

    res.status(200).json(task)
}

// UPDATE a Tasks
const updateTask = async (req, res) => {
    const { id } = req.params

    if(!mongoose.Types.ObjectId.isValid(id)) {
        return res.status(404).json({ error: 'Task Not Found' })
    }

    const task = await Task.findOneAndUpdate({ _id: id}, {
        ...req.body
    })

    if(!task) {
        return res.status(400).json({ error: 'Task Not Found' })
    }

    res.status(200).json(task)
}

module.exports = { getTasks, getTask, createTask, deleteTask, updateTask }