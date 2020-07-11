import 'package:flutter/material.dart';
import 'package:login_screen/Screens/Login_Register/Components/TextFieldContainer.dart';

class RoundedPasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController pwController;

  const RoundedPasswordTextField({Key key, this.hintText, this.pwController})
      : super(key: key);
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
        controller: widget.pwController,
        obscureText: isObscure,
        validator: (password) {
          Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(password))
            return 'Invalid password';
          else
            return null;
        },
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
            icon: Icon(
              Icons.lock,
              color: Colors.black38,
            ),
            suffixIconConstraints: BoxConstraints(maxHeight: 20),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              child: Icon(
                isObscure ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            border: InputBorder.none),
      ),
    );
  }
}
