import 'package:flutter/material.dart';
import 'package:um/Widgets/Button.dart';
import 'package:um/Widgets/Desktop/TelegramBotSettings/TelegramBotSettings.dart';
import 'package:um/Widgets/Input.dart';
import 'package:um/Widgets/WaitingWidget.dart';
import 'package:um/layout_template/layout_template.dart';
import 'package:um/scripts/api_client.dart';

class TelegramBotPageDesktop extends StatefulWidget {
  TelegramBotPageDesktop({Key key}) : super(key: key);

  @override
  _TelegramBotPageDesktopState createState() => _TelegramBotPageDesktopState();
}

class _TelegramBotPageDesktopState extends State<TelegramBotPageDesktop> {
  TextEditingController _botTokenController = TextEditingController();
  String _addStatusInfo = "";
  Widget loadWidget = SizedBox();
  List<dynamic> botList = [];

  @override
  void initState() {
    // TODO: implement initState
    _updateBotList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // loadWidget = WaitingWidget();
    // widget_row.children.add(loadWidget);

    return Container(
        child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          renderBotList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: input(
                  Icon(Icons.vpn_key),
                  'Токен бота',
                  _botTokenController,
                  false,
                  widthPercent: 90,
                  height: 36,
                  context: context,
                ),
              ),
              SizedBox(width: 2),
              button('Добавить', () => {_addBot(_botTokenController)},
                  paddingLeft: 0,
                  widthPercent: 10,
                  context: context,
                  height: 36,
                  fontWeight: FontWeight.normal,
                  fontColor: Color.fromRGBO(0, 51, 103, 1),
                  fontSize: 14)
            ],
          ),
          Text(
            _addStatusInfo,
            style: TextStyle(color: Colors.redAccent, fontSize: 12),
          ),
          renderWaitingWidget(),
          SizedBox(
            height: 150,
          )
        ],
      ),
    ));
  }

  Widget renderWaitingWidget() {
    return loadWidget;
  }

  Widget renderBotList() {
    print(botList);
    return Column(
        children: List<Widget>.generate(botList.length, (int index) {
      return FractionallySizedBox(
          widthFactor: 0.92,
          child: Card(
            color: Colors.black12,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Text('Имя: ${botList[index]["first_name"]}'),
                  SizedBox(width: 30),
                  Text('Ник: ${botList[index]["username"]}'),
                  SizedBox(width: 25),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        child: GestureDetector(
                          onTap: () {
                            LayoutTemplate.of(context)
                                .change_page(TelegramBotSettingsDesktop(
                              botId: botList[index]['id'],
                            ));
                          },
                          child: Icon(Icons.arrow_right),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15)
                ],
              ),
            ),
          ));
    }));
  }

  void _addBot(TextEditingController controller) {
    ApiClient apiClient = ApiClient.getInstance();

    setState(() {
      loadWidget = new WaitingWidget();
    });

    apiClient.addTelegramBot(controller.text).then((value) {
      print(value);
      if (value['status'] == 'warning' || value['status'] == 'fail') {
        setState(() {
          _addStatusInfo = value['message'];
          loadWidget = new SizedBox();
        });
      }
    });
  }

  // ignore: unused_element
  void _updateBotList() {
    ApiClient.getInstance().getAllTgbot().then((value) {
      botList = value;
      setState(() {});
    });
  }
}
