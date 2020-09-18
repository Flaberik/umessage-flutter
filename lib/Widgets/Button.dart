import 'package:flutter/material.dart';
import 'package:um/pages/home/app_color.dart';

Widget button(String label, void func(),
    {BuildContext context = null,
    double borderRadius = 0,
    double paddingLeft = 20,
    double paddingRight: 20,
    double width = 0,
    double widthPercent = 0,
    double height = 50,
    double fontSize = 16,
    Color bacground = buttonPrimaryColor,
    FontWeight fontWeight = FontWeight.bold,
    Color fontColor = textPrimaryColor}) {
  if (context != null) {
    if (widthPercent > 0 && widthPercent <= 100) {
      widthPercent = widthPercent / 100;
      if (width == 0) {
        width = widthPercent * MediaQuery.of(context).size.width;
      }
    } else {
      width = MediaQuery.of(context).size.width;
      widthPercent = 1.0;
    }

    if (width == 0) {
      width = MediaQuery.of(context).size.width;
    }
  }

  return MaterialButton(
    height: height,
    minWidth: width,
    color: Colors.black12,
    splashColor: Colors.green,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: BorderSide(color: Colors.black26),
    ),
    onPressed: () {
      func();
    },
    child: Text(label,
        style: TextStyle(
            fontWeight: fontWeight, color: fontColor, fontSize: fontSize)),
  );
}
