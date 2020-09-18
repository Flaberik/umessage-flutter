import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:um/Widgets/hand_cursor.dart';

class ExpandWidget extends StatelessWidget {
  const ExpandWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Row(
        children: [
          Text('Развернуть'),
          SizedBox(width: 5),
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(200, 200, 200, 0.6),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
