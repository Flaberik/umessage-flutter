import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:um/scripts/api_client.dart';

class InlineButtonWidget extends StatelessWidget {
  InlineButtonWidget(
      {Key key, this.width, this.mainChild, this.row, this.col, this.id})
      : super(key: key);
  double width;
  int row, col, id;
  Widget mainChild;
  ApiClient apiClient = ApiClient.getInstance();
  Widget extraChild = SizedBox();

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Flexible(
      child: Card(
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 30,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  width: width,
                  child: mainChild,
                ),
              ),
              savedWidget(),
            ],
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

  Widget savedWidget() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          print('${row} ${col} ${id}');
          apiClient.telegramBotAddButton(
              row: row,
              col: col,
              messageId: id,
              text: textEditingController.text);
        },
        child: Container(
          // padding: EdgeInsets.only(left: 2, right: 2),
          decoration: BoxDecoration(
            // boxShadow: [
            //   new BoxShadow(
            //     color: Color.fromRGBO(150, 150, 150, 0.2),
            //     blurRadius: 6,
            //   )
            // ],
            border: Border(
              left: BorderSide(color: Colors.black87),
            ),
          ),
          child: Icon(
            // Icons.save,
            Icons.check,
            color: Color.fromRGBO(0, 0, 255, 0.9),

            // color: const Color(0x9f00FF00),
          ),
        ),
      ),
    );
  }

  Widget getTextEditWidget() {
    return TextFormField(
      onFieldSubmitted: (value) {
        print('asd');
        return "true";
      },
      onEditingComplete: () {
        print(textEditingController.text);
      },
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
