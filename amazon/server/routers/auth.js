const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user_model");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const authMiddelware = require("../middlewares/auth_middleware");

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

//verify token api
authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        //checking user with null token
        const token = req.header('auth-token');
        if (!token)
            return res.json(false);

        //if there verify with secretOrPublicKey: jwt.Secret
        const isVerified = jwt.verify(token, "passwordKey");
        //if unverified
        if (!isVerified) return res.json(false);

        //cheking user exist with verified id
        const existUser = await User.findById(isVerified.id);
        if (!existUser) return res.json(false);
       
        //if non of above condition
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
// geting data of user
// passing middelware authMiddelware

authRouter.get('/', authMiddelware, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});
//export
module.exports = authRouter;
