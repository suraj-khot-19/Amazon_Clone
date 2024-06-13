const express = require("express");
const auth = require("../middlewares/auth_middleware");
const {Product} = require("../models/product_model");


//deal of the day
const dealOfTheDayRoute = express.Router();

dealOfTheDayRoute.get('/api/deal-of-day', auth, async (req, res) => {
    try {
        //get product
        let product = await Product.find({});
        //sort it accourding to ratings
        product.sort((a, b) => {
            let product1 = 0;
            let product2 = 0;
            for (let i = 0; i < a.ratings.length; i++) {
                product1 += a.ratings[i].rating;
            }
            for (let i = 0; i < b.ratings.length; i++) {
                product2 += b.ratings[i].rating;
            }
            return product1 < product2 ? 1 : -1;
        });
        res.json(product[0]);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
//export
module.exports = dealOfTheDayRoute;
