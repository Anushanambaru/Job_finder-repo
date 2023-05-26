import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/login.dart';
import 'package:job_finder/screens/home/widgets/applied_Job.dart';
import 'package:job_finder/screens/home/widgets/apply.dart';
import 'package:job_finder/screens/home/widgets/formPage.dart';
import 'package:job_finder/screens/home/widgets/sample.dart';
import 'package:job_finder/screens/home/widgets/user_recruiter.dart';
import '../../service/auth_service.dart';
import 'welcome.dart';
import 'package:job_finder/screens/home/widgets/contact.dart';
import 'package:job_finder/screens/home/widgets/notificationpage.dart';
import 'package:job_finder/screens/home/widgets/profile.dart';

class JobsGrid extends StatefulWidget {
  const JobsGrid({Key? key}) : super(key: key);

  @override
  State<JobsGrid> createState() => _JobsGridState();
}

class _JobsGridState extends State<JobsGrid> {
  List jobsgridlistData = [];
  bool isLoading = false;
  AuthService authService = AuthService();
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    // firebaseSetup();
    notificationLength();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Job Finder'),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()),
                    );
                    //action coe when button is pressed
                  },
                  icon: const Icon(
                    Icons.notifications_active_outlined,
                    size: 27,
                    color: Colors.red,
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 5,
                  child: Badge(
                    largeSize: 13,
                    smallSize: 10,
                    alignment: AlignmentDirectional.center,
                    backgroundColor: Colors.transparent,
                    child: Text(
                      "$notificationCount",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              
              ],
            ),
           SizedBox(
                  width: 10,
                ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assests/images/woman.png'),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: .120),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(' Profile '),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              profileImageUrl:
                                  'https://png.pngtree.com/png-vector/20190130/ourlarge/pngtree-blue-working-woman-illustration-womanbusinessoffice-png-image_591421.jpg',
                            )),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_phone_outlined),
                title: const Text(' Contact us '),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactInfoPage()),
                  );
                },
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Logout"),
                          content:
                              const Text("Are you sure you want to logout?"),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await authService.signOut(context: context);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const MainPage()),
                                    (route) => false);
                              },
                              icon: const Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        );
                      });
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.exit_to_app),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.local_post_office_outlined),
                title: const Text(' Recruiter '),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppliedJobPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        //prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SamplePage()),
                            );
                            //action coe when button is pressed
                          },
                        ),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              StreamBuilder(
                  stream: firebaseSetup(),
                  builder: (context, snapshotData) {
                    print("status : ${snapshotData.connectionState}");
                    if (snapshotData.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshotData.hasError) {
                      return Text("${snapshotData.error}");
                    } else if (snapshotData.connectionState ==
                            ConnectionState.done &&
                        snapshotData.hasData) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshotData.data.length,
                          itemBuilder: (context, index) {
                            final JobData = snapshotData.data[index];
                            print(
                                "Testing At Index $index : ${JobData['Company name']}");
                            final text = JobData['Company name'];
                            final photo = JobData['Photo url'].toString();
                            final role = JobData['Job_role'];
                            final phone = JobData['Phone number'];
                            final email = JobData['email'];
                            final job = JobData['Job description'];
                            final vacancy = JobData['no_of_vacancies'];
                            final requirement = JobData['Requirements'];
                            final date = JobData['Posted date'];
                            final location = JobData['Location'];
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0)),
                              height: 200,
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      Image(
                                        image: NetworkImage(photo),
                                        height: 100,
                                        width: 200,
                                      ),
                                      Text("$text")
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ApplyPage(
                                                  photo: photo,
                                                  role: role,
                                                  job: job,
                                                  vacancy: vacancy,
                                                  phone: phone,
                                                  requirement: requirement,
                                                  date: date,
                                                  location: location,
                                                  email: email,
                                                  name: text,
                                                )));
                                  },
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                          ),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          ),
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

  void notificationLength() async {
    final user_Uid = FirebaseAuth.instance.currentUser!.uid;
    final notificationSetup = await FirebaseFirestore.instance
        .collection("Applied_Job")
        .where("user_id", isEqualTo: user_Uid).where("is_read",isEqualTo: false)
        .get();
    notificationCount = notificationSetup.docs.length;
    setState(() {});
  }
}
