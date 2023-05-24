
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/edit.dart';
import 'package:job_finder/screens/home/home.dart';

class ProfilePage extends StatefulWidget {
 // final String? name;
 //  final String? emails;
  final String profileImageUrl;
 //  final String qualification;
 //  final String phone;
 // final String role;

ProfilePage({
  //  required this.name,
  // required this.emails,
  // required this.qualification,
  // required this.phone,
  required this.profileImageUrl,
  // required this.role,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final TextEditingController _controllerName=TextEditingController();
  // final TextEditingController  _controllerQualification =TextEditingController();
  // final TextEditingController _controllerRole =TextEditingController();
  // final TextEditingController _controllerPhone=TextEditingController();
  // final TextEditingController _controllerEmail=TextEditingController();




 // GlobalKey<FormState> key=GlobalKey();

 //CollectionReference _reference= FirebaseFirestore.instance.collection('Profile');

  String? userEmail;
  String? name;
  String? docId;
  String? phone;
  String? experience;
  String? skills;
  String? designation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseSetup();

  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.cyan[50],
          appBar: AppBar(
            title: const Text('User Profile'),
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
      body: SingleChildScrollView(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImageUrl),
              radius: 50,
            ),

            // SizedBox(height: 16),

            // SizedBox(height: 2),
            // Text(
            //   widget.Phone,
            //   style: TextStyle(fontSize: 16),
            // ),
      const SizedBox (height: 10),
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget> [
            const Text(
              'Name',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.black54,
              ),
            ),
              Text(
                '$name',  style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),
            const SizedBox(height: 25.0),
            const Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.black54,
              ),
            ),
             Text('$userEmail', style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),
            const SizedBox(height: 25.0),
            const Text(
              'Phone',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.black54,
              ),
            ),
             Text('${phone??"NA"}', style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),
            const SizedBox(height: 25.0),

            const Text(
              'Designation',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.black54,
              ),
            ),
             Text('${designation??"NA"}', style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),
            const SizedBox(height: 25.0),
            const Text(
              'Experience',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.black54,
              ),
            ),
            Text('${experience??"NA"}', style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),

            const SizedBox(height: 25.0),

            const Text(
              'Skills',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.black54,
              ),
            ),
            Text('${skills??"NA"}', style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),

            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) =>  EditPage()));
              },
              child: const Text('Edit'),

            ),
          ],

    )
          ]
          )
    )
    )
        ),
    );
  }

  firebaseSetup()async{
    var myemail = await  FirebaseAuth.instance.currentUser!.email;
    print("my email : $myemail");
    var userQuery = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: myemail).get();
    print("Hi Rehaman ");
    print(userQuery.docs.length);
    var userData = userQuery.docs[0];

    bool isExistinguser = userData.data().length > 8;

    userEmail = userData['email'];
    name = userData['fullName'];

    print("Nambaru : $userEmail");

    if(isExistinguser) {
      String userPhone = userData['phone'] ?? '';

        if (userPhone.isNotEmpty) {
          phone = userData['phone'];
          experience = userData['experience'];
          designation = userData['designation'];
          skills = userData['skills'];
        }

    }

    setState(() {

    });

  }

}


