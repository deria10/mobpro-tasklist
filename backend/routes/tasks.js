const express = require('express')
const { getTasks, getTask, createTask, deleteTask, updateTask } = require('../controllers/taskController')
const router = express.Router()

// GET All Tasks
router.get('/', getTasks)

// GET a Single Tasks
router.get('/:id', getTask)

// POST a New Tasks
router.post('/', createTask)

// DELETE a Tasks
router.delete('/:id', deleteTask)

// UPDATE a Tasks
router.patch('/:id', updateTask)


module.exports = router