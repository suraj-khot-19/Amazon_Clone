const express = require("express");
const adminRoute = express.Router();
const adminMiddelware = require("../middlewares/admin_middleware");
const { Product } = require("../models/product_model");
const Order = require("../models/order");
const e = require("express");
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

//get order details
adminRoute.get("/admin/order-detail", adminMiddelware, async (req, res) => {
    try {
        let order = await Order.find({});
        res.json(order);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//admin to change status
adminRoute.post("/admin/order-status", adminMiddelware, async (req, res) => {
    try {
        const { id, status } = req.body;
        let order = await Order.findById(id);
        order.status = status;
        //order.status+=1; fine
        order = await order.save();
        res.json(order);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//admin anylitics
adminRoute.get("/admin/analytics", adminMiddelware, async (req, res) => {
    try {
        const order =await Order.find({});
        let totalEarnings = 0;
        for (let i = 0; i < order.length; i++) {
            for (let j = 0; j < order[i].products.length; j++) {
                totalEarnings += order[i].products[j].quantity * order[i].products[j].product.price;
            }
        }
        //category wise earnings
        let mobileEarnigs = await categoryWiseProduct("Mobile");
        let fashionEarnigs = await categoryWiseProduct("Fashion");
        let freshEarnigs = await categoryWiseProduct("Fresh");
        let electronicsEarnigs = await categoryWiseProduct("Electronics");
        let homeEarnigs = await categoryWiseProduct("Home");
        let dealsEarnigs = await categoryWiseProduct("Deals");
        let beautyEarnigs = await categoryWiseProduct("Beauty");
        let appliancesEarnigs = await categoryWiseProduct("Appliances");
        let booksEarnigs = await categoryWiseProduct("Books");
        let everydayEarnigs = await categoryWiseProduct("Everyday");
        let earnigs = {
            totalEarnings,
            mobileEarnigs,
            fashionEarnigs,
            freshEarnigs,
            electronicsEarnigs,
            homeEarnigs,
            dealsEarnigs,
            beautyEarnigs,
            appliancesEarnigs,
            booksEarnigs,
            everydayEarnigs,
        }
        res.json(earnigs);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


//categoryWiseProduct
async function categoryWiseProduct(category) {
    let earnigs = 0;

    let categoryOrders = await Order.find({
        "products.product.category": category,
    });

    for (let i = 0; i < categoryOrders.length; i++) {
        for (let j = 0; j < categoryOrders[i].products.length; j++) {
            earnigs += categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price;
        }
    }
    return earnigs;
}
//exports
module.exports = adminRoute;