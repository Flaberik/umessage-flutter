import 'package:flutter/material.dart';
import 'package:um/pages/home/app_color.dart';

class TelegramAccountItem extends StatefulWidget {
  TelegramAccountItem({Key key}) : super(key: key);

  @override
  _TelegramAccountItemState createState() => _TelegramAccountItemState();
}

class _TelegramAccountItemState extends State<TelegramAccountItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 48,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 40, right: 40),
      margin: EdgeInsets.only(left: 100, right: 100, top: 10),
      child: Table(children: [
        TableRow(
          decoration: BoxDecoration(
            color: colorForCardItem,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Image.network(
                  'http://umessage.online/media/tg-media/photos/upload_file_oaKibYf',
                  alignment: Alignment.topLeft,
                  width: 48,
                  height: 48,
                )),
            Text('Имя'),
            Align(
              child: Container(
                color: Colors.redAccent,
                alignment: Alignment.centerRight,
                child: Icon(Icons.chat),
              ),
              alignment: Alignment.topCenter,
            ),
          ],
        )
      ]),
    );
  }
}
