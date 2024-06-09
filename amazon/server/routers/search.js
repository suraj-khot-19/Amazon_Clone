const express = require("express");
const auth = require("../middlewares/auth_middleware");
const Product = require("../models/product_model");


//search screen
const searchScreenRouter = express.Router();
//if : in url params
//if ? in url query
searchScreenRouter.get('/api/search/:name', auth, async (req, res) => {
    try {
        //fetching product with search query
        const fetchProductWithSearchQuery = await Product.find({
            //passing reqular expression
            name: { $regex: req.params.name, $options: "i" },
        });
        res.json(fetchProductWithSearchQuery);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
//export
module.exports = searchScreenRouter;
