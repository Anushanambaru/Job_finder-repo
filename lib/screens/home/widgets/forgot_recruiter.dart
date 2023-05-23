import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_finder/screens/home/login.dart';
import 'package:job_finder/screens/home/widgets/recruiter_Login.dart';
import 'package:job_finder/screens/home/widgets/user_recruiter.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold( body: ResetPass(),
    );
  }
}
class ResetPass extends StatefulWidget {
  const ResetPass({super.key}); @override State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  String errormessage = ''; AutovalidateMode autovalidate = AutovalidateMode.disabled;
  final emailController = TextEditingController(); final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose(); super.dispose();
  } void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar( content: Text(text,style: const TextStyle(color: Colors.white, fontSize:15,fontWeight: FontWeight.w600,),
      ),
          backgroundColor: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.lightBlue[50],
      appBar: AppBar( leading:IconButton(icon: Icon(Icons.arrow_back, color: Colors.blueGrey[900],),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => const Recruiterpage()),
          );},),
        backgroundColor: Colors.blue.shade700,
        //title: const Text( 'Reset Password', style: TextStyle( color: Colors.black ),),
        centerTitle: true, toolbarHeight: 70,
        titleSpacing: 0.5,),
      body: SingleChildScrollView(
        child: Center(
          child: Padding( padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
            child: Form( key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding( padding: EdgeInsets.all(50.0),
                    child: Text( 'Receive an Email to Reset your Password',
                      style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey, ), ),
                  ),
                  Padding( padding: const EdgeInsets.all(10.0),
                    child: TextFormField( autovalidateMode: autovalidate,
                      validator: (mail) {
                        if (!mail.toString().contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        if (mail == null || mail.isEmpty) {
                          return 'Enter Email'; } return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration( hintText: "Enter Email ID",
                        hintStyle: TextStyle(color: Colors.blueGrey),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        prefixIcon: Icon( Icons.mail, color: Colors.lightBlue),
                        border: OutlineInputBorder( borderSide: BorderSide( color: Color(0xff018001), width: 0.1, ),
                          borderRadius: BorderRadius.only( topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                        ),
                        focusedBorder: OutlineInputBorder( borderSide: BorderSide( color: Color.fromARGB(255, 58, 107, 58),
                        ),
                          borderRadius: BorderRadius.only( topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)), ),
                      ),
                      style: const TextStyle( fontSize: 15, fontWeight: FontWeight.normal, ),
                    ),
                  ),
                  ElevatedButton( onPressed: () {
                    if (formkey.currentState!.validate()) {
                      try { Resetpassword(emailController.text);
                      showSnackBar('Email sent Successfully');
                      }
                      on FirebaseAuthException catch (e) { showSnackBar(e.message.toString()); }
                    }
                  },
                    //style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 58, 107, 58)),

                    child: const Text( 'Send Email', style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Future Resetpassword(String email) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}

