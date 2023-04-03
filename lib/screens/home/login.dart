import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/home.dart';
import 'package:job_finder/screens/home/forgotPassword.dart';
import 'package:job_finder/screens/home/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_finder/screens/home/reusable.dart';
import 'package:job_finder/screens/home/welcome.dart';


class Loginpage extends StatelessWidget {
  const Loginpage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold( body: Authpage());
  }
}
class Authpage extends StatefulWidget {
  const Authpage({Key? key}) : super(key: key);
  @override
  State<Authpage> createState() => _AuthpageState();
}
class _AuthpageState extends State<Authpage> {
  final formkey = GlobalKey<FormState>();
  bool passwordvisibility = true; String? errormessage = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  void showSnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar( content: Text( text, style: const TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600, ),
      ), backgroundColor: Colors.blue ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea( child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.blueGrey[900],),
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => WelcomePage()),);},),
        toolbarHeight: 70, backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form( autovalidateMode: autoValidate, key: formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,50,0,30),
                child: Logoimage('assests/images/login.webp'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField( controller: emailController, validator: (mail) {
                  if (!mail.toString().contains('@')) {
                    return 'Please Enter Valid Email';
                  }
                  if (mail == null || mail.isEmpty) {
                    return 'Enter Email';
                  }
                  return null;
                },

                  decoration: const InputDecoration( labelText: 'EmailID',
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    hintText: "Enter EmailID",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    border: OutlineInputBorder( borderSide: BorderSide( width: 0.2, ),
                      borderRadius: BorderRadius.only( topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide( color: Color(0xff018001),
                    ),
                      borderRadius: BorderRadius.only( topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                    ),
                  ),
                  style: const TextStyle( fontWeight: FontWeight.normal, fontSize: 15, ),
                ),
              ),
              const SizedBox( width: 150, height: 15, ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField( autovalidateMode: autoValidate, validator: (pass) {
                  if (pass!.length < 6) { return 'password should be min 6 letters';
                  }
                  if (pass.isEmpty) { return 'Enter Password';
                  }
                  return null;
                },
                  controller: passwordController,
                  obscureText: passwordvisibility,
                  decoration: InputDecoration( hintText: "Enter Password", hintStyle: const TextStyle(color: Colors.blueGrey),
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.blueGrey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() { passwordvisibility = !passwordvisibility; }
                        );
                      },
                      icon: Icon(passwordvisibility ? Icons.visibility_off : Icons.visibility),
                      color: Colors.blue ),
                    border: const OutlineInputBorder( borderSide: BorderSide( color: Color(0xff018001), width: 0.1, ),
                      borderRadius: BorderRadius.only( topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                    ),
                    focusedBorder: const OutlineInputBorder( borderSide: BorderSide( color: Color(0xff018001),
                    ),
                      borderRadius: BorderRadius.only( topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                  ),
                  style: const TextStyle( fontSize: 15, fontWeight: FontWeight.normal, ),
                ),
              ),
              Padding( padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row( children: [ TextButton( onPressed: () {
                  Navigator.push( context, MaterialPageRoute( builder: (context) => const ForgotPasswordPage(), ),
                  );
                },

                  style: TextButton.styleFrom(),
                  child: const Text( 'Forgot Password !', style: TextStyle( color: Colors.blueGrey, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                  Padding( padding: const EdgeInsets.fromLTRB(110, 8, 0, 0),
                    child: ElevatedButton( onPressed: () async {

                      if (formkey.currentState!.validate()) {
                        FirebaseAuth? fireConnection ;
                        try {
                         fireConnection = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                              .then((value) {
                            Navigator.push( context,
                              MaterialPageRoute(
                                builder: (context) => JobsGrid(),
                              ),
                            );
                            showSnackBar( 'LogIn Successful', Colors.lightBlue);
                          }
                          );

                         print("fire : $fireConnection");
                        }
                        on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showDialog( context: context, builder: (context) => AlertDialog( content: const Text('user-not-found'),
                              actions: [
                                TextButton( onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                            );
                          }
                          if (e.code == 'wrong-password') {
                            showDialog( context: context, builder: (context) => AlertDialog( content: const Text('wrong-password'),
                              actions: [
                                TextButton( onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                            );
                          }


                        }

                        // check inter net connectivity
                        print("Check Connectivity : ${fireConnection}");

                        // if(fireConnection == null ){
                        //   showDialog( context: context, builder: (context) => AlertDialog( content: const Text('No Internet Connection!'),
                        //     actions: [
                        //       TextButton( onPressed: () {
                        //         Navigator.of(context).pop();
                        //       },
                        //         child: const Text('OK'),
                        //       ),
                        //     ],
                        //   ),
                        //   );
                        // }
                      }

                    },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      child: const Text( 'Login', style: TextStyle( color: Colors.white, fontSize: 12, ),
                      ),
                    ),
                  ),
                ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
      context: context, builder: (context) {
    return AlertDialog( title: const Text('An Error Occured'),
      content: Text(text),
      actions: [
        TextButton( onPressed: () { Navigator.of(context).pop();
        },
          child: const Text('OK'),
        ),
      ],
    );
  }
  );
}

