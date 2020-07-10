import 'package:flutter/material.dart';

class FormBox extends StatelessWidget {
  final List<Widget> childs;
  FormBox({this.childs = const []});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: buildBoxDecoration(),
      width: size.width * 0.9,
      height: size.height * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: childs,
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      boxShadow: [buildBoxShadow()],
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    );
  }

  BoxShadow buildBoxShadow() {
    return BoxShadow(
        color: Colors.black26,
        blurRadius: 6,
        spreadRadius: 0.2,
        offset: Offset(2, 1));
  }
}
