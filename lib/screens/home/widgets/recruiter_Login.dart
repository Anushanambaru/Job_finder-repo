import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/widgets/applied_Job.dart';
import 'package:job_finder/screens/home/widgets/forgot_recruiter.dart';
import 'package:job_finder/screens/home/widgets/recruit_signup.dart';
import 'package:job_finder/screens/home/widgets/user_recruiter.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Recruiterpage  extends StatelessWidget {
  const Recruiterpage ({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold( body: Authpage(), );
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
      ), backgroundColor: color, ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea( child: Scaffold( appBar: AppBar(
      title: const Text("Login",style: TextStyle(color: Colors.black,
      ),),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        // the method which is called
        // when button is pressed
        onPressed: () {
          setState(
                () {
                  Navigator.push( context, MaterialPageRoute( builder: (context) => const MainPage(), ),
                  );
            },
          );
        },
      ),
      titleSpacing: 00.0,
      centerTitle: true,
      toolbarHeight: 60.2,
      toolbarOpacity: 0.8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25)),
      ),
      elevation: 0.00,
      backgroundColor: Colors.lightGreen
    ),
      body: Padding( padding: const EdgeInsets.fromLTRB(45, 150, 35, 0),
        child: SingleChildScrollView(
          child: Form( autovalidateMode: autoValidate, key: formkey,
            child: Column(
              children: [
                Image.network('https://cdni.iconscout.com/illustration/premium/thumb/login-4571930-3805752.png',
                ),
                TextFormField( controller: emailController, validator: (mail) {
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
                const SizedBox( width: 150, height: 15, ),
                TextFormField( autovalidateMode: autoValidate, validator: (pass) {
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
                      color: Colors.green, ),
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
                Padding( padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row( children: [ TextButton( onPressed: () {
                    Navigator.push( context, MaterialPageRoute( builder: (context) => const ForgotPage(), ),
                    );
                  },

                    style: TextButton.styleFrom(),
                    child: const Text( 'forgot Password', style: TextStyle( color: Colors.blueGrey, fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                    Padding( padding: const EdgeInsets.fromLTRB(100, 8, 0, 0),
                      child: ElevatedButton( onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                                .then((value) {
                              Navigator.push( context,
                                MaterialPageRoute(
                                  builder: (context) => AppliedJobPage(),
                                ),
                              );
                              showSnackBar( 'LogIn Successful', Colors.blue);
                            }
                            );
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
                        }
                      },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 58, 107, 58),
                        ),
                        child: const Text( 'Login', style: TextStyle( color: Colors.white, fontSize: 18, ),
                        ),
                      ),
                    ),
                  ],
                  ),
                ),
                Row(
                  children: [
                    Center(
                      child: Padding( padding: const EdgeInsets.fromLTRB(50, 30, 0, 0),
                        child: Row(
                          children: [
                            const Padding( padding: EdgeInsets.all(8.0),
                              child: Text( 'New User?',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                            TextButton( onPressed: () {
                              Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => const SignupPage(), ), );
                            },
                              style: TextButton.styleFrom(),
                              child: const Text( 'Create Account', style: TextStyle( fontSize: 18, color: Colors.blueGrey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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

