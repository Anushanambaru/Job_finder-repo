import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/widgets/notificationpage.dart';
import 'package:job_finder/screens/home/widgets/recruiter_Login.dart';
import 'package:job_finder/screens/home/widgets/recruiter_notification.dart';
import 'package:job_finder/screens/home/widgets/user_recruiter.dart';
import '../../../service/auth_service.dart';
import 'job_response.dart';

class AppliedJobPage extends StatefulWidget {
  AppliedJobPage({super.key});

  @override
  State<AppliedJobPage> createState() => _AppliedJobPageState();
}

class _AppliedJobPageState extends State<AppliedJobPage> {
  List appliedjobsData=[];
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
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()),);
              //action coe when button is pressed
            },
            icon: const Icon(Icons.logout, size: 27,),
          ),
          actions: [IconButton(
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => RecruiterAlertPage()),);
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
                        final Applied = snapshotData.data[index];
                        print("Testing At Index $index : ${Applied['name']}");
                        final name = Applied['name'];
                        final user_id = Applied['user_id'].toString();
                        final experience = Applied['experience'];
                        final reg_time = Applied['reg_time'].toString();
                        final email = Applied['email'];
                        final skills = Applied['skills'];
                        final designation = Applied['designation'];


                        return      Container(
                          decoration: BoxDecoration( color: Colors.yellow[50],
                              borderRadius: BorderRadius.circular(15.0)),
                          height: 70,
                          child: Card(
                            color: Colors.lightBlue[50],
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text("$name", style: TextStyle(fontSize:20, fontWeight: FontWeight.w800,fontFamily: 'Raleway', fontStyle: FontStyle.italic ),)
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ResponseJob(designation: designation,name: name, email: email, user_id: user_id, experience: experience, reg_time: reg_time, skills: skills,) ));
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
      final applied = FirebaseFirestore.instance.collection('Applied_Job');
      var getColl = await applied.get();
      appliedjobsData = getColl.docs.map((e) => e).toList();
      print('Test: ${appliedjobsData[0]['name']}');
      //print('Test1: ${appliedjobsData[1]['email']}');
      // print('Test2: ${appliedjobsData[2]['user_id']}');
      // print('Test3: ${appliedjobsData[3]['experience']}');
      // print('Test4: ${appliedjobsData[4]['reg_time']}');

    } on FirebaseException catch (e) {
      print("Firebase catch exception: $e");
    }

    yield appliedjobsData;
// setState(() {
//   isLoading = false;
// });

  }
}
