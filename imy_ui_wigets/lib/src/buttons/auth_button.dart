import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final String logoPath;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final Color imageBackgroundColor;

  AuthButton({
    @required this.onPressed,
    this.width,
    @required this.logoPath,
    @required this.text,
    this.buttonColor,
    this.textColor,
    this.imageBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (text != null) {
      double logoSize = 18.0;
      return SizedBox(
        width: width,
        child: ButtonTheme(
          height: 40.0,
          padding: EdgeInsets.fromLTRB(1.0, 0.0, 8.0, 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.5),
          ),
          child: RaisedButton(
            onPressed: onPressed,
            color: buttonColor,
            elevation: 1.0,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Container(
                    height: 38.0,
                    width: 38.0,
                    decoration: BoxDecoration(
                      color: imageBackgroundColor,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                    child: Center(
                      child: Image.asset(
                        logoPath,
                        width: logoSize,
                        height: logoSize,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      double logoSize = 25.0;
      return Container(
        width: 45.0,
        height: 45.0,
        child: ButtonTheme(
          padding: EdgeInsets.all(1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: RaisedButton(
            onPressed: onPressed,
            color: buttonColor,
            elevation: 1.0,
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: Container(
                height: 38.0,
                width: 38.0,
                decoration: BoxDecoration(
                  color: imageBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Image.asset(
                    logoPath,
                    width: logoSize,
                    height: logoSize,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}