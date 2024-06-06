const jwt=require('jsonwebtoken');

const authMiddelware =async (req,res,next)=>{
try{
    const token=req.header("auth-token");
    if(!token){
        return res.status(401).json({msg:"no auth token, access denied!"});
    }
    const verifiedToken=jwt.verify(token,"passwordKey");
    if (!verifiedToken){
        return res.status(401).json({ msg: "token verification fails, access denied!" });
    }
    //if user is valid then storing user in req.user
    req.user=verifiedToken.id;
    req.token=token;
    //next => it is just call next callback fun
    next();

}catch(e){
    res.status(500).json({error: e.message});
}
};
module.exports= authMiddelware;