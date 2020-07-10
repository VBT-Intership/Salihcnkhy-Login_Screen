var mongoose = require("mongoose");

module.exports = () => {

  //Connect DB
    mongoose.connect("mongodb://localhost/user", {  useNewUrlParser: true, useCreateIndex: true, useUnifiedTopology: true });

    //Add callback for connection open
    mongoose.connection.on('open', () => {
        console.log('DB Connected');

      });

      //Add callback for connection failed
      mongoose.connection.on('error', (err) => {
        console.log('DB Error', err);
      });

    mongoose.Promise = global.Promise;
}