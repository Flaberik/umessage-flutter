import 'package:flutter/material.dart';
import 'package:um/scripts/api_client.dart';

import 'BotSettingCard.dart';
import 'InlineButtonsWidget.dart';
import 'TextMessageWidget.dart';

class TelegramBotMainContent extends StatefulWidget {
  TelegramBotMainContent(
      {Key key, this.height, this.screenWidth, this.leftMenuWidth, this.id})
      : super(key: key);

  int id;
  double height;
  double screenWidth;
  double leftMenuWidth;
  _TelegramBotMainContentState state;

  @override
  _TelegramBotMainContentState createState() => _TelegramBotMainContentState();
}

class _TelegramBotMainContentState extends State<TelegramBotMainContent> {
  ApiClient apiClient = ApiClient.getInstance();
  bool textButtonEdit = true;
  bool callBackButton = false;
  bool deleteMarkButton = false;

  bool hiddenTextMessage = false;
  bool inlineKeyboardSettings = false;

  double screenWidth;
  double leftMenuWidth;

  List<dynamic> inlineTable = [];

  TextEditingController _textEditingController = new TextEditingController();
  @override
  void initState() {
    widget.state = this;
    inlineTable.add([
      new AddNewButtonInCol(
        callBackFunction: addNewButtonInCol,
      )
    ]);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = widget.screenWidth;
    leftMenuWidth = widget.leftMenuWidth;

    if (widget.id == null) {
      return Container(
        width: screenWidth - leftMenuWidth,
        alignment: Alignment.center,
        child: Text(
          'Выберите пункт меню с лева',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32,
            color: Colors.black38,
          ),
        ),
      );
    }

    return Container(
      width: screenWidth - leftMenuWidth,
      height: widget.height,
      child: Column(
        children: [
          // TextMessage
          new BotSettingCard(
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
    );
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

  void addNewButtonInCol() {
    print(' widget.id ${widget.id}');
    List<dynamic> _copy_list = [];
    inlineTable.add([
      InlineButtonWidget(
        width: screenWidth,
        col: 0,
        row: inlineTable.length - 1,
        id: widget.id,
      ),
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
    Widget _copy_widet;
    inlineTable[rowIndex].add(InlineButtonWidget(
        id: widget.id,
        width: screenWidth,
        row: rowIndex,
        col: inlineTable[rowIndex].length - 1));
    _copy_widet = inlineTable[rowIndex][inlineTable[rowIndex].length - 2];
    inlineTable[rowIndex][inlineTable[rowIndex].length - 2] =
        inlineTable[rowIndex][inlineTable[rowIndex].length - 1];
    inlineTable[rowIndex][inlineTable[rowIndex].length - 1] = _copy_widet;

    setState(() {});
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

  void updateMessageId(int id) {
    widget.id = id;
    apiClient
        .getTelegramBotMessage(messageId: id)
        .then((value) => print(value));
    setState(() {});
  }
}
