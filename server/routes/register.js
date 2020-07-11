const express = require('express');
const router = express.Router();

var User = require('../DB/models/user');



/**
 * 
 * @param {Post request} req 
 * @param {Post response} res 
 */
function RegisterUserIfNotExist(req, res) {
  var _username = req.body.username;
  var _password = req.body.password;
  console.log(_username + " " + _password);

  // username is unique but check again :(
  User.findOne({
    username: _username
  }).exec((err, user) => {
    if (err) {
      res.status(500).send({
        message: err
      });
      return;
    }

    /*Check if user exist*/
    if (user) {
      res.status(400).send("User Already Exist");
      return;
    } else {
      new User({
        username: _username,
        password: _password
      }).save().then(() => {
        res.status(200).json("You've created your account successfully");
        return;

      }).catch((err) => {
        res.send("Something went wrong");

      });
    }
  });

  /* Create User */

}

/**
 * Post method
 */
router.post('/', RegisterUserIfNotExist);


module.exports = router;