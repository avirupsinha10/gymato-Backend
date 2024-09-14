const { v4: uuidv4 } = require('uuid');

const HttpError = require('../models/HttpError');

const pool = require('../database');

const getListOfAllUsers = async (req,res,next) => {
    try {
        const usersList = await pool.query("SELECT * FROM users");
        res.json(usersList.rows);
    } catch (err) {
        console.log(err.message);
    }
};

const registerUser = async (req,res,next) => {
    try {
        const uid = uuidv4();
        const {role,phone,username,email,password} = req.body;
        const usersList = await pool.query("SELECT * FROM users");
        const hasUser = usersList.rows.find(u => u.username === username);
        if(hasUser) {
            throw new HttpError('Could not create user username already exists.',401);
        }
        const newUser = await pool.query("INSERT INTO public.users (id,role,username,name,email,password,phone) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *",
        [uid,role,username,username,email,password,phone]);
        res.status(201).json(newUser.rows[0]);

    } catch (err) {
        console.log(err.message);
        res.status(400).json({"errorMessage" : err.message});
    }
};


const loginUser = async (req,res,next) => {
    try {
        const {username, password} = req.body;
        const usersList = await pool.query("SELECT * FROM users");
        const identifiedUser = usersList.rows.find(u => u.username === username);
        if(!identifiedUser || identifiedUser.password != password){
            throw new HttpError('Could Not identify user, Credentials seems to be incorrect.',401);
        } else {
            const foundUser = await pool.query("SELECT * FROM users WHERE username = $1 AND password = $2",[username,password]);
            console.log('Successfully logged in.');
            res.json(foundUser.rows);
        }
    } catch (err) {
        console.log(err.message);
    }
};

exports.getListOfAllUsers = getListOfAllUsers;
exports.registerUser = registerUser;
exports.loginUser = loginUser;