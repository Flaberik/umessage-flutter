import 'package:flutter/material.dart';

Widget TextMessageField({TextEditingController controller}) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
    child: TextField(
      controller: controller,
      maxLines: 7,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(14),
        hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
        hintText: 'Это поле можно оставить пустым.',
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 1)),
      ),
    ),
  );
}
