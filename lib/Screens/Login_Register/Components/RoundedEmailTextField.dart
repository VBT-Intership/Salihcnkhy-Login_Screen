import 'package:flutter/material.dart';
import 'package:login_screen/Screens/Login_Register/Components/TextFieldContainer.dart';

class RoundedEmailTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController emailController;

  const RoundedEmailTextField({Key key, this.hintText, this.emailController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: emailController,
        validator: (value) {
          if (value.isEmpty) {
            return null;
          } else if (!value.contains(RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"))) {
            return "Invalid Email";
          }
        },
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
            icon: Icon(
              Icons.person,
              color: Colors.black38,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
