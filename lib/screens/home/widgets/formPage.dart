import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home.dart';

class MyFormPage extends StatefulWidget {
  final myController = TextEditingController();

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController designationCtrl = TextEditingController();
  TextEditingController experienceCtrl = TextEditingController();
  TextEditingController skillsCtrl = TextEditingController();


  String? userEmail;
  String? name;
  String? docId;
  String? phone;
  String? experience;
  String? skills;
  String? designation;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setUp();

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Form Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField( style: TextStyle(fontWeight: FontWeight.w700),
                  // initialValue: 'Anusha',
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: nameCtrl,
                  validator: errorValidate,

                ),
                SizedBox(height: 16.0),

                TextFormField( style: TextStyle(fontWeight: FontWeight.w700),
                  // initialValue: '',
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: emailCtrl,
                  validator: errorValidate,

                ),
                SizedBox(height: 16.0),

                TextFormField( style: TextStyle(fontWeight: FontWeight.w700),
                  //initialValue: '',
                  decoration: InputDecoration(labelText: 'Designation'),
                  controller: designationCtrl,
                  validator: errorValidate,

                ),
                SizedBox(height: 16.0),

                TextFormField( style: TextStyle(fontWeight: FontWeight.w700),
                  //initialValue: '',
                  decoration: InputDecoration(labelText: 'Experience'),
                  controller: experienceCtrl,
                  validator: errorValidate,

                ),
                SizedBox(height: 16.0),

                TextFormField( style: TextStyle(fontWeight: FontWeight.w700),
                  //initialValue: '',
                  decoration: InputDecoration(labelText: 'Skills'),
                  controller: skillsCtrl,
                  validator: errorValidate,

                ),
                SizedBox(height: 20.0),

                ElevatedButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: "Successfully applied!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.blueGrey[700],
                      textColor: Colors.white,
                      fontSize: 19.0,
                    );
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => JobsGrid()));

                    appliedJobSetup();
                  },
                  child: Text("Submit"),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> setUp()async{
    var myemail = await  FirebaseAuth.instance.currentUser!.email;
    var userQuery = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: myemail).get();
    var userData = userQuery.docs[0];

    userEmail = userData['email'];
    name = userData['fullName'];
    docId = userData['uid'];
    print('User id : $docId');
    String userPhone = userData['phone']??'';
    if(userPhone.isNotEmpty){
      phone = userData['phone'];
      experience = userData['experience'];
      designation = userData['designation'];
      // print('user designation : $designation');
      skills = userData['skills'];
    }
    emailCtrl.text =userEmail!;
    nameCtrl.text = name!;
    phoneCtrl.text = phone!;
    experienceCtrl.text = experience!;
    designationCtrl.text = designation!;
    skillsCtrl.text = skills!;
    setState(() {

    });

  }

  String? errorValidate(String? value){
    if(value!.isEmpty){
      return "Required field";
    } else{
      return null;
    }
  }
  appliedJobSetup() async{

    Map<String,dynamic> data = {
      'name' : nameCtrl.text,
      'email' : emailCtrl.text,
      'experience' : experienceCtrl.text,
      'skills' : skillsCtrl.text,
      'reg_time' : DateTime.now(),
      'user_id' : docId!,
      'designation' :designationCtrl.text,
      // 'company_name' :
    };

    final  uploadData =  await FirebaseFirestore.instance.collection('Applied_Job').add(data);

    if(uploadData.id != null && uploadData.id != ''){
      print("Data uploadded Success");
    } else {
      print('Upload Failed');
    }



  }
}