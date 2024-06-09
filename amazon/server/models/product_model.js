const mongoose = require('mongoose');
//creating scema
const productrSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    description: {
        required: true,
        type: String,
        trim: true,
    },
    //typr:array
    images: [
        {
            type: String,
            required: true,
        }
    ],
    price: {
        required: true,
        type: Number,
    },
    quantity: {
        type: Number,
        required: true
    },
    category: {
        type: String,
        required: true,
    }

});
//creating model
const Product = mongoose.model("Product", productrSchema);
module.exports = Product;