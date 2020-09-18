import 'package:flutter/material.dart';
import 'package:um/Widgets/Desktop/AuthPageDesktop.dart';

import 'package:um/layout_template/layout_template.dart';
import 'package:um/pages/home/app_color.dart';
import 'package:um/scripts/api_client.dart';

import 'package:um/scripts/locator.dart';

import 'Widgets/Desktop/NavBarDesktop.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          backgroundColor: primaryColor,
          body: LayoutTemplate(),
        )
        // routes: <String, WidgetBuilder>{
        //   '/auth': (BuildContext context) => AuthorizationPageDesktop(),
        // },
        );
  }
}
