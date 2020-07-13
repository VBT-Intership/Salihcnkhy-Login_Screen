
import 'package:flutter/material.dart';
import 'package:login_screen/Screens/Login_Register/Components/LoginForm/LoginForm.dart';
import 'package:login_screen/Screens/Login_Register/Components/RegisterForm/RegisterForm.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
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
        duration: const Duration(milliseconds: 450), vsync: this);
    sizeAnimateController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    moveAnimation = Tween<double>(begin: 0, end: -1000).animate(CurvedAnimation(
        parent: moveAnimateController, curve: Curves.easeInToLinear))
      ..addListener(() {
        setState(() {});
      });
    smallSizeAnimation = Tween<double>(begin: 30, end: 45).animate(
        CurvedAnimation(
            parent: sizeAnimateController, curve: Curves.linearToEaseOut))
      ..addListener(() {
        setState(() {});
      });
    bigSizeAnimation = Tween<double>(begin: 45, end: 30).animate(
        CurvedAnimation(
            parent: sizeAnimateController, curve: Curves.linearToEaseOut))
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
      body: buildBody(offsetX),
    );
  }

  SingleChildScrollView buildBody(double offsetX) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: buildLoginAndRegisterPages(offsetX),
    );
  }

  SingleChildScrollView buildLoginAndRegisterPages(double offsetX) {
    return SingleChildScrollView(
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
          AppBarButtonTitle(
            title: "LOGIN",
            fontValue: bigSizeAnimation.value,
            onTap: () {
              setState(() {
                moveAnimateController.reverse();
                sizeAnimateController.reverse();
              });
            },
          ),
          Spacer(),
          AppBarButtonTitle(
            title: "REGISTER",
            fontValue: smallSizeAnimation.value,
            onTap: () {
              setState(() {
                moveAnimateController.forward();
                sizeAnimateController.forward();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    moveAnimateController.dispose();
    sizeAnimateController.dispose();
  }
}

class AppBarButtonTitle extends StatelessWidget {
  const AppBarButtonTitle(
      {Key key,
      @required this.title,
      @required this.fontValue,
      @required this.onTap})
      : super(key: key);

  final String title;
  final double fontValue;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Align(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black38,
                fontSize: fontValue,
                fontFamily: "Gill Sans",
                fontWeight:
                    fontValue == 35 ? FontWeight.w300 : FontWeight.w500),
          ),
          alignment: Alignment.bottomLeft,
        ),
      ),
    );
  }
}
