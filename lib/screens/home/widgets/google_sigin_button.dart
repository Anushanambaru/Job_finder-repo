import 'package:job_finder/screens/home/home.dart';
import 'package:job_finder/screens/home/welcome.dart';
import 'package:job_finder/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../helper_functions/helper_function.dart';
import '../../../service/database_service.dart';


class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);
  @override
  GoogleSignInButtonState createState() => GoogleSignInButtonState();
}
class GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    return Padding( padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn ?
      const CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF57C00)),
      ) : OutlinedButton( style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all( RoundedRectangleBorder( borderRadius: BorderRadius.circular(40),
        ),
        ),
      ),
        onPressed: () async {
          setState(() { _isSigningIn = true; });
          User? user = await AuthService.signInWithGoogle(context: context);
          await DatabaseService(uid: user!.uid).savingUserData(user.displayName!, user.email!);
          // saving the values to our shared preferences
          await
          HelperFunctions.saveUserLoggedInStatus(true);
          await
          HelperFunctions.saveUserEmailSF(user.email!);
          await
          HelperFunctions.saveUserNameSF(user.displayName!);
          setState(() { _isSigningIn = false; }); if (user != null) {
            Navigator.of(context).pushReplacement( MaterialPageRoute( builder: (context) => const JobsGrid(),
            ),
            );
          }
        },
        child: Padding( padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row( mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center,
            children: const [ Image( image: AssetImage('assests/images/google.png'), height: 24.0, ),
              Padding( padding: EdgeInsets.only(left: 10),
                child: Text( 'Sign in with Google', style: TextStyle( fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w600,
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
