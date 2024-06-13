const express = require("express");
const auth = require("../middlewares/auth_middleware");
const {Product} = require("../models/product_model");

const ratingRouter = express.Router();
//ratings router
ratingRouter.post("/api/rate-product", auth, async (req, res) => {
    try {
        //taking id of product
        const { id, rating } = req.body;
        //find that product
        let product = await Product.findById(id);
        for (let i = 0; i < product.ratings.length; i++) {
            //for each user
            if (product.ratings[i].userId == req.user) {
                //just updating ratings
                product.ratings.splice(i, 1);
                break;
            }

        }
        //geting all feilds
        const ratingSchema = {
            userId: req.user,
            rating,
        }
        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
        //error handling
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//exports
module.exports = ratingRouter;
