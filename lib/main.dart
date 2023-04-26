import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/home.dart';
import 'package:job_finder/screens/home/splash_screen.dart';
import 'helper_functions/helper_function.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
    var fire = await Firebase.initializeApp();
  print("Rehaman Test : $fire");
  runApp( JobFinder()
  );
}


class JobFinder extends StatefulWidget {
  const JobFinder({Key? key}) : super(key: key);

  @override
  State<JobFinder> createState() => _JobFinderState();
}

class _JobFinderState extends State<JobFinder> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;

        }
        );
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? const JobsGrid() : SplashPage(),
    );
  }
}