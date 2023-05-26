import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/screens/home/widgets/recruiter_notification.dart';
import 'package:job_finder/screens/home/widgets/response_Page.dart';

import '../home.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List userListNotification = [];

  bool isExpand = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // usersNotifications();
  }

  void main() {
    runApp(MaterialApp(
      home: RecruiterAlertPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JobsGrid()),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 27,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: usersNotifications(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: userListNotification.length,
              itemBuilder: (context, index) {
                Timestamp timestamp = userListNotification[index]['reg_time'];
                DateTime dbTimeConverter = DateTime.fromMicrosecondsSinceEpoch(
                    timestamp.microsecondsSinceEpoch);
                String dateTime =
                    DateFormat('dd-MM-yyyy hh:mm a').format(dbTimeConverter);
                String designation = userListNotification[index]['designation'];
                String skills = userListNotification[index]['skills'];
                String experiance = userListNotification[index]['experience'];
                print(userListNotification[index]);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3.5),
                  child: Card(
                    elevation: 14,
                    // margin: EdgeInsets.symmetric(vertical: 3.5) ,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ExpansionTile(
                        leading: const Icon(
                          Icons.message,
                          size: 25,
                        ),
                        title: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${userListNotification[index]['email']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const TextSpan(
                                      text: ".",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 30)),
                                  TextSpan(
                                    text: dateTime,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                            'Applied ${userListNotification[index]['company_name']} job post sucessfully',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontSize: 16,
                            )),
                        onExpansionChanged: (value) async {
                          final docRef = userListNotification[index]
                              .reference
                              .toString()
                              .split('/')
                              .last
                              .replaceAll(')', '');

                          if (value) {
                            await FirebaseFirestore.instance
                                .collection('Applied_Job')
                                .doc(docRef)
                                .update({'is_read': true}).then(
                                    (value) => print("user read "));
                          }
                        },
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Hey ${userListNotification[index]['name']} you have applied for the job position $designation ownning skills $skills and experiance $experiance data submited to the ${userListNotification[index]['company_name']} organisation recruters team. ",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          // Text('Current Time: $formattedTime',
                          // style: TextStyle(fontSize: 24),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

   usersNotifications() async* {
    final user_Uid = FirebaseAuth.instance.currentUser!.uid;
    final notificationSetup = await FirebaseFirestore.instance
        .collection("Applied_Job")
        .where("user_id", isEqualTo: user_Uid)
        .where('is_read', isEqualTo: false)
        .orderBy('reg_time', descending: true)
        .get();
    userListNotification = notificationSetup.docs.map((e) => e).toList();
    yield userListNotification;
  }
}
