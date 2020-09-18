import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InlineButtonWidget extends StatelessWidget {
  InlineButtonWidget({Key key, this.width, this.mainChild}) : super(key: key);
  double width;
  Widget mainChild;
  Widget extraChild = SizedBox();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 30,
          child: Row(
            children: [
              extraChild,
              Flexible(
                child: Container(
                  width: width,
                  child: mainChild,
                ),
              ),
            ],
            // Expanded(child: Text('1231')),
          ),
        ),
      ),
    );
  }

  Widget getWidgetShowTextButton() {
    return GestureDetector(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 30,
          child: Icon(Icons.remove_red_eye),
        ),
      ),
    );
  }

  // Widget getSelectButtonWidget(){
  //   return
  // }

  Widget getTextEditWidget() {
    return TextFormField(
      controller: textEditingController,
      cursorColor: Colors.black,
      decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 10),
          hintText: 'Пустая кнопка'),
      textAlign: TextAlign.center,
    );
  }
}

class AddNewButtonInRow extends StatelessWidget {
  int rowIndex;
  Function callBackFunction;
  AddNewButtonInRow({Key key, this.rowIndex, this.callBackFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callBackFunction(rowIndex);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          child: Container(
            height: 30,
            width: 30,
            child: Align(
              alignment: Alignment.center,
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}

class AddNewButtonInCol extends StatelessWidget {
  AddNewButtonInCol({Key key, this.callBackFunction}) : super(key: key);
  Function callBackFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          callBackFunction();
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Card(
            child: Container(
              height: 30,
              width: 30,
              child: Align(
                alignment: Alignment.center,
                child: Icon(Icons.add),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
