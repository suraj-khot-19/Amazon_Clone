const express = require("express");
const auth = require("../middlewares/auth_middleware");
const { Product } = require("../models/product_model");
const User = require("../models/user_model");
const Order = require("../models/order");


//add to cart
const userRoute = express.Router();

userRoute.post('/api/add-to-cart', auth, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        //find user
        let user = await User.findById(req.user);
        if (user.cart.length == 0) {
            user.cart.push({ product, quantity: 1 });
        } else {
            let isProductFound = false;
            for (let i = 0; i < user.cart.length; i++) {
                //to increase quantity
                if (user.cart[i].product._id.equals(product._id)) {
                    isProductFound = true;
                }
            }
            if (isProductFound) {
                let foundedProduct = user.cart.find((matchedProduct) => matchedProduct.product._id.equals(product._id));
                //if already in cart then increase by 1
                foundedProduct.quantity += 1;
            } else {
                user.cart.push({ product, quantity: 1 });
            }
        }
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//remove from cart
userRoute.delete('/api/delete-from-cart/:productId', auth, async (req, res) => {
    try {
        const { productId } = req.params;
        const product = await Product.findById(productId);
        //find user
        let user = await User.findById(req.user);

        for (let i = 0; i < user.cart.length; i++) {
            //to increase quantity
            if (user.cart[i].product._id.equals(product._id)) {
                /*
            splice:   The zero-based location in the array from which to start removing elements.
Removes elements from an array and, if necessary, inserts new elements in their place, returning the deleted elements.
                */
                //if one quantity => delete
                if (user.cart[i].quantity == 1) {
                    user.cart.splice(i, 1)
                }

                //if more than one quantity => decrease by 1
                else {
                    user.cart[i].quantity -= 1
                }
            }
        }


        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//to save address

userRoute.post('/api/pay', auth, async (req, res) => {
    try {
        const { address } = req.body;

        //find user
        let user = await User.findById(req.user);

        user.address = address;
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//to order product
userRoute.post('/api/order', auth, async (req, res) => {
    try {
        const { cart, totalPrice, address } = req.body;
        let products = [];
        for (let i = 0; i < cart.length; i++) {
            let product = await Product.findById(cart[i].product._id);
            if (product.quantity >= cart[i].quantity) {
                product.quantity -= cart[i].quantity;
                products.push({ product, quantity: cart[i].quantity });
                await product.save();
            } else {
                return res.status(400).json({ msg: `${product.name} is out of stock!` });
            }
        }

        //find user
        let user = await User.findById(req.user);
        user.cart = [];
        user = await user.save();
        let order = new Order({
            products,
            totalPrice,
            address,
            userId: req.user,
            orderedAt: new Date().getTime(),

        });
        order = await order.save();
        res.json(order);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//fetching order details:
userRoute.get("/api/order-detail", auth, async (req, res) => {
    try {
        const orders = await Order.find({ userId: req.user });
        res.json(orders);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//export
module.exports = userRoute;
