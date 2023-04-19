import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/widgets/formPage.dart';
import 'package:job_finder/screens/home/widgets/notificationpage.dart';

class ApplyPage extends StatefulWidget {
  final String photo;
  final String text;
  final String role;
  final String job;
  final String vacancy;
  final String email;
  final String phone;
  final String requirement;
  final String date;
  final String location;




  ApplyPage({
    required this.photo,
    required this.text,
    required this.role,
    required this.job,
    required this.vacancy,
    required this.email,
    required this.phone,
    required this.requirement,
    required this.date,
    required this.location,


  });


  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(widget.text,style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
    ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(image: NetworkImage(widget.photo),width: 150,height:150,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                      'Role : ${widget.role}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        'Vacancies : ${widget.vacancy}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Location : ${widget.location}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Posted date : ${widget.date}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    const Text('Description :',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,10,0,5),
                      child: Text(widget.job,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0,10,0,10),
                      child: Text('Skills & Requirements :',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,10,0,5),
                      child: Text(widget.requirement,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0,10,0,2),
                      child: Text('Contact email :',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,10,0,8),
                      child: Text(widget.email,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.lightBlue)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyFormPage(),
            ),
          );
        },
        label:const Text('Apply'),
      ),
    );
  }
}
