import 'package:flutter/material.dart';
import 'package:um/Widgets/Desktop/TelegramAccountItem.dart';
import 'package:um/pages/home/app_color.dart';

class HomePageDesktop extends StatelessWidget {
  const HomePageDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
      children: [
        TelegramAccountItem(),
      ],
    )));
  }
}
