// import 'package:flutter_web/gestures.dart';
// import 'package:flutter_web/widgets.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class HandCursor extends Listener {
  static final appContainer =
      html.window.document.getElementById('app-container');

  HandCursor({Widget child})
      : super(
            onPointerHover: (PointerHoverEvent evt) {
              // print(evt);
              appContainer.style.cursor = 'pointer';
            },
            onPointerExit: (PointerExitEvent evt) {
              // print(appContainer.style.cursor);
              appContainer.style.cursor = 'default';
            },
            child: child);
}
