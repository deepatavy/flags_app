import 'dart:io';

import 'package:flags_app/commons/constants.dart';
import 'package:flutter/material.dart';
//From Drawer boolean is used to pop out from dialog and drawer together for better ux
showExitAlertDialog(BuildContext context, {bool fromDrawer = false}) {
  AlertDialog alert = AlertDialog(
    title: Text(Constants.APP_NAME),
    content: Text("Are you sure you want to exit?"),
    actions: [
      TextButton(
        child: Text("No"),
        onPressed: () {
          if (fromDrawer) {
            Navigator.pop(context);
          }
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Text("Yes"),
        onPressed: () {
          if (fromDrawer) {
            Navigator.pop(context);
          }
          Future.delayed(const Duration(milliseconds: 500), () {
            exit(0);
          });
        },
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
