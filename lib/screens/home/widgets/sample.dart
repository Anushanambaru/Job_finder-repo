import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/widgets/notificationpage.dart';
import 'package:job_finder/screens/home/widgets/profile.dart';

class SamplePage extends StatefulWidget {
  SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  final DatabaseReference _databaseRef =
  FirebaseDatabase.instance.reference().child('items');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Job Finder'),
          centerTitle: true,
          actions: [IconButton(
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => NotificationPage()),);
              //action coe when button is pressed
            },
            icon: const Icon(Icons.notifications_active_outlined, size: 27,),
          ),
          ],),
        body:
        StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance
            .collection('city-specials')
            .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting) ?
            const Center(child: CircularProgressIndicator(),)
                : Expanded(
              child: SizedBox(height: 2,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data!.docs.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                    as Map<String, dynamic>;
                    if (data.isNotEmpty) {
                      return InkWell(
                        child: Container(width: 120,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage(data['image']),
                              fit: BoxFit.cover,
                              opacity: 0.7,),),
                          child: Column(children: [
                            const Spacer(),
                            Container(alignment: Alignment.bottomLeft,
                              child: Text(data['name'],
                                style: const TextStyle(color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,),
                              ),
                            ),
                          ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}