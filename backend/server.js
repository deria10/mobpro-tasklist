require('dotenv').config()
const express = require('express')
const cors = require('cors')
const mongoose = require('mongoose')
const taskRoutes = require('./routes/tasks')

// express app
const app = express()

// middleware
app.use(cors())
app.use(express.json())

app.use((req, res, next) => {
    console.log(req.path, req.method)
    next()
})

// routes
app.use('/api/tasks', taskRoutes)

// Connected to DB
mongoose.connect(process.env.MONGO_URI)
    .then(() => {
        // listening request
        app.listen(process.env.PORT, () => {
            console.log(`Localhost listening at http://localhost:${process.env.PORT}`)
        })
    })
    .catch((error) => {
        console.log(error)
    })