import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flash_chat/Components/navigation_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = '/registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children : [
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
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
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
                    buttonColor: Colors.blueAccent,
                    buttonLabel: "Register",
                    onPress: () async {
                      try {
                        final _auth = FirebaseAuth.instance;
                        UserCredential userCredential = await
                        _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        if (userCredential != null) {
                          print("Current User: $userCredential");
                          Navigator.pushNamed(context, ChatScreen.id);
                          var snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Success!',
                              message:
                              'Welcome ${_auth.currentUser.email}!',
                              contentType: ContentType.success,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } catch (e) {
                        print(e);
                        var snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Failed!',
                            message:
                            e.message,
                            contentType: ContentType.failure,
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
              ],
            ),
          ),],
        ),
      ),
    );
  }
}
