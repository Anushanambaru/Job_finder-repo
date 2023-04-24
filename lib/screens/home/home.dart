import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/widgets/apply.dart';
import 'package:job_finder/screens/home/widgets/formPage.dart';
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

  @override
  void initState() {
    super.initState();
    // firebaseSetup();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Job Finder'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage(buttonValue: '',)),
                );
                //action coe when button is pressed
              },
              icon: const Icon(
                Icons.notifications_active_outlined,
                size: 27,
              ),
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
                                'https://png.pngtree.com/png-vector/20190130/ourlarge/pngtree-blue-working-woman-illustration-womanbusinessoffice-png-image_591421.jpg',  )),
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
                  showDialog( barrierDismissible: false,
                      context: context, builder: (context) {
                        return AlertDialog( title: const Text("Logout"),
                          content: const Text("Are you sure you want to logout?"),
                          actions: [
                            IconButton
                              ( onPressed: () {
                              Navigator.pop(context);
                            },
                              icon: const Icon( Icons.cancel, color: Colors.red, ), ),
                            IconButton(
                              onPressed: () async {
                                await authService.signOut(context: context);
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const WelcomePage()), (route) => false); }, icon: const Icon( Icons.done, color: Colors.green, ),
                            ),
                          ],
                        );
                      }
                  );
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.exit_to_app),
                title: const Text(
                  "Logout", style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body:
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [ Column(
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
                              onPressed: () {},
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
                             if(snapshotData.connectionState == ConnectionState.waiting){
                               return const Center(
                                 child: CircularProgressIndicator(),
                               );
                             } else if(snapshotData.hasError){
                               return Text("${snapshotData.error}");
                             } else if(snapshotData.connectionState == ConnectionState.done && snapshotData.hasData){
                               return  SizedBox(
                                 width: MediaQuery.of(context).size.width*0.85,
                                 child: GridView.builder(
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
                                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ApplyPage(photo: photo, text: text, role: role, job: job, vacancy: vacancy, email: email, phone: phone, requirement: requirement, date: date,location: location,) ));
                                           },
                                         ),
                                       ),
                                     );


                                   },
                                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
}
