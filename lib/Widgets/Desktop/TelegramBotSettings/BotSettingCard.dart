import 'package:flutter/material.dart';

import 'CollapseWidget.dart';
import 'ExpandWidget.dart';

class BotSettingCard extends StatelessWidget {
  bool hidden;
  Function updHidden;
  double screenWidth;
  double leftMenuWidth;
  State parentState;
  String title;
  Widget child;
  // Function hiddenSet;
  BotSettingCard({
    Key key,
    this.screenWidth,
    this.leftMenuWidth,
    this.title,
    this.updHidden,
    this.hidden,
    this.parentState,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // print(hidden);

    return Card(
      color: Color.fromRGBO(235, 235, 235, 1),
      child: Container(
        width: screenWidth - leftMenuWidth - 20,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(title),
                  ),
                  GestureDetector(
                      onTap: () {
                        updHidden();
                        // hidden = updHidden();
                        parentState.setState(() {});
                      },
                      child: new _triggerSettingCard(
                        hidden: hidden,
                      ))
                ],
              ),
            ),
            getActivWidget(),
          ],
        ),
      ),
    );
  }

  Widget getActivWidget() {
    if (hidden) {
      return new SizedBox();
    } else {
      return child;
    }
  }

  // Widget triggerSettingCard() {}
}

class _triggerSettingCard extends StatelessWidget {
  _triggerSettingCard({this.hidden});
  bool hidden;

  @override
  Widget build(BuildContext context) {
    if (hidden) {
      return ExpandWidget();
    } else {
      return CollapseWidget();
    }
  }
}
