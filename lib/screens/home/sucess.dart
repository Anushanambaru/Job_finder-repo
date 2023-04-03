import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/home.dart';

class SucessPage extends StatefulWidget {




  @override
  State<SucessPage> createState() => _SucessPageState();
}

class _SucessPageState extends State<SucessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Successfully Applied'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network('https://assets-global.website-files.com/5eff9c5e4dba181f8aa2d1e0/5f2b5dffc4ba860c5db10bd0_Custom-job-application-thank-you.png'),
          //
          //
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> JobsGrid()));
            },
            child: Text('Back to Jobs List'),
          )
        ],
      ),
    );
  }
}
