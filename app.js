const express = require('express');

const cors = require('cors');

const bodyParser = require('body-parser');

const HttpError = require('./models/HttpError');

const usersRoutees = require('./routes/UserRoutes');

const app = express();

//middlewares
app.use(cors());
app.use(bodyParser.json());

app.use('/users',usersRoutees);

app.use((req,res,next) => {
    const error = new HttpError('Could not find this route',404);
    throw error;
});

app.use((error,req,res,next) => {
    if (res.headerSent) {
        return next(error);
    }
    res.status(error.code || 500).json({message: error.message || 'Unknown error occured'});
});

app.listen(8080, () => {
    console.log("Server Running on 8080");
});