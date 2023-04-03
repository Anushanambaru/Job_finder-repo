import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:job_finder/screens/home/home.dart';

class ProfilePage extends StatefulWidget {
  //final String? name;
 // final String? emails;
  final String profileImageUrl;
  //final String qualification;
  //final String Phone;

ProfilePage({
  //    this.name,
  //  this.emails,
  //  this.qualification,
  // this.Phone,
  required this.profileImageUrl,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
 final databaseRef = FirebaseDatabase.instance.ref();
 TextEditingController names = TextEditingController();
 TextEditingController email = TextEditingController();
 TextEditingController qualification = TextEditingController();
 TextEditingController Phone_Number = TextEditingController();


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
          appBar: AppBar(
            title: Text('User Profile'),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobsGrid()),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
      SizedBox (height: 10),
      Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget> [
        TextField(
           controller: names,
          decoration: InputDecoration(labelText: 'Name',
              prefixIcon: Icon(Icons.person),
              border: myInputBorder(),
            enabledBorder: myInputBorder(),
            focusedBorder: myFocusBorder()

          ),
        ),
        SizedBox(height: 10),

        TextField(
          controller: email,
          decoration: InputDecoration(labelText: 'Email Id',
            prefixIcon: Icon(Icons.email_sharp),
            border: myInputBorder(),
            enabledBorder: myInputBorder(),
            focusedBorder: myFocusBorder(),
          ),
        ),
        SizedBox(height: 10),

        TextField(
          controller: qualification,
          decoration: InputDecoration(labelText: 'Qualification',
            prefixIcon: Icon(Icons.school_sharp),
            border: myInputBorder(),
            enabledBorder: myInputBorder(),
            focusedBorder: myFocusBorder(),
          ),
        ),
        const SizedBox(height: 10),

        TextField(
          controller: Phone_Number,
          decoration: InputDecoration(labelText: 'Phone Number',
            prefixIcon: Icon(Icons.phone_android_sharp),
            border: myInputBorder(),
            enabledBorder: myInputBorder(),
            focusedBorder: myFocusBorder(),
          ),
        ),
        const SizedBox(height: 12.0),

        TextButton(
          onPressed: () async {
            final commentsUpdateData = createCommentsRecordData(
             comment1: _ProfilePageState.textController.text,
            );
            await buttonCommentsRecord.reference.update(commentsUpdateData);
            context.pop();
            },

          child: const Text('Update', style:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
          ],
        ),
      ],
    ),
      )
      ),
        ),
    );
  }

  getEmail()async{
    var myemail = await  FirebaseAuth.instance.currentUser!.email;

    email.text = myemail!;

    print('Test : $myemail');
  }

  OutlineInputBorder myInputBorder(){
    return const OutlineInputBorder(
        borderRadius:BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(
      color: Colors.blueGrey,
      width: 3,
    ),
    );
  }

  OutlineInputBorder myFocusBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: Colors.blue,
          width: 3,
        ));
  }

}
