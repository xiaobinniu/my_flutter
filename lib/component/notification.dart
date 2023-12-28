import 'package:flutter/material.dart';

class CustomNotification {
  static void show(String text, NotificationType type, BuildContext context) {
    Color backgroundColor;
    IconData iconData;

    switch (type) {
      case NotificationType.success:
        backgroundColor = Colors.green;
        iconData = Icons.check_circle;
        break;
      case NotificationType.info:
        backgroundColor = Colors.blue;
        iconData = Icons.info;
        break;
      case NotificationType.error:
        backgroundColor = Colors.red;
        iconData = Icons.error;
        break;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(iconData, color: Colors.white),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

enum NotificationType {
  success,
  info,
  error,
}
