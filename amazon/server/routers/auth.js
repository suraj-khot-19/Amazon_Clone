const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user_model");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");

//sign up
authRouter.post("/api/signup", async (req, res) => {
    //get data from user
    try {
        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res
                .status(400)
                .json({ msg: "user with same email already exists!" });
        }

        //hash password
        const hashedPassword = await bcryptjs.hash(password, 8);
        //add user feilds in model
        let user = new User({
            email,
            name,
            password: hashedPassword,
        });
        //save user and
        //post data to database
        user = await user.save();

        //return the data to user
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//sign in user
authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const validUser = await User.findOne({ email });
        if (!validUser) {
            return res.status(400).json({ msg: "Email does not exist in database!" });
        }
        //becripting password
        const isMatch = await bcryptjs.compare(password, validUser.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect password!" });
        }
        //jwt token
        const token = jwt.sign({ id: validUser._id }, "passwordKey");//passwordKey=> secretOrPrivateKey: jwt.Secret
        res.json({ token, ...validUser._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
//export
module.exports = authRouter;
