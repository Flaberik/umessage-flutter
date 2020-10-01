import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:um/Widgets/Desktop/TelegramBotSettings/TelegramBotSettings.dart';
import 'package:um/scripts/api_client.dart';

import 'TelegramBotMainContent.dart';

class TelegramBotSettingsLeftMenu extends StatefulWidget {
  int botId;
  double width;
  double height;

  TelegramBotMainContent mainContent;
  List<dynamic> items;

  TelegramBotSettingsLeftMenu({
    Key key,
    this.width,
    this.height,
    this.items,
    this.botId,
    this.parentState,
  }) : super(key: key);

  TelegramBotSettingsDesktop parentState;
  State childState;

  @override
  _TelegramBotSettingsLeftMenuState createState() =>
      _TelegramBotSettingsLeftMenuState();
}

class _TelegramBotSettingsLeftMenuState
    extends State<TelegramBotSettingsLeftMenu> {
  double width;
  double height;
  ApiClient apiClient = ApiClient.getInstance();

  @override
  void initState() {
    // widget.childState = this;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.childState = this;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 240, 240, 1),
        border: Border(right: BorderSide(color: Colors.black26, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(200, 200, 200, 0.6),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      height: widget.height,
      width: widget.width,
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
            ),
          ),
          SizedBox(height: 5),
          generateListItemMenu(),
        ],
      ),
    );
  }

  Widget generateListItemMenu() {
    return Column(
      children: List<Widget>.generate(
        widget.items.length,
        (index) {
          return itemMenu(widget.items[index]);
        },
      ),
    );
  }

  Widget itemMenu(Map item) {
    return Container(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            apiClient.getTelegramBotMessage(messageId: item['id']).then(
              (value) {
                widget.parentState.state.mainContent.state
                    .updateMessageId(item['id']);
              },
            );
            // print(item['id']);
          },
          child: Row(
            children: [
              SizedBox(width: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(item['title']),
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
        ),
      ),
    );
  }

  void update() {
    setState(() {});
  }
}
