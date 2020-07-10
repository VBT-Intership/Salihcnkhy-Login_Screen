import 'package:flutter/material.dart';
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

class _LoginFormState extends State<LoginForm>
     {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(widget.offsetX, 0),
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBox(
            childs: <Widget>[
              CircularLogoContainer(),
              RoundedEmailTextField(
                hintText: "Your Email",
              ),
              RoundedPasswordTextField(
                hintText: "Password",
              ),
              RoundedButton(
                  buttonText: "LOGIN",
                  onTap: () {
                    setState(() {});
                  })
            ],
          ),
        ),
      ),
    );
  }
}
