import 'package:flutter/material.dart';

class NotificationService {
  // static late GlobalKey<ScaffoldState> messengerKey =
  //     GlobalKey<ScaffoldState>();

  static showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    ));

    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
