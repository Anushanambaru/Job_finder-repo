import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/login.dart';
import 'package:job_finder/screens/home/sign_up.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});



  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
    child: Container(
width: double.infinity,
height: MediaQuery.of(context).size.height,
padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>  [
   const Text('Welcome', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
),
  const Text("Don't  wait for the right opportunity: create it.",
  textAlign: TextAlign.center,
  style: TextStyle(color: Colors.blueGrey, fontSize: 15),),
  Image.asset('assests/images/welcome.png'),
  ElevatedButton(
    onPressed: (){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Loginpage()));
    },
      child: const Text('LOGIN'),
  ),
  const SizedBox(width: 120,),
  ElevatedButton(
    onPressed: (){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const CreateAccount()));
    },
    child: const Text('Create New User'),
  ),
],
),
      ),
),
    );
  }
}
