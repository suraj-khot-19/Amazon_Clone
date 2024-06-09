//imports from packages
const express=require("express");
const { get } = require("http");
const mongoose=require("mongoose");

//imports from other files
const authRouter=require("./routers/auth");
const adminRoute = require("./routers/admin");
const categoryProductRoute=require("./routers/categort_product");
const searchScreenRouter = require("./routers/search");

//initalization
const PORT=3000;
const app=express();
const db ="mongodb+srv://suraj:suraj123@flutteramazoncloneapp.zspb2e1.mongodb.net/?retryWrites=true&w=majority&appName=FlutterAmazonCloneApp"
//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRoute);
app.use(categoryProductRoute);

app.use(searchScreenRouter);

//connection
mongoose.connect(db).then(()=>{
    console.log("connection sucessful!");
}).catch((e)=>{
    console.log(e);
}) ;

// app.listen(PORT,"0.0.0.0",()=>{console.log('connected at port ${PORT}')}); use back tick instead
app.listen(PORT,"0.0.0.0",()=>{console.log(`connected at port ${PORT}`);
});