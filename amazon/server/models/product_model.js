const mongoose = require('mongoose');
const ratingSchema = require('./rating');
//creating scema
const productSchema = mongoose.Schema({
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
    },
    //add ratings
    ratings: [ratingSchema],

});
//creating model
const Product = mongoose.model("Product", productSchema);
module.exports = {Product ,productSchema};