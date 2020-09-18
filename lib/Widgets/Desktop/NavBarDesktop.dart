import 'package:flutter/material.dart';
import 'package:um/Widgets/Desktop/AuthPageDesktop.dart';
import 'package:um/Widgets/Desktop/HomePageDesktop.dart';
import 'package:um/Widgets/Desktop/TelegramBotPage.dart';
import 'package:um/Widgets/NavBarItem.dart';
import 'package:um/layout_template/layout_template.dart';
import 'package:um/pages/home/app_color.dart';
import 'package:um/scripts/api_client.dart';
import 'package:um/scripts/locator.dart';

import '../gradient_text.dart';

class NavBarDesktop extends StatefulWidget {
  NavBarDesktop({Key key}) : super(key: key);
  _NavBarDesktopState navBarState;

  static _NavBarDesktopState of(BuildContext context) {
    assert(context != null);
    final _NavBarDesktopState result =
        // ignore: deprecated_member_use
        context.ancestorStateOfType(const TypeMatcher<_NavBarDesktopState>());
    return result;
  }

  @override
  _NavBarDesktopState createState() {
    navBar.registerLazySingleton(() => this);
    navBarState = _NavBarDesktopState();
    return navBarState;
  }
}

class _NavBarDesktopState extends State<NavBarDesktop> {
  String authButtonTitle = "Войти";
  double height = 50;

  // GlobalKey<_NavBarDesktopState> navBarDesktop =
  //     GlobalKey<_NavBarDesktopState>();
  @override
  void initState() {
    print('call init state navbar ${ApiClient.username}');

    super.initState();
  }

  void update() {
    setState(() {
      if (ApiClient.username != null && ApiClient.username.length > 0)
        authButtonTitle = ApiClient.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      // color: navBarColor,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromRGBO(255, 204, 0, 0.8),
          Color.fromRGBO(255, 102, 51, 0.8)
        ], // whitish to gray
        tileMode: TileMode.repeated,
      )),
      height: height,
      padding: EdgeInsets.only(left: 50, right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                LayoutTemplate.of(context).change_page(HomePageDesktop());
              },
              child: Text(
                'UM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textPrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
              )),
          Row(
            children: [
              NavBarItem(
                  'Боты',
                  () => LayoutTemplate.of(context)
                      .change_page(TelegramBotPageDesktop())),
              SizedBox(
                width: 10,
              ),
              NavBarItem(
                  authButtonTitle,
                  () => LayoutTemplate.of(context)
                      .change_page(AuthorizationPageDesktop())),
            ],
          )
        ],
      ),
    );
  }

  void auth_page_up(BuildContext context) {
    LayoutTemplate.of(context).change_page(AuthorizationPageDesktop());
  }
}
