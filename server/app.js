var express = require('express');
//var bodyParser =require("body-parser"); // I couldn't use
var app = express();

var loginRouter = require("./routes/login");
var registerRouter = require("./routes/register");
var db = require("./DB/mongoDB")();

//Add option for json parse
app.use(express.json({
  inflate: true,
  limit: '100kb',
  reviver: null,
  strict: true,
  type: 'application/json',
  verify: undefined
}));

//Add Routers to App
app.use("/login",loginRouter);
app.use("/register",registerRouter);


//Start listen
app.listen(3000,"192.168.1.104",function () {
    console.log("dinliyor");
});

