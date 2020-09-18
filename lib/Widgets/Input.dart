import 'package:flutter/material.dart';
import 'package:um/pages/home/app_color.dart';

Widget input(
    Icon icon, String hint, TextEditingController controller, bool obscure,
    {double height = 50,
    double width = 0,
    double paddingLeft = 20,
    double paddingRight = 20,
    BuildContext context,
    double borderRadius = 0,
    double widthPercent = 100,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600}) {
  if (context != null) {
    if (widthPercent > 0 && widthPercent <= 100) {
      widthPercent = widthPercent / 100;
      if (width == 0) {
        width = MediaQuery.of(context).size.width;
      }
    } else {
      width = MediaQuery.of(context).size.width;
      widthPercent = 1.0;
    }

    if (width == 0) {
      width = MediaQuery.of(context).size.width;
    }
  }

  return FractionallySizedBox(
    widthFactor: widthPercent,
    child: Container(
      padding: EdgeInsets.zero,
      width: width,
      height: height,
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: fontSize, color: textPrimaryColor),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: const EdgeInsets.only(bottom: 0),
          hintStyle: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: Colors.black54),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.black, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.black54, width: 1)),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: IconTheme(
              data: IconThemeData(color: Colors.black54),
              child: icon,
            ),
          ),
        ),
      ),
    ),
  );
}
