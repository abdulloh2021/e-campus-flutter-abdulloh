import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecampus/models/users.dart';
import 'package:flutter_ecampus/services/services.dart';
import 'package:flutter_ecampus/view/login_page.dart';
import 'package:flutter_ecampus/view/main/latihan_soal/home_page.dart';
import 'package:flutter_ecampus/view/main_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/r.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "spash_screen";

  @override
  Widget build(BuildContext context) {
    // Users? userProfile;
    Timer(const Duration(seconds: 5), () {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => LoginPage()));
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var emailgoogle = user.email.toString();
        var result = emailgoogle.substring(0, 8);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      dataKeyNim: result,
                    )));
      } else {
        GoogleSignIn().signOut();
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushNamed(LoginPage.route);
      }
    });

    return Scaffold(
      backgroundColor: R.colors.primary,
      body: Center(
        child: Text(
          "e-campus",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
