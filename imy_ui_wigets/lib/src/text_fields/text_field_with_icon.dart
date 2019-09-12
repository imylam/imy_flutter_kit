import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TextFieldWithIcon extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final Color iconColor;
  final String hintText;
  final BorderRadiusGeometry borderRadius;

  TextFieldWithIcon({
    this.controller,
    @required this.icon,
    this.iconColor = Colors.grey,
    this.hintText = "",
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: borderRadius,
      ),
//      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          Container(
            height: 30.0,
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: EdgeInsets.only(left: 0, right: 10.0),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}