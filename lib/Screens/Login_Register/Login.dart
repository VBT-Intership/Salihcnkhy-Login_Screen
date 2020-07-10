import 'package:flutter/material.dart';
import 'package:login_screen/Screens/Login_Register/Components/LoginForm/LoginForm.dart';
import 'package:login_screen/Screens/Login_Register/Register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  int index = 0;

  Animation<double> moveAnimation;
  Animation<double> bigSizeAnimation;
  Animation<double> smallSizeAnimation;
  AnimationController moveAnimateController;
  AnimationController sizeAnimateController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveAnimateController = AnimationController(
        reverseDuration: const Duration(milliseconds: 600),
        duration: const Duration(milliseconds: 600),
        vsync: this);
    sizeAnimateController = AnimationController(
        reverseDuration: const Duration(milliseconds: 150),
        duration: const Duration(milliseconds: 150),
        vsync: this);
    moveAnimation =
        Tween<double>(begin: 0, end: -1000).animate(moveAnimateController)
          ..addListener(() {
            setState(() {});
          });
    smallSizeAnimation =
        Tween<double>(begin: 35, end: 50).animate(sizeAnimateController)
          ..addListener(() {
            setState(() {});
          });
    bigSizeAnimation =
        Tween<double>(begin: 50, end: 35).animate(sizeAnimateController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double offsetX =
        moveAnimation.value > -size.width ? moveAnimation.value : -size.width;
    return Scaffold(
      appBar: buildAppBar(size),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Row(
            children: <Widget>[
              LoginForm(
                offsetX: offsetX,
              ),
              RegisterForm(
                offsetX: offsetX,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(Size size) {
    return PreferredSize(
      preferredSize: Size.fromHeight(size.height * 0.15),
      child: buildAppBarContainer(),
    );
  }

  Container buildAppBarContainer() {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  moveAnimateController.reverse();
                  sizeAnimateController.reverse();
                });
              },
              child: Align(
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: bigSizeAnimation.value,
                        fontFamily: "Gill Sans",
                        fontWeight: bigSizeAnimation.value == 35
                            ? FontWeight.w300
                            : FontWeight.w500),
                  ),
                  alignment: Alignment.bottomLeft),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  moveAnimateController.forward();
                  sizeAnimateController.forward();
                });
              },
              child: Align(
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: smallSizeAnimation.value,
                        fontFamily: "Gill Sans",
                        fontWeight: smallSizeAnimation.value == 35
                            ? FontWeight.w300
                            : FontWeight.w500),
                  ),
                  alignment: Alignment.bottomLeft),
            ),
          ),
        ],
      ),
    );
  }
}
