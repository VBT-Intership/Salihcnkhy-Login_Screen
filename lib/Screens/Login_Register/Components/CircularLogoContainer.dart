import 'package:flutter/material.dart';

class CircularLogoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: ExactAssetImage("assets/logo.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
