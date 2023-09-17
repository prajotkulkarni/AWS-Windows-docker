const express = require('express');
const app = express();

app.get('/',(req,res)=>{
    res.send("Welcome to docker container, Prajot!");
});

app.listen(3000, function(){
    console.log("app listening at port 3000");
});