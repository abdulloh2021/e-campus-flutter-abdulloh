import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecampus/constants/R/assets.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/users.dart';
import 'package:flutter_ecampus/services/services.dart';
import 'package:flutter_ecampus/view/login_page.dart';
import 'package:flutter_ecampus/view/main/profile/pembayaran_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  final String dataKey;

  const ProfilePage({Key? key, required this.dataKey}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Users? userProfile;
  // Users? lokalProfile;
  void getDataUser() async {
    Users? hasilUsers =
        await Services.getUsersById(widget.dataKey); //get data user
    if (hasilUsers != null) {
      setState(() {
        userProfile = hasilUsers;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PembayaranPage(
                            dataKeyNim: "${userProfile?.data?[0].nim}",
                            dataKeyNama: "${userProfile?.data?[0].nama}",
                          )));
            },
            child: Icon(
              Icons.payment,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 30,
              right: 15,
              left: 15,
            ),
            decoration: BoxDecoration(
              color: R.colors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(9),
                bottomRight: Radius.circular(9),
              ),
            ),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userProfile?.data?[0].nama}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${userProfile?.data?[0].nim}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${userProfile?.data?[0].prodi}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage('${userProfile?.data?[0].foto}'),
                      // image: AssetImage(R.assets.imgUser),
                      fit: BoxFit.cover),
                ),
              ),
            ]),
          ),
          // SizedBox(height: 15),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(blurRadius: 7, color: Colors.black.withOpacity(0.25))
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 18, horizontal: 13),
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Identitas Diri"),
                // SizedBox(height: 10),
                Text(
                  "Nama Lengkap",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${userProfile?.data?[0].nama}",
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Nim",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${userProfile?.data?[0].nim}",
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Email",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${userProfile?.data?[0].email}",
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Tahun Angkatan",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${userProfile?.data?[0].angkatan}",
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Status",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${userProfile?.data?[0].status}",
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Semester",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${userProfile?.data?[0].semester}",
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 13),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 7, color: Colors.black.withOpacity(0.25))
                ],
              ),
              child: Row(children: [
                Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                SizedBox(width: 10),
                Text(
                  "Keluar",
                  style: TextStyle(
                    color: Colors.red,
                    // fontSize: 12,
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
