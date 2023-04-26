import 'package:flutter/material.dart';

import '../home.dart';

class NotificationPage extends StatefulWidget {

  @override
  State<NotificationPage> createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Notifications'),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JobsGrid()),
              );
              //action coe when button is pressed
            },
            icon: const Icon(
              Icons. arrow_back,
              size: 27,
            ),
          ),

        ),
     body: ListView.builder(
       itemCount: 20,
       itemBuilder: (context, position) {
         return Card(
           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Text(
               position.toString(),
               style: TextStyle(fontSize: 22.0),
             ),
           ),
         );
       },
     ),
    );

  }
}


