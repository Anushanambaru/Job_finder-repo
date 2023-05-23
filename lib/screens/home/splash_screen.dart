import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/login.dart';
import 'package:job_finder/screens/home/welcome.dart';
import 'package:job_finder/screens/home/widgets/user_recruiter.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override State<SplashPage> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(seconds: 4), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

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
              const Text("Don't  wait for the right opportunity: grab it.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey, fontSize: 15),),
              SizedBox(height: 30,),
              Image.asset('assests/images/jobs.jpg'),
              // ElevatedButton(
              //   onPressed: (){
              //     Navigator.pushReplacement(
              //         context, MaterialPageRoute(builder: (context) => const Loginpage()));
              //   },
              //     child: const Text('LOGIN'),
              //),
              SizedBox(width: 120,),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
