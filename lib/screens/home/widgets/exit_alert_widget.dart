import 'dart:io';

import 'package:flags_app/commons/constants.dart';
import 'package:flutter/material.dart';

showExitAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text(Constants.app_name),
    content: Text("Are you sure you want to exit?"),
    actions: [
      TextButton(
        child: Text("No"),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Text("Yes"),
        onPressed: () {
          Navigator.pop(context);
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
