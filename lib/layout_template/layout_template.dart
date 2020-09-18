import 'package:flutter/material.dart';
import 'package:um/Widgets/Desktop/HomePageDesktop.dart';
import 'package:um/Widgets/Desktop/NavBarDesktop.dart';
import 'package:um/Widgets/Desktop/TelegramBotPage.dart';
import 'package:um/pages/home/app_color.dart';
import 'package:um/scripts/api_client.dart';
import 'package:um/scripts/locator.dart';
import 'package:um/scripts/navigation_service.dart';

import 'package:um/scripts/route_names.dart';
import 'package:um/scripts/router.dart';

class LayoutTemplate extends StatefulWidget {
  LayoutTemplate({Key key}) : super(key: key);
  _LayoutTemplateState stateLayout = new _LayoutTemplateState();
  GlobalKey<_LayoutTemplateState> state = GlobalKey<_LayoutTemplateState>();

  @override
  _LayoutTemplateState createState() => stateLayout;

  static _LayoutTemplateState of(BuildContext context) {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: LayoutTemplate.of(context)

    assert(context != null);
    final _LayoutTemplateState result =
        // ignore: deprecated_member_use
        context.ancestorStateOfType(const TypeMatcher<_LayoutTemplateState>());

    return result;
  }
}

class _LayoutTemplateState extends State<LayoutTemplate> {
  ScrollController _scrollController = ScrollController();
  Widget body_page = TelegramBotPageDesktop();
  ListView listView = new ListView();
  NavBarDesktop navBarWidget = new NavBarDesktop();

  @override
  void initState() {
    super.initState();
  }

  Future change_page(Widget page) {
    // print('call change_page');
    setState(() {
      body_page = page;
    });
  }

  void update_navbar() {
    print('call update_navbar -> ${navBarWidget}');
    navBarWidget.navBarState.update();
  }

  @override
  Widget build(BuildContext context) {
    init_login();
    return Container(
        child: Stack(
      children: [
        Scrollbar(
          controller: _scrollController,
          isAlwaysShown: true,
          child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  body_page
                ],
              )),
        ),
        navBarWidget,
      ],
    ));
  }

  void init_login() {
    ApiClient.getInstance().checkTokenAuth().then((value) {
      navBar<NavBarDesktop>().navBarState.update();
    });
  }
}
