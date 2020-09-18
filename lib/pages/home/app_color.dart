import 'package:flutter/material.dart';

// Color primaryColor = Color.fromRGBO(0, 51, 51, 1);
Color primaryColor = Color.fromRGBO(253, 253, 253, 1);
// 204
Color navBarColor = Color.fromRGBO(0, 51, 51, 0.95);

Color colorForCardItem = Color.fromRGBO(245, 245, 245, 1);

const Color textPrimaryColor = Color.fromRGBO(24, 24, 24, 1);
// Color textPrimaryColor = Color.fromRGBO(255, 255, 255, 1);
Color linkColor = Color.fromRGBO(0, 51, 255, 1);
const Color buttonPrimaryColor = Color.fromRGBO(0, 102, 204, 1);

TextStyle textStyleWithDefColor = TextStyle(color: textPrimaryColor);

// Paint foreground = Paint()..shader = shaderIcon;
final Shader shaderIcon = LinearGradient(
  colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
