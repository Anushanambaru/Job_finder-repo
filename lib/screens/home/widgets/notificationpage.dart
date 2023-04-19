import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
final String buttonValue;
NotificationPage({required this.buttonValue});

  @override
  State<NotificationPage> createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {

  String buttonValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
    body: Text(widget.buttonValue),
    );

  }
}

// class NotificationPage extends StatelessWidget {
//   final String floatingActionButtonText;
//
//   const NotificationPage({required this.floatingActionButtonText});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Notification"),
//       ),
//       body: Center(
//         child: Text(floatingActionButtonText),
//       ),
//     );
//   }
// }
