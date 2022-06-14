import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/users.dart';
import 'package:flutter_ecampus/services/services.dart';
import 'package:flutter_ecampus/view/main_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:url_encoder/url_encoder.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static const String route = "login_screen";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Users? userProfile;

  // ============== Memanggil data user dari Firebase =================
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn(); //sign in with google

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication; //get auth details

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    ); //create credential

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(credential); //sign in with credential
  }
  // ===================================================================

  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f7f8),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Text(
                R.strings.loginTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 20),
            Image.asset(R.assets.imgLoginLogo),
            SizedBox(height: 20),
            Text(
              R.strings.loginUniv,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              R.strings.loginUnivDescription,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: R.colors.greySubtitle,
              ),
            ),
            Spacer(),
            ButtonLogin(
              onTap: () async {
                await signInWithGoogle();
                final user =
                    FirebaseAuth.instance.currentUser; // user yang login
                if (user != null) {
                  var uri = user.email.toString();
                  var encoded = Uri.encodeComponent(uri);
                  Users? hasilUsers = await Services.getUsersByEmail(
                      encoded.toString()); // mengambil data user dari API
                  if (hasilUsers != null) {
                    setState(() {
                      userProfile = hasilUsers;
                      if (user.email.toString() ==
                          "${userProfile?.data?[0].email}") {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text(
                        //       "Email Api :${userProfile?.data?[0].nim}, Email Google :" +
                        //           user.email.toString()),
                        //   duration: Duration(seconds: 5),
                        // ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage(
                                      dataKeyNim:
                                          "${userProfile?.data?[0].nim.toString()}",
                                    ))); // jika email sama maka masuk ke main page
                      } else {
                        GoogleSignIn().signOut(); //sign out google
                        FirebaseAuth.instance.signOut(); //sign out firebase
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(user.email.toString() + " Tidak Terdaftar"),
                      duration: Duration(seconds: 4),
                    )); // jika email tidak terdaftar maka akan muncul snackbar
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("gagal Masuk"),
                    duration: Duration(seconds: 2),
                  )); // jika gagal masuk maka akan muncul snackbar
                }
              },
              backgroundColor: R.colors.primary,
              borderColor: R.colors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icGoogle),
                  SizedBox(width: 15),
                  Text(
                    R.strings.loginWithGoogle,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "© Copyright Abdulloh - 2022",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: R.colors.blackLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ========== Class Button Login ======================
class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    Key? key,
    required this.backgroundColor,
    required this.child,
    required this.borderColor,
    required this.onTap,
  }) : super(key: key);

  final Color backgroundColor;
  final Widget child;
  final Color borderColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: borderColor,
            ),
          ),
          fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
// ===================================================
