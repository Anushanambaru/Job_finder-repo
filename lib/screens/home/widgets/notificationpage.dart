import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/screens/home/widgets/recruiter_notification.dart';
import 'package:job_finder/screens/home/widgets/response_Page.dart';

import '../home.dart';

class NotificationPage extends StatefulWidget {

  @override
  State<RenotificationPage> createState() => _NotificationPage();
}

class _NotificationPage extends State<RenotificationPage> {
  List userListNotification = [];

  bool isExpand = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersNotifications();
  }
  void main() {
    runApp(MaterialApp(
      home: RenotificationPage(),
    ));
  }


  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    String formattedTime = DateFormat('mm').format(currentTime);
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JobsGrid()),
            );
          },
          icon: const Icon(
            Icons. arrow_back,
            size: 27,
          ),
        ),

      ),
      body: ListView.builder(
        itemCount: userListNotification.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 14,
            child: ExpansionTile( leading: Icon(Icons.message, size: 25, shadows: [],),
              title: Padding(
                padding: const EdgeInsets.all(14.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:"${userListNotification[index]['email']}"  '    $formattedTime m',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                ),
                //   "${userListNotification[index]['name']}",
                //   style: TextStyle(fontSize: 22.0),
                //
                // ,
              ),
              subtitle: Text('sucessfully applied') ,
              onExpansionChanged: (value){
                setState(() {
                  isExpand = value;
                });
              },
              children: [
                Text("${userListNotification[index]['name']} you have applied for this job", style:  TextStyle(
                  color: Colors.black,
                  fontSize: 16,),
                ),
                // Text('Current Time: $formattedTime',
                // style: TextStyle(fontSize: 24),
                // ),
              ],
            ),
          );
        },
      ),
    );

  }

  void usersNotifications() async {
    final user_Uid =  FirebaseAuth.instance.currentUser!.uid;
    final notificationSetup = await FirebaseFirestore.instance.collection("Applied_Job").where("user_id",isEqualTo: user_Uid ).get();
    userListNotification = notificationSetup.docs.map((e) => e).toList();
    setState(() {

    });
  }
}


