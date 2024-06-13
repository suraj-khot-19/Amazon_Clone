const express = require("express");
const auth = require("../middlewares/auth_middleware");
const {Product} = require("../models/product_model");

const categoryProductRoute = express.Router();
// showing product with specific category
categoryProductRoute.get("/api/category-product", auth, async (req, res) => {
    try {
        //fetch product with specific product
        const fetchProduct = await Product.find({ category: req.query.category });
        res.json(fetchProduct);
        //error handling
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//exports
module.exports = categoryProductRoute;
