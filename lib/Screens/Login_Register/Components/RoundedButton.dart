import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  const RoundedButton({Key key, this.buttonText, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: FlatButton(
          onPressed: onTap,
          child: Text(buttonText),
        ),
      ),
      margin: EdgeInsets.only(top: 15),
      width: size.width * 0.8,
      height: size.height * 0.075,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 7,
            spreadRadius: 2,
            offset: Offset(2, 1),
          ),
        ],
        color: Colors.black45,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
