import 'package:flutter/material.dart';
import 'auth_button.dart';

class LinkedInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final String text;

  LinkedInButton({
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
      logoPath: 'assets/linkedIn-logo.png',
      imageBackgroundColor: null,
      buttonColor: Colors.white,
      textColor: Colors.black.withOpacity(0.54),
    );
  }
}