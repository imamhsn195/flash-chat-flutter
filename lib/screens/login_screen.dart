import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Components/navigation_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showingSpinner = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showingSpinner,
        child: SafeArea(
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
                      setState((){showingSpinner = true;});
                      try{
                        final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(user != null){
                          showingSpinner = false;
                          print("LoggedIn User: $user");
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
                        setState((){showingSpinner = false;});
                      }catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: "Failed",
                            message:  e.message ?? "Error!",
                            contentType: ContentType.failure,
                          ),
                        ));
                        setState((){showingSpinner = false;});
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
