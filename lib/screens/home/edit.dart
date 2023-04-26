import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
final myController = TextEditingController();



  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  get myController => null;
  String? userEmail;
  String? name;
  @override
  void initState() {
    super.initState();
    getEmail();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: '$name',
                ),
              ),
              SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Readonly Text',
              ),
              controller: TextEditingController(text: '$userEmail'),
              readOnly: true,
            ),
              SizedBox(height: 16.0),
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Enter your Phone',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Enter your designation',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Enter your skills',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Enter your experience',
                ),
              ),
              SizedBox(height: 16.0),

              //
              //
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {},
                child: Text('update'),
              )
            ],
          ),
        ),
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
