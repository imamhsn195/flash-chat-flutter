import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Components/navigation_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    String email;
    String password;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.black54),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      //Do something with the user input.
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: "Enter Your Email"),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.black54),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      //Do something with the user input.
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: "Enter your Password"),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  NavigationButton(
                    buttonColor: Colors.lightBlueAccent,
                    buttonLabel: "Log In",
                    onPress: () async{
                      try{
                        final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(user != null){
                          print("LoggedIn User: $user");
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      }catch(e){
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
