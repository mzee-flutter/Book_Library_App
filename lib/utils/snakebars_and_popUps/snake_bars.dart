import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class SnakeBars {
  static flutterToast(String message) {
    Fluttertoast.showToast(msg: message);
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
