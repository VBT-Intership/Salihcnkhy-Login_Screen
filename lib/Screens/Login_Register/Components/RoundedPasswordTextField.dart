import 'package:flutter/material.dart';
import 'package:login_screen/Screens/Login_Register/Components/TextFieldContainer.dart';

class RoundedPasswordTextField extends StatefulWidget {
  final String hintText;
  const RoundedPasswordTextField({Key key, this.hintText}) : super(key: key);
  @override
  _RoundedPasswordTextFieldState createState() =>
      _RoundedPasswordTextFieldState();
}

class _RoundedPasswordTextFieldState extends State<RoundedPasswordTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
            icon: Icon(
              Icons.lock,
              color: Colors.black38,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              child: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
            ),
            border: InputBorder.none),
      ),
    );
  }
}
