import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/screens/home/home.dart';
import 'package:job_finder/screens/home/forgotPassword.dart';
import 'package:job_finder/screens/home/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_finder/screens/home/reusable.dart';
import 'package:job_finder/screens/home/widgets/commonWidgets.dart';
import 'package:job_finder/screens/home/widgets/recruiter_Login.dart';
import 'package:job_finder/screens/home/widgets/google_sigin_button.dart';
import 'package:job_finder/screens/home/widgets/user_recruiter.dart';

import '../../helper_functions/helper_function.dart';
import '../../service/auth_service.dart';
import '../../service/database_service.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Authpage());
  }
}

class Authpage extends StatefulWidget {
  const Authpage({Key? key}) : super(key: key);
  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  final formkey = GlobalKey<FormState>();
  bool passwordvisibility = true;
  String? errormessage = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthService authService = AuthService();
  String email = "";
  String password = "";
// final DatabaseReference _loginRef = FirebaseDatabase.instance.reference().child('login_details');

  void showSnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.blue),
    );
  }

// void storeLoginDetails(String userId, String email) {
// _loginRef.push().set({
// 'user_id': userId,
// 'email': email,
// 'timestamp': ServerValue.timestamp,
// });
// }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
// the method which is called
// when button is pressed
            onPressed: () {
              setState(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ),
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
          backgroundColor: Colors.lightBlue[50],
        ),
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: autoValidate,
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: Logoimage('assests/images/login.webp'),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: emailController,
                    validator: (mail) {
                      if (!mail.toString().contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      if (mail == null || mail.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'EmailID',
                      labelStyle: TextStyle(color: Colors.blueGrey),
                      hintText: "Enter EmailID",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff018001),
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 150,
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    autovalidateMode: autoValidate,
                    validator: (pass) {
                      if (pass!.length < 6) {
                        return 'password should be min 6 letters';
                      }
                      if (pass.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: passwordvisibility,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintStyle: const TextStyle(color: Colors.blueGrey),
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.blueGrey),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordvisibility = !passwordvisibility;
                            });
                          },
                          icon: Icon(passwordvisibility
                              ? Icons.visibility_off
                              : Icons.visibility),
                          color: Colors.blue),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff018001),
                          width: 0.1,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff018001),
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(15)),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                      validator: (val) { if (val!.length < 6) {
                      return "Password must be at least 6 characters"; } else { return null; } },
                    onChanged: (val) { setState(() { password = val; }); },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(),
                        child: const Text(
                          'Forgot Password !',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(110, 8, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 25, 0, 10),
                  child: FutureBuilder(
                    future: AuthService.initializeFirebase(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error initializing Firebase');
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return const GoogleSignInButton();
                      }
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFF57C00),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 10, 10),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateAccount()));
                  },
                  child: const Text('Create New User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          print(value);
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
// saving the values to our shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          nextScreenReplace(context, const JobsGrid());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('An Error Occured'),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
}
