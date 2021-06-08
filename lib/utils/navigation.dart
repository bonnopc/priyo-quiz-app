import 'package:flutter/material.dart';

void push(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void pop(BuildContext context) {
  Navigator.pop(context);
}

void popWith(BuildContext context, bool value) {
  Navigator.pop(context, value);
}

popListener(BuildContext context, Widget screen, Function function) async {
  bool doSetState = false;
  doSetState = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
  if (doSetState == true) {
    function();
  }
}

void loaderBuilder(BuildContext context,Widget loader) {
  Navigator.of(context).push(PageRouteBuilder(
    opaque: false,
    pageBuilder: (BuildContext context, _, __) => loader,
  ));
}
