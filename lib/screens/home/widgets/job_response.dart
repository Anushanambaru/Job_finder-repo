import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_finder/screens/home/widgets/applied_Job.dart';
import 'package:job_finder/screens/home/widgets/formPage.dart';
import 'package:job_finder/screens/home/widgets/notificationpage.dart';

class ResponseJob extends StatefulWidget {
  final myController = TextEditingController();

  final String name;
  final String email;
  final String user_id;
  final String experience;
  final String reg_time;
  final String skills;
  final String designation;

  ResponseJob({
    required this.name,
    required this.email,
    required this.user_id,
    required this.experience,
    required this.reg_time,
    required this.skills,
    required this.designation,


  });

  @override
  State<ResponseJob> createState() => _ResponseJobState();
}

class _ResponseJobState extends State<ResponseJob> {

  final feedbackCtrl = TextEditingController();

  String? feedback;


  final _formKey = GlobalKey<FormState>();
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(widget.name,style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Name : ${widget.name}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Email : ${widget.email}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Skills : ${widget.skills}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Role : ${widget.designation}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            ' Experience: ${widget.experience}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(6.0),
                        //   child: Text(
                        //     'User_ID : ${widget.user_id}',
                        //     style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Date : ${widget.reg_time}',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text('Description :',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(5,10,0,5),
                    //   child: Text(widget.job,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.fromLTRB(0,10,0,10),
                    //   child: Text('Skills & Requirements :',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(5,10,0,5),
                    //   child: Text(widget.requirement,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.fromLTRB(0,10,0,2),
                    //   child: Text('Contact email :',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(5,10,0,8),
                    //   child: Text(widget.email,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.lightBlue)),
                    // ),

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
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   isExtended: true,
      //   backgroundColor: Colors.blue,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => MyFormPage()
      //       ),
      //     );
      //   },
      //   label:const Text('Apply'),
      // ),
    );
  }
}
