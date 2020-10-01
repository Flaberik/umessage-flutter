import 'package:flutter/material.dart';

import 'package:um/Widgets/Desktop/TelegramBotSettings/TelegramBotMainContent.dart';
import 'package:um/Widgets/Desktop/TelegramBotSettings/TelegramBotSettingsLeftMenu.dart';

import 'package:um/scripts/api_client.dart';
import 'package:um/scripts/locator.dart';

import '../NavBarDesktop.dart';
import 'DropDownWidget.dart';

class TelegramBotSettingsDesktop extends StatefulWidget {
  TelegramBotSettingsDesktop({Key key, this.botId}) : super(key: key);
  final int botId;
  _TelegramBotSettingsDesktopState state;

  @override
  _TelegramBotSettingsDesktopState createState() =>
      _TelegramBotSettingsDesktopState();
}

class _TelegramBotSettingsDesktopState
    extends State<TelegramBotSettingsDesktop> {
  double navBarHeight;
  double leftMenuWidth = 200;

  double screenWidth;
  double screenHeight;

  ApiClient apiClient = ApiClient.getInstance();
  bool hiddenTextMessage = false;

  bool inlineKeyboardSettings = false;

  bool textButtonEdit = true;
  bool callBackButton = false;
  bool deleteMarkButton = false;

  TextEditingController _textEditingController = new TextEditingController();

  List<dynamic> inlineTable = [];

  _TelegramBotSettingsDesktopState();

  int botId;

  TelegramBotSettingsLeftMenu leftMenu;
  TelegramBotMainContent mainContent;
  List<dynamic> messages;

  @override
  void initState() {
    widget.state = this;
    navBarHeight = navBar<NavBarDesktop>().navBarState.height;
    botId = widget.botId;
    apiClient.botId = botId;
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    // mainContent = Container(
    //   width: screenWidth - leftMenuWidth,
    //   alignment: Alignment.center,
    //   child: Text(
    //     'Выберите пункт меню с лева',
    //     style: TextStyle(
    //       fontWeight: FontWeight.w600,
    //       fontSize: 32,
    //       color: Colors.black38,
    //     ),
    //   ),
    // );
    mainContent = TelegramBotMainContent(
      height: screenHeight - navBarHeight,
      screenWidth: screenWidth,
      leftMenuWidth: leftMenuWidth,
    );

    leftMenu = TelegramBotSettingsLeftMenu(
      height: screenHeight - navBarHeight,
      width: leftMenuWidth,
      items: [],
      botId: botId,
      parentState: widget,
    );

    apiClient.getTelegramBotMessage().then((value) {
      messages = value;
      leftMenu.items = messages;
      print('$leftMenu, ${leftMenu.childState}');
      // leftMenu.createState().setState(() {});
      leftMenu.childState.setState(() {});
    });

    return Container(
      child: Container(
        child: Row(
          children: [
            // Left menu
            leftMenu,

            // Main Content
            getMainContentWidget(),
          ],
        ),
      ),
    );
  }

  String dropdownValue = 'Two';

  Widget getMainContentWidget() {
    print(mainContent);
    return mainContent;
  }

  Widget getDropDown() {}

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Создание новой кнопки'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  width: (screenWidth - leftMenuWidth) / 2,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Текст кнопки'),
                  ),
                  // getDropDown(),
                ),
                DropDownWidget(selects: [
                  {'id': -1, 'text': 'Пусто'}
                ]),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updateMainContent(int id) {
    mainContent = TelegramBotMainContent(
      height: screenHeight - navBarHeight,
      screenWidth: screenWidth,
      leftMenuWidth: leftMenuWidth,
      id: id,
    );
    print('update updateMainContent');
    setState(() {});
  }
}
