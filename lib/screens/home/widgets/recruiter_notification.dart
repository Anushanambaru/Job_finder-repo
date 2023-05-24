import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/screens/home/widgets/applied_Job.dart';
import 'package:job_finder/screens/home/widgets/response_Page.dart';

import '../home.dart';

class RecruiterAlertPage extends StatefulWidget {
  const RecruiterAlertPage({super.key});


  @override
  State<RecruiterAlertPage> createState() =>_RecruiterAlertPageState();
}


class  _RecruiterAlertPageState extends State<RecruiterAlertPage> {
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
      home: RecruiterAlertPage(),
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
              MaterialPageRoute(builder: (context) => AppliedJobPage()),
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
                        text:"${userListNotification[index]['name']}"  '    $formattedTime m',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily:'Roboto',
                            fontWeight: FontWeight.normal
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
              subtitle: Text('${userListNotification[index]['email']}') ,
              onExpansionChanged: (value){
                setState(() {
                  isExpand = value;
                });
              },
              children: [
                SizedBox(height: 20,),
                Text("Name: ${userListNotification[index]['name']}", style:  TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily:'Cupertino',
                    fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 20,),
                Text("Role: ${userListNotification[index]['designation']}", style:  TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily:'Cupertino',
                    fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 20,),
                Text("Skills:${userListNotification[index]['skills']}", style:  TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily:'Cupertino',
                    fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 20,),
                Text(" Experience: ${userListNotification[index]['experience']}", style:  TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily:'Cupertino',
                    fontWeight: FontWeight.w900),
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


