import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/welcome.dart';


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
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Image(image: NetworkImage('https://cdn.dribbble.com/users/3499911/screenshots/16500069/media/2e3e700f8f30a9f97a896075c0bd0afc.jpg?compress=1&resize=1000x750&vertical=top')),
          )
        ],
      ),


    );
  }
}
