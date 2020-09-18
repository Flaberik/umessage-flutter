import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:um/Widgets/Button.dart';
import 'package:um/Widgets/Desktop/TelegramBotSettings/CollapseWidget.dart';
import 'package:um/Widgets/Desktop/TelegramBotSettings/ExpandWidget.dart';
import 'package:um/Widgets/Desktop/TelegramBotSettings/BotSettingCard.dart';
import 'package:um/Widgets/Desktop/TelegramBotSettings/InlineButtonsWidget.dart';
import 'package:um/Widgets/Desktop/TelegramBotSettings/TextMessageWidget.dart';
import 'package:um/Widgets/Input.dart';
import 'package:um/scripts/locator.dart';

import '../NavBarDesktop.dart';
import 'DropDownWidget.dart';

class TelegramBotSettingsDesktop extends StatefulWidget {
  TelegramBotSettingsDesktop({Key key, this.botId}) : super(key: key);
  final int botId;

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

  bool hiddenTextMessage = false;
  // bool hiddenTitleMessage = false;
  bool inlineKeyboardSettings = false;

  bool textButtonEdit = true;
  bool callBackButton = false;
  bool deleteMarkButton = false;

  TextEditingController _textEditingController = new TextEditingController();

  List<dynamic> inlineTable = [];

  _TelegramBotSettingsDesktopState();

  int botId;

  @override
  void initState() {
    navBarHeight = navBar<NavBarDesktop>().navBarState.height;
    botId = widget.botId;
    inlineTable.add([
      new AddNewButtonInCol(
        callBackFunction: addNewButtonInCol,
      )
    ]);

    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Container(
        child: Row(
          children: [
            // Left menu
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(240, 240, 240, 1),
                border:
                    Border(right: BorderSide(color: Colors.black26, width: 1)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(200, 200, 200, 0.6),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              height: screenHeight - navBarHeight,
              width: leftMenuWidth,
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black26),
                            bottom: BorderSide(color: Colors.black26)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Навигация',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 5),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Начало'),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(child: Icon(Icons.arrow_right)),
                          ),
                        ),
                        SizedBox(width: 5)
                      ],
                    ),
                  )
                ],
              ),
            ),

            // Main Content
            Container(
              width: screenWidth - leftMenuWidth,
              height: screenHeight - navBarHeight,
              child: Column(
                children: [
                  // SizedBox(height: 1),
                  // TextMessage
                  new BotSettingCard(
                    key: UniqueKey(),
                    title: 'Текст сообщения',
                    screenWidth: screenWidth,
                    leftMenuWidth: leftMenuWidth,
                    parentState: this,
                    hidden: hiddenTextMessage,
                    updHidden: updateHiddenTextMessage,
                    child: TextMessageField(controller: _textEditingController),
                  ),
                  SizedBox(height: 10),
                  // Inline Keyboard Setting
                  BotSettingCard(
                    key: UniqueKey(),
                    title: 'Внутреннее меню',
                    screenWidth: screenWidth,
                    leftMenuWidth: leftMenuWidth,
                    parentState: this,
                    hidden: inlineKeyboardSettings,
                    updHidden: updateInlineKeyboardSettings,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 15),
                      child: renderInlineButtonsTabel(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void addNewButtonInCol() {
    List<dynamic> _copy_list = [];
    inlineTable.add([
      InlineButtonWidget(width: screenWidth),
      AddNewButtonInRow(
        callBackFunction: addNewButtonInRow,
        rowIndex: inlineTable.length - 1,
      )
    ]);
    _copy_list = inlineTable[inlineTable.length - 2];
    inlineTable[inlineTable.length - 2] = inlineTable[inlineTable.length - 1];
    inlineTable[inlineTable.length - 1] = _copy_list;

    setState(() {});
  }

  void addNewButtonInRow(int rowIndex) {
    _showMyDialog();
    return null;
    Widget _copy_widet;
    inlineTable[rowIndex].add(
        InlineButtonWidget(width: screenWidth / inlineTable[rowIndex].length));
    _copy_widet = inlineTable[rowIndex][inlineTable[rowIndex].length - 2];
    inlineTable[rowIndex][inlineTable[rowIndex].length - 2] =
        inlineTable[rowIndex][inlineTable[rowIndex].length - 1];
    inlineTable[rowIndex][inlineTable[rowIndex].length - 1] = _copy_widet;

    setState(() {});
  }

  Widget renderInlineButtonsTabel() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: 4),
                width: screenWidth - leftMenuWidth,
                child: RaisedButton(
                  disabledColor: Color.fromRGBO(200, 200, 200, 1),
                  color: Color.fromRGBO(250, 250, 250, 1),
                  onPressed: onClickTextEditButton(),
                  child: Text('Текст кнопки'),
                ),
              ),
            ),
            //
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: 5),
                width: screenWidth - leftMenuWidth,
                child: RaisedButton(
                  disabledColor: Color.fromRGBO(200, 200, 200, 1),
                  color: Color.fromRGBO(250, 250, 250, 1),
                  onPressed: onClickCallBeckButton(),
                  child: Text('Событие кнопки'),
                ),
              ),
            ),
            //
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 4),
                width: screenWidth - leftMenuWidth,
                child: RaisedButton(
                  disabledColor: Color.fromRGBO(200, 200, 200, 1),
                  color: Color.fromRGBO(255, 255, 255, 1),
                  onPressed: onClickDeleteMarkButton(),
                  child: Text('Пометить на удаление'),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          width: screenWidth - leftMenuWidth,
          height: 1,
          color: Colors.black26,
        ),
        SizedBox(height: 5),
        Column(
          children: List<Widget>.generate(
            inlineTable.length,
            (int i) {
              return Row(
                children: List<Widget>.generate(inlineTable[i].length, (int j) {
                  if (inlineTable[i][j].runtimeType == InlineButtonWidget) {
                    InlineButtonWidget inlineButtonWidget = inlineTable[i][j];
                    inlineButtonWidget.mainChild =
                        inlineButtonWidget.getTextEditWidget();

                    inlineButtonWidget.extraChild =
                        inlineButtonWidget.getWidgetShowTextButton();
                  }

                  return inlineTable[i][j];
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  String dropdownValue = 'Two';

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

  bool updateHiddenTextMessage() {
    hiddenTextMessage = !hiddenTextMessage;
    return hiddenTextMessage;
  }

  bool updateInlineKeyboardSettings() {
    inlineKeyboardSettings = !inlineKeyboardSettings;
    return inlineKeyboardSettings;
  }

  Function onClickTextEditButton() {
    if (textButtonEdit) {
      return null;
    } else {
      return () {
        textButtonEdit = !textButtonEdit;
        if (deleteMarkButton) deleteMarkButton = false;
        if (callBackButton) callBackButton = false;
        setState(() {});
      };
    }
  }

  Function onClickCallBeckButton() {
    if (callBackButton) {
      return null;
    } else {
      return () {
        callBackButton = !callBackButton;
        if (deleteMarkButton) deleteMarkButton = false;
        if (textButtonEdit) textButtonEdit = false;
        setState(() {});
      };
    }
  }

  Function onClickDeleteMarkButton() {
    if (deleteMarkButton) {
      return null;
    } else {
      return () {
        deleteMarkButton = !deleteMarkButton;
        if (textButtonEdit) textButtonEdit = false;
        if (callBackButton) callBackButton = false;
        setState(() {});
      };
    }
  }
}
