const express = require('express');

const usersController = require('../controllers/UserControllers');

const router = express.Router();

router.get('/',usersController.getListOfAllUsers);

router.post('/signup', usersController.registerUser);

router.post('/login', usersController.loginUser);

module.exports = router;