const express = require("express");
const auth = require("../middlewares/auth_middleware");
const { Product } = require("../models/product_model");


//search screen
const allProductRouter = express.Router();
allProductRouter.get('/api/all', auth, async (req, res) => {
    try {
        const product = await Product.find({
        });
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
//export
module.exports = allProductRouter;
