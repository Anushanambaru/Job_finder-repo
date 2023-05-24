import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? ConfirmPassword;
  String? Email;
  String? errorMessage = '';
  TextEditingController emailController = TextEditingController();
  String? Password;
  TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = true;
  AutovalidateMode autovalidate = AutovalidateMode.disabled;
  TextEditingController confirmtextEditingController = TextEditingController();
  bool confirmvisibility = true;
  final formkey = GlobalKey<FormState>();
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
          backgroundColor: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Loginpage()),
              );
            },
          ),
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Form(
          key: formkey,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text(
                    'CREATE NEW ACCOUNT',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assests/images/signup.jpg.webp',
                        height: 150,
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          autovalidateMode: autovalidate,
                          controller: emailController,
                          validator: (String? mail) {
                            if (mail == null ||
                                mail.isEmpty ||
                                !mail.contains('@')) {
                              return 'Please Enter valid E-mail ID';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            Email = value!;
                          },
                          decoration: const InputDecoration(
                            labelText: "EmailId",
                            labelStyle: TextStyle(color: Colors.blueGrey),
                            hintText: "Enter EmailID",
                            hintStyle: TextStyle(color: Colors.blueGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff018001),
                                width: 0.1,
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
                      TextFormField(
                        autovalidateMode: autovalidate,
                        controller: passwordController,
                        obscureText: passwordVisibility,
                        validator: (String? pass1) {
                          if (pass1!.length < 6) {
                            return 'password should be min 6 letters';
                          }
                          if (pass1 == null || pass1.isEmpty) {
                            return 'Enter password';
                          }
                          Password = pass1;
                          return null;
                        },
                        onSaved: (value) {
                          Password = value!;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          labelText: "Password",
                          labelStyle: const TextStyle(color: Colors.blueGrey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                            icon: Icon(
                                passwordVisibility
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.blueAccent),
                          ),
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
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        width: 150,
                        height: 15,
                      ),
                      TextFormField(
                        autovalidateMode: autovalidate,
                        controller: confirmtextEditingController,
                        obscureText: confirmvisibility,
                        validator: (String? cpass) {
                          if (cpass!.length < 6) {
                            return 'password should be min 6 letters';
                          }
                          if (cpass == null || cpass.isEmpty) {
                            return 'Enter Confirm Password';
                          }
                          ConfirmPassword = cpass;
                          return null;
                        },
                        onSaved: (value) {
                          ConfirmPassword = value!;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Confirm Password",
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          labelText: "Confirm Password",
                          labelStyle: const TextStyle(color: Colors.blueGrey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                confirmvisibility = !confirmvisibility;
                              });
                            },
                            icon: Icon(confirmvisibility
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: Colors.blueAccent,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 133, 236, 133),
                              width: 0.1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff018001),
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: TextButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              if (Password == ConfirmPassword) {
                                try {
                                  autovalidate = AutovalidateMode.disabled;
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Loginpage(),
                                      ),
                                    );
                                    showSnackBar(
                                        'Account Created', Colors.green);
                                  });
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    errorMessage = e.message;
                                  });
                                  showSnackBar(
                                      errorMessage.toString(), Colors.red);
                                }
                              } else {
                                showSnackBar(
                                    'Passwords didn\'t match', Colors.red);
                                autovalidate = AutovalidateMode.always;
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text(
                            'Create',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
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
