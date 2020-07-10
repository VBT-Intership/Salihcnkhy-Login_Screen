import 'package:flutter/material.dart';
import 'package:login_screen/Screens/Login_Register/Components/CircularLogoContainer.dart';
import 'package:login_screen/Screens/Login_Register/Components/FormBox.dart';
import 'package:login_screen/Screens/Login_Register/Components/RoundedButton.dart';
import 'package:login_screen/Screens/Login_Register/Components/RoundedEmailTextField.dart';
import 'package:login_screen/Screens/Login_Register/Components/RoundedPasswordTextField.dart';

class RegisterForm extends StatefulWidget {
  final double offsetX;

  const RegisterForm({Key key, @required this.offsetX}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
              RoundedPasswordTextField(
                hintText: "Password Again",
              ),
              RoundedButton(
                  buttonText: "Register",
                  onTap: () {
                    print("Register");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
