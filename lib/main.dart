import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/splash_screen.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
    var fire = await Firebase.initializeApp();
  print("Rehaman Test : $fire");
  runApp(const JobFinder()
  );
}


class JobFinder extends StatelessWidget {
  const JobFinder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}