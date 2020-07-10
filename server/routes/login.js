const express = require('express');
const router = express.Router();

var User = require('../DB/models/user');



/**
 * 
 * @param {Post request} req 
 * @param {Post response} res 
 */
function CheckUsernameAndPassword(req, res) {
  var _username = req.body.username;
  var _password = req.body.password;
  console.log(_username + " " + _password);

  /**Try to find the user with the posted user */
  User.findOne({
    username: _username
  }).exec((err, user) => {
    if (err) {
      res.status(500).send({
        message: err
      });
      return;
    }

    /** Check if user exist */
    if (user) {
      /**Check User password is correct */
      if (user.password === _password) {
        res.status(200).json({
          "Status": "Success"
        });
      } else {
        res.status(402).json({
          "Status": "Password is Wrong"
        });
      }
      return;
    } else {
      res.status(402).json({
        "Status": "User not found."
      });

    }
  });
}

/**
 * Post method
 */
router.post('/', CheckUsernameAndPassword);

module.exports = router;
