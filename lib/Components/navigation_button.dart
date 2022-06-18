import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String buttonLabel;
  final Color buttonColor;
  final Function onPress;
  const NavigationButton({
    @required this.buttonLabel,
    @required this.buttonColor,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(buttonLabel),
        ),
      ),
    );
  }
}
