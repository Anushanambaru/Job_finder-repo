import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_finder/screens/home/home.dart';

class MyFormPage extends StatefulWidget {
   late final String? userName;
   late final String? userEmail;
  // final String? experience;
  // //String _skills = '';
  // final String? skills;
  //
   MyFormPage({
     required this.userName,
     required this.userEmail,
  //   required this.experience,
  //   required this.skills,

  });
  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  //final TextEditingController _controllerName=TextEditingController();
  // final TextEditingController  _controllerQualification =TextEditingController();
  // final TextEditingController _controllerRole =TextEditingController();
  // final TextEditingController _controllerPhone=TextEditingController();
   //final TextEditingController _controllerEmail=TextEditingController();
  // final myController =TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // String _name = '';
  //  String _email = '';
  //  String _experience = '';
  //  String _skills = '';
  //
  // @override
  // void dispose(){
  //   myController.dispose();
  //   super.dispose();
  // }






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
              //Text(widget.Username!),
              //Text(widget.userName!,style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),

              TextFormField(style: TextStyle(fontWeight: FontWeight.w700),
                initialValue: 'Anusha Nambaru',
                decoration: InputDecoration(labelText:'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                      value = widget.userName!;
                  });
                },
                // controller: myController,
              ),
              SizedBox(height: 16.0),
              TextFormField( style: TextStyle(fontWeight: FontWeight.w700),
                initialValue: 'anushanambaru.yadav@gmail.com',
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                     value = widget.userEmail! ;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(style: TextStyle(fontWeight: FontWeight.w700),
                initialValue: '1 year in Amazon, 8 months in SIDGS',
                decoration: InputDecoration(labelText: 'Experience'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter experience/fresher';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    // _experience = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(style: TextStyle(fontWeight: FontWeight.w700),
                initialValue: 'c, html5, css3, flutter, dart',
                decoration: InputDecoration(labelText: 'Skills'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your relevant skills';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    // _skills = value;
                  });
                },
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
}
