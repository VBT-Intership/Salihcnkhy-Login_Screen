import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_screen/Screens/Home/home.dart';
import 'package:login_screen/Screens/Login_Register/Components/CircularLogoContainer.dart';
import 'package:login_screen/Screens/Login_Register/Components/FormBox.dart';
import 'package:login_screen/Screens/Login_Register/Components/RoundedButton.dart';
import 'package:login_screen/Screens/Login_Register/Components/RoundedEmailTextField.dart';
import 'package:login_screen/Screens/Login_Register/Components/RoundedPasswordTextField.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterForm extends StatefulWidget {
  final double offsetX;

  const RegisterForm({Key key, @required this.offsetX}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  TextEditingController pwConfController = new TextEditingController();
  bool isReturned = false;

  bool isAutoValidate = false;
  Future<bool> _registerFuture;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(widget.offsetX, 0),
      child: Form(
        autovalidate: isAutoValidate,
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FormBox(
              childs: <Widget>[
                Stack(
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircularLogoContainer(),
                          RoundedEmailTextField(
                            emailController: emailController,
                            hintText: "Your Email",
                          ),
                          RoundedPasswordTextField(
                            pwController: pwController,
                            hintText: "Password",
                          ),
                          RoundedPasswordTextField(
                            pwController: pwConfController,
                            hintText: "Confirm Password",
                          ),
                          RoundedButton(
                              child: Text("REGISTER"),
                              onTap: _registerFuture == null
                                  ? () {
                                      setState(() {
                                        isAutoValidate = true;
                                        if (_formKey.currentState.validate()) {
                                          if (pwConfController.text ==
                                              pwController.text) {
                                            _registerFuture = tryRegister(
                                                emailController.text,
                                                pwController.text);
                                          }
                                        }
                                      });
                                    }
                                  : null)
                        ],
                      ),
                    ),
                    if (_registerFuture != null)
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: FutureBuilder<bool>(
                              future: _registerFuture.then((value) {
                                if (value && !isReturned) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomePage()),
                                      (route) => false);
                                } else {
                                  isReturned = false;

                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: Text("Something Went Wrong"),
                                            content: Text(
                                                "Username is already exist"),
                                            elevation: 20,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                side: BorderSide(
                                                    width: 0.1,
                                                    color: Colors.white)),
                                          ),
                                      barrierDismissible: true);
                                  setState(() {
                                    _registerFuture = null;
                                  });
                                }
                                return value;
                              }),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  isReturned = true;
                                  return Container();
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Future<bool> tryRegister(String username, String password) async {
    final http.Response response = await http.post(
      'http://192.168.1.104:3000/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
