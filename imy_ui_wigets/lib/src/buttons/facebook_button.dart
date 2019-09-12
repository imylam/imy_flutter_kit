import 'package:flutter/material.dart';
import 'auth_button.dart';

class FacebookButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final String text;

  FacebookButton({
    @required this.onPressed,
    this.width,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      onPressed: onPressed,
      width: width,
      text: text,
      logoPath: 'assets/facebook-logo.png',
      buttonColor: Color(0xff4267B2),
      imageBackgroundColor: null,
      textColor: Colors.white,
    );
  }
}