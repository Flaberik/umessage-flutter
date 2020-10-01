import 'package:flutter/material.dart';
import 'package:um/pages/home/app_color.dart';

class NavBarItem extends StatelessWidget {
  final String title;
  // final String navigationPath;
  final Function onClick;
  const NavBarItem(this.title, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onClick();
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 18, color: textNavBarColor),
        ));
  }
}
