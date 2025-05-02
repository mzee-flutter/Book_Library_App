import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class SnakeBars {
  static flutterToast(String message, context) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Theme.of(context).primaryColor,
      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
      textColor: Theme.of(context).colorScheme.surface,
    );
  }

  static flutterFlashBar(String message, context) {
    Flushbar(
      messageText: Text(message),
      icon: const Icon(Icons.error),
      borderRadius: BorderRadius.circular(10),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static scaffoldMessenger(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
