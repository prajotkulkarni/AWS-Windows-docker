const express = require('express');
const app = express();

app.get('/',(req,res)=>{
    res.send("Welcome to docker container 2, Prajot!");
});

app.listen(8080, function(){
    console.log("app listening at port 8080");
});