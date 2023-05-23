import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_finder/screens/home/widgets/applied_Job.dart';

import '../home.dart';
class ResponsePage extends StatefulWidget {
  final myController = TextEditingController();

  @override
  State<ResponsePage> createState() => _ResponsePageState();
}
class _ResponsePageState extends State<ResponsePage> {
  final feedbackCtrl = TextEditingController();

  String? feedback;


  final _formKey = GlobalKey<FormState>();
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recruit Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResponsePage()),
              );

            },
            icon: const Icon(
              Icons.logout,
              size: 27,
            ),
          ),
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,

        child: Column(
          children: [
            SizedBox(height: 15,),
            TextFormField( style: TextStyle(fontWeight: FontWeight.w700),
               //initialValue: 'Our hiring team is currently reviewing your application',
              decoration: InputDecoration(labelText: 'Feedback'),
              controller: feedbackCtrl,
            ),

            SizedBox(
              height: 50,
            ),
            // Step 2.
            DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>['Confirmed', 'In Progress', 'On Hold', 'Rejected']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              hint: Container(
                width: 150,
                child:const Center(
                  child: Text(
                    "Select Response",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Text(
            //   'Selected Response: $dropdownValue',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            // ),
            // SizedBox(height: 15,),
            // TextFormField( style: TextStyle(fontWeight: FontWeight.w700),
            //   // initialValue: '',
            //   decoration: InputDecoration(labelText: 'Feedback'),
            //   controller: feedbackCtrl,
            // ),
            SizedBox(height: 30.0),

            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Response Sent!",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.blueGrey[700],
                  textColor: Colors.white,
                  fontSize: 19.0,
                );
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => AppliedJobPage()));
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