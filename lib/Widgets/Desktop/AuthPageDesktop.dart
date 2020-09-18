import 'package:flutter/material.dart';
import 'package:um/pages/home/app_color.dart';
import 'package:um/scripts/api_client.dart';
import 'package:um/scripts/locator.dart';

import '../Button.dart';
import '../Input.dart';
import 'NavBarDesktop.dart';

class AuthorizationPageDesktop extends StatefulWidget {
  AuthorizationPageDesktop({Key key}) : super(key: key);

  @override
  _AuthorizationPageDesktopState createState() =>
      _AuthorizationPageDesktopState();
}

class _AuthorizationPageDesktopState extends State<AuthorizationPageDesktop> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool rememberMe = false;
  ApiClient apiClient = ApiClient.getInstance();
  ScrollController _scrollController = ScrollController();
  PageController _pageController = PageController();

  @override
  void initState() {
    if (ApiClient.email != null) {
      rememberMe = true;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _emailController.text = 'lexa.merkylov99@gmail.com';
    _passwordController.text = 'Kool1999';

    return Center(
        child: Padding(
      padding: EdgeInsets.only(top: 150, left: 0, right: 0),
      child: Column(
        children: <Widget>[
          Text(
            'Авторизация',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: textPrimaryColor),
          ),
          SizedBox(
            height: 40,
          ),
          input(Icon(Icons.mail), 'Email', _emailController, false,
              borderRadius: 15, context: context, widthPercent: 35),
          SizedBox(
            height: 15,
          ),
          input(Icon(Icons.lock), 'Password', _passwordController, true,
              borderRadius: 15, context: context, widthPercent: 35),
          SizedBox(
            height: 5,
          ),
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              width: 460,
              child: Theme(
                  data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent),
                  child: CheckboxListTile(
                    title: Text(
                      'Запомнить меня',
                      style: TextStyle(color: textPrimaryColor),
                    ),
                    value: rememberMe,
                    onChanged: (bool value) {
                      setState(() {
                        rememberMe = value;
                      });
                    },
                  ))),
          SizedBox(
            height: 5,
          ),
          button('Войти', auth,
              context: context, borderRadius: 15, widthPercent: 35),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 460,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Пройдите ',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    Text(
                      'регистрацию, ',
                      style: TextStyle(color: linkColor, fontSize: 12),
                    ),
                    Text(
                      'если вы этого еще не сделали',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                )),
          ),
          SizedBox(height: 50),
        ],
      ),
    ));
  }

  void auth() {
    print('auth');
    ApiClient apiClient = ApiClient.getInstance();

    apiClient
        .authorization(_emailController.text, _passwordController.text)
        .then((value) {
      var state = navBar<NavBarDesktop>().navBarState;
      state.update();

      if (rememberMe) {
        apiClient.saveDataToLocalStorage(
            _emailController.text, _passwordController.text);
      } else {
        apiClient.clearDataInLocalStorage();
      }
    });
  }
}
