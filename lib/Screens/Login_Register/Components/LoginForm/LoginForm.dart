import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_screen/Core/Task.dart';
import 'package:login_screen/Screens/Home/home.dart';
import 'package:login_screen/Screens/Login_Register/Components/CircularLogoContainer.dart';
import 'package:login_screen/Screens/Login_Register/Components/FormBox.dart';
import 'package:login_screen/Screens/Login_Register/Components/RoundedButton.dart';
import 'package:login_screen/Screens/Login_Register/Components/RoundedEmailTextField.dart';
import 'package:login_screen/Screens/Login_Register/Components/RoundedPasswordTextField.dart';

class LoginForm extends StatefulWidget {
  final double offsetX;
  LoginForm({@required this.offsetX});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  bool isAutoValidate = false;
  Future<bool> _loginFuture;
  bool isReturned = false;
  TextEditingController emailController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(widget.offsetX, 0),
        child: Form(
          autovalidate: isAutoValidate,
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: buildFormBox(context)),
        ));
  }

  FormBox buildFormBox(BuildContext context) {
    return FormBox(
      childs: <Widget>[
        buildFormBoxStack(context),
      ],
    );
  }

  Stack buildFormBoxStack(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: buildEmailPasswordAndLoginButtonFields(),
        ),
        if (_loginFuture != null)
          buildBackDropFilterAndFutureBuilderContainer(context),
      ],
    );
  }

  Center buildBackDropFilterAndFutureBuilderContainer(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: buildBackdropFilter(context),
      ),
    );
  }

  BackdropFilter buildBackdropFilter(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: buildFutureBuilder(context),
    );
  }

  FutureBuilder<bool> buildFutureBuilder(BuildContext context) {
    return FutureBuilder<bool>(
      future: _loginFuture.then((value) {
        checkLoginSuccessIfNotShowDialog(value, context);
        return value;
      }).catchError((err) {
        serverDoesntResponseAlert(context);
      }),
      builder: (context, snapshot) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void serverDoesntResponseAlert(BuildContext context) {
     showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Something Went Wrong"),
                  content: Text("Server Doens't Response"),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(width: 0.1, color: Colors.white)),
                ),
            barrierDismissible: true)
        .then((value) {
      setState(() {
        _loginFuture = null;
      });
    });
  }

  void checkLoginSuccessIfNotShowDialog(bool value, BuildContext context) {
    if (value && !isReturned) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (route) => false);
    } else {
      isReturned = false;
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Something Went Wrong"),
                content: Text("Username Or Password is Wrong"),
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(width: 0.1, color: Colors.white)),
              ),
          barrierDismissible: true);
      setState(() {
        _loginFuture = null;
      });
    }
  }

  Column buildEmailPasswordAndLoginButtonFields() {
    return Column(
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
        RoundedButton(
            child: Text("Login"),
            onTap: _loginFuture == null
                ? () {
                    setState(() {
                      isAutoValidate = true;
                      if (_formKey.currentState.validate()) {
                        _loginFuture = Task.makeRequest(TaskType.Login, {
                          "username": emailController.text,
                          "password": pwController.text
                        });
                      }
                    });
                  }
                : null)
      ],
    );
  }
}
