const express = require("express");
const adminRoute = express.Router();
const adminMiddelware = require("../middlewares/admin_middleware");
const Product = require("../models/product_model");

//ading product api
adminRoute.post('/admin/add-product', adminMiddelware, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
        });
        //save to database
        product = await product.save();
        //return product to client side
        res.json(product);

    } catch (e) {
        res.status(400).json({ error: e.message });
    }

});

// showing product 
adminRoute.get('/admin/get-product', adminMiddelware, async (req, res) => {
    try {
        //fetch product
        const fetchProduct = await Product.find({});
        res.json(fetchProduct);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});

//delete product
adminRoute.post('/admin/delete-product', adminMiddelware, async (req, res) => {
    try {
        //fetch id of product
        const { id } = req.body;
        //delete that id
        let deleteProduct = await Product.findByIdAndDelete(id);
        res.json(deleteProduct);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});
//exports
module.exports = adminRoute;