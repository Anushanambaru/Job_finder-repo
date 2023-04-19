import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/home.dart';

class ContactInfoPage extends StatefulWidget {
  @override
  _ContactInfoPageState createState() => _ContactInfoPageState();
}

class _ContactInfoPageState extends State<ContactInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact Information'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            const Text(
            'Name',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.blueGrey,
              ),
            ),
            const Text('JOB FINDER', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black),),
            SizedBox(height: 25.0),
            const Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.blueGrey,
              ),
            ),
            const Text('jobfinder@outlook.com', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.lightBlue)),
            SizedBox(height: 25.0),
            const Text(
              'Phone',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0, color: Colors.blueGrey,
              ),
            ),
            const Text('0401234567', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),
            SizedBox(height: 25.0),

                const Text(
                  'Address',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0, color: Colors.blueGrey,
                  ),
                ),
                const Text('Fortune 9 Buildings, 6th Floor,'
                    'Somajiguda, Hyderabad,'
                    'Telangana 500082.', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black)),

            SizedBox(height: 50.0),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => JobsGrid()));
                },
                child: const Text('Back'),

            ),
              ],

        ),
    ),
        );

  }
}

