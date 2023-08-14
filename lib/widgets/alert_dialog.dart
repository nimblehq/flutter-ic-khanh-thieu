import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  required String message,
  required List<Widget> actions,
}) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: actions,
      ),
    );
  } else if (Platform.isAndroid) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        titleTextStyle:
            context.textTheme.labelLarge?.copyWith(color: Colors.black),
        content: Text(message),
        contentTextStyle:
            context.textTheme.labelMedium?.copyWith(color: Colors.black),
        actions: actions,
      ),
    );
  } else {
    return Future(() => {});
  }
}