import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flash_chat/Components/navigation_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.green, end: Colors.blueGrey)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: Image.asset('images/logo.png'),
                  height: 60.0,
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('Flash Chat'),
                    ],
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            NavigationButton(
              buttonLabel: 'Log In',
              buttonColor: Colors.lightBlueAccent,
              onPress: () {
                //Go to registration screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            NavigationButton(
                buttonLabel: 'Register',
                buttonColor: Colors.blueAccent,
                onPress: () {
                  //Go to registration screen.
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
