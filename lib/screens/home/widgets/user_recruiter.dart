import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/widgets/recruiter_Login.dart';
import '../login.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});



  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget> [
      // const Text('EFCG', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      // ),
      // const Text("ABCD",
      //   textAlign: TextAlign.center,
      //   style: TextStyle(color: Colors.blueGrey, fontSize: 15),),
      Image.asset('assests/images/welcome.png'),
      SizedBox(height: 25),
      ElevatedButton(
        onPressed: (){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Loginpage()));
        },
          child: const Text('USER'),
      ),
      SizedBox(height: 25),
      ElevatedButton(
        onPressed: (){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Recruiterpage()));
        },
        child: const Text('RECRUITER'),
      ),
    ]
    ),
    ),
    ),
    );
    }
}