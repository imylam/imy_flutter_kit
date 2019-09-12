import 'package:flutter/material.dart';
import 'auth_button.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final bool darkMode;
  final String text;

  GoogleButton({
    @required this.onPressed,
    this.width,
    this.darkMode = false,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      onPressed: onPressed,
      width: width,
      logoPath: 'assets/google-logo.png',
      text: text,
      buttonColor: darkMode ? Color(0xFF4285F4) : Colors.white,
      imageBackgroundColor: darkMode ? Colors.white : null,
      textColor: darkMode ? Colors.white : Colors.black.withOpacity(0.54),
    );
  }
}