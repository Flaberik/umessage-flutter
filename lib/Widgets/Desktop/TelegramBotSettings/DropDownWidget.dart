import 'package:flutter/material.dart';

// class DropDownWidget extends StatelessWidget {
//   DropDownWidget({Key key, this.parentState}) : super(key: key);
//   String dropdownValue;
//   State parentState;

//   @override
//   Widget build(BuildContext context) {
//     print('call build method');
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: Icon(Icons.arrow_drop_down),
//       iconSize: 24,
//       elevation: 16,
//       style: TextStyle(color: Colors.black),
//       underline: Container(
//         height: 2,
//         color: Colors.red,
//       ),
//       onChanged: (String newValue) {
//         dropdownValue = newValue;
//         parentState.setState(() {
//           dropdownValue = newValue;
//         });
//       },
//       items:
//           <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>(
//         (String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         },
//       ).toList(),
//     );
//   }
// }

class DropDownWidget extends StatefulWidget {
  DropDownWidget({Key key, this.selects}) : super(key: key);
  List<dynamic> selects = [];

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  int dropdownValue;
  List<dynamic> selects = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selects = widget.selects;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text('Переход'),
      value: dropdownValue,
      onChanged: (value) {
        setState(() {
          dropdownValue = value;
        });
      },
      items: List.generate(selects.length, (index) {
        print(selects[index]);
        return DropdownMenuItem(
          child: Text(selects[index]['text']),
          value: index,
        );
      }),
    );
  }
}
