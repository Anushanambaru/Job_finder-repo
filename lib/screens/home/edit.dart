import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_finder/screens/home/widgets/profile.dart';

class EditPage extends StatefulWidget {
  final myController = TextEditingController();

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final designationCtrl = TextEditingController();
  final experienceCtrl = TextEditingController();
  final skillsCtrl = TextEditingController();
  String? userEmail;
  String? name;
  String? docId;
  String? phone;
  String? experience;
  String? skills;
  String? designation;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  validator: errorValidate,
                  decoration: InputDecoration(
                    labelText: 'User Name',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: errorValidate,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  controller: emailCtrl,
                  readOnly: true,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: errorValidate,
                  controller: phoneCtrl,
                  decoration: InputDecoration(
                    labelText: 'Enter your Phone',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: designationCtrl,
                  validator: errorValidate,
                  decoration: InputDecoration(
                    labelText: 'Enter your designation',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: skillsCtrl,
                  validator: errorValidate,
                  decoration: InputDecoration(
                    labelText: 'Enter your skills',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: experienceCtrl,
                  validator: errorValidate,
                  decoration: InputDecoration(
                    labelText: 'Enter your experience',
                  ),
                ),
                SizedBox(height: 16.0),

                //
                //
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    Fluttertoast.showToast(
                      msg: " Updated Successfully!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 19.0,
                    );
                    if (formKey.currentState!.validate()) {
                      Map<Object, Object?> data = {
                        "phone": phoneCtrl.text,
                        "experience": experienceCtrl.text,
                        "designation": designationCtrl.text,
                        "skills": skillsCtrl.text,
                        'fullName': nameCtrl.text
                      };
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(docId!)
                          .update(data)
                          .then((value) {
                        print("User Data Updated Success");
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                    profileImageUrl:
                                        "https://png.pngtree.com/png-vector/20190130/ourlarge/pngtree-blue-working-woman-illustration-womanbusinessoffice-png-image_591421.jpg")),
                            (route) => false);
                      }).catchError((error) =>
                              print('User data Update failed Due to : $error'));
                    }
                  },
                  child: Text('update'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setUp() async {
    var myemail = await FirebaseAuth.instance.currentUser!.email;
    var userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: myemail)
        .get();
    var userData = userQuery.docs[0];

    userEmail = userData['email'];
    name = userData['fullName'];
    docId = userData['uid'];
    print('User id : $docId');
    bool isExistinguser = userData.data().length > 8;
    if(isExistinguser) {
      String userPhone = userData['phone'] ?? '';
      if (userPhone.isNotEmpty) {
        phone = userData['phone'];
        experience = userData['experience'];
        designation = userData['designation'];
        skills = userData['skills'];
      }
    }
    emailCtrl.text = userEmail!;
    nameCtrl.text = name!;
    phoneCtrl.text = phone!;
    experienceCtrl.text = experience!;
    designationCtrl.text = designation!;
    skillsCtrl.text = skills!;
    setState(() {});
  }

  String? errorValidate(String? value) {
    if (value!.isEmpty) {
      return "Required filed";
    } else {
      return null;
    }
  }
}
