import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:um/Widgets/Desktop/AuthPageDesktop.dart';
import 'package:um/Widgets/Desktop/HomePageDesktop.dart';
import 'package:um/scripts/route_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print('generateRoute: ${settings.name}');

  // PageTemplate(HomeView());
  switch (settings.name) {
    case AuthRoute:
      return _getPageRoute(AuthorizationPageDesktop());
    case HomeRoute:
      return _getPageRoute(HomePageDesktop());
    default:
      return _getPageRoute(HomePageDesktop());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
