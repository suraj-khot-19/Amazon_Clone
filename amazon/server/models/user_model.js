const mongoose = require('mongoose');
const { productSchema } = require('./product_model');
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

    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    cart: [
        {
            product:productSchema,
            quantity:{
                type:Number,
                required:true,
            }
        }
    ]
});
//creating model
const User = mongoose.model("User", userScema);
module.exports = User;