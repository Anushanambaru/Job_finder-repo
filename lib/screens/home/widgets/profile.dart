
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();

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
                '$name',  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),
            const SizedBox(height: 25.0),
            const Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.black54,
              ),
            ),
             Text('$userEmail', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),
            const SizedBox(height: 25.0),
            const Text(
              'Phone',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.black54,
              ),
            ),
            const Text('9090909090', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),
            const SizedBox(height: 25.0),

            const Text(
              'Designation',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.black54,
              ),
            ),
            const Text('Flutter developer', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),

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

  getEmail()async{
    var myemail = await  FirebaseAuth.instance.currentUser!.email;
    var userQuery = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: myemail).get();
    var userData = userQuery.docs[0];

    userEmail = userData['email'];
    name = userData['fullName'];
        setState(() {

        });

  }

}


