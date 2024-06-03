const mongoose = require('mongoose');
//creating scema
const userScema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Please enter valid email",
        },
    },
    password: {
        required: true,
        type: String,
        // validate: {
        //     validator: (value) =>  {
        //         const pass =
        //             /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(\W|_)).{6,}$/;
        //         return value.match(pass);

        //     },
        //     message: "Please enter strong password",
        // },

    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    //cart
});
//creating model
const User = mongoose.model("User", userScema);
module.exports = User;