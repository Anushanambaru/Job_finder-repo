import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/widgets/notificationpage.dart';
import 'package:job_finder/screens/home/widgets/profile.dart';

import '../../../service/auth_service.dart';
import 'apply.dart';

class SamplePage extends StatefulWidget {
  SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  List jobsgridlistData = [];
  bool isLoading = false;
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
     firebaseSetup();
  }

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
        SingleChildScrollView(
          child: StreamBuilder(
              stream: firebaseSetup(),
              builder: (context, snapshotData) {

                print("status : ${snapshotData.connectionState}");
                if(snapshotData.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if(snapshotData.hasError){
                  return Text("${snapshotData.error}");
                } else if(snapshotData.connectionState == ConnectionState.done && snapshotData.hasData){
                  return  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshotData.data.length,
                      itemBuilder: (context, index) {
                        final JobData = snapshotData.data[index];
                        print("Testing At Index $index : ${JobData['Company name']}");
                        final text = JobData['Company name'];
                        final photo = JobData['Photo url'].toString();
                        final role = JobData['Job_role'];
                        final phone = JobData['Phone number'];
                        final email = JobData['email'];
                        final job = JobData['Job description'];
                        final vacancy = JobData['no_of_vacancies'];
                        final  requirement = JobData['Requirements'];
                        final  date = JobData['Posted date'];
                        final location = JobData['Location'];
                        return      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0)),
                          height: 200,
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              child: Column(
                                children: [
                                  Image(image: NetworkImage(photo),height: 100,width: 200,),
                                  Text("$text")
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ApplyPage( photo: photo, role: role, job: job, vacancy: vacancy, phone: phone, requirement: requirement, date: date,location: location, email: email, name: text,) ));
                              },
                            ),
                          ),
                        );


                      },
                      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //   crossAxisCount: 2,
                      //   crossAxisSpacing: 2.0,
                      //   mainAxisSpacing: 2.0,
                      // ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }


              }),
        ),
      ),
    );
  }
  Stream? firebaseSetup() async* {
// setState(() {
//   isLoading = true;
// });

    try {
      final jobsgrid = FirebaseFirestore.instance.collection('Jobs grid');
      var getColl = await jobsgrid.get();
      jobsgridlistData = getColl.docs.map((e) => e).toList();
      print('Job Test: ${jobsgridlistData[0]['Job_role']}');

    } on FirebaseException catch (e) {
      print("Firebase catch exception: $e");
    }

    yield jobsgridlistData;
// setState(() {
//   isLoading = false;
// });

  }
}
