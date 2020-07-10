import 'package:flutter/material.dart';
import 'package:login_screen/Screens/Login_Register/Components/TextFieldContainer.dart';

class RoundedEmailTextField extends StatelessWidget {
  final String hintText;
  const RoundedEmailTextField({Key key, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle( color: Colors.black38, fontSize: 15),
            icon: Icon(
              Icons.person,
              color: Colors.black38,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
