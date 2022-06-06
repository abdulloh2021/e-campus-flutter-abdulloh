import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/users.dart';
import 'package:flutter_ecampus/services/services.dart';
// import 'package:flutter_ecampus/view/main/discussion/chat_page.dart';
import 'package:flutter_ecampus/view/main/dosen/dosen_page.dart';
import 'package:flutter_ecampus/view/main/jadwal/jadwal_page.dart';
// import 'package:flutter_ecampus/view/main/dashboard/home_page.dart';
import 'package:flutter_ecampus/view/main/latihan_soal/home_page.dart';
import 'package:flutter_ecampus/view/main/latihan_soal/loading_page.dart';
import 'package:flutter_ecampus/view/main/latihan_soal/mapel_page.dart';
import 'package:flutter_ecampus/view/main/nilai/nilai_page.dart';
// import 'package:flutter_ecampus/view/main/payment/payment_page.dart';
import 'package:flutter_ecampus/view/main/profile/profile_page.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  final String dataKeyNim;
  // final String dataKeySemester;
  // final String dataKeyHari;
  const MainPage({
    Key? key,
    required this.dataKeyNim,
    // required this.dataKeySemester,
    // required this.dataKeyHari
  }) : super(key: key);
  static String route = "main_page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Users? userProfile;
  void getDataUser() async {
    Users? hasilUsers =
        await Services.getUsersById(widget.dataKeyNim); //get data user
    if (hasilUsers != null) {
      setState(() {
        userProfile = hasilUsers;
      });
    }
  }

  Timer? timer;
  final _pc = PageController();
  int index = 0;
  // static final DateTime now = DateTime.now();
  // static final DateFormat formatter = DateFormat('EEEE');
  // final String Hari = formatter.format(now);

  @override
  void initState() {
    super.initState();

    /// Initialize timer for 3 seconds, it will be active as soon as intialized
    timer = Timer(
      const Duration(seconds: 2),
      () {
        /// Navigate to seconds screen when timer callback in executed
        _pc.jumpToPage(1);
      },
    );
    getDataUser();
    // _pc.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.date_range_rounded),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JadwalPage(
                        dataKeyNim: widget.dataKeyNim,
                        dataKeySemester: "${userProfile?.data?[0].semester}",
                      )));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigation(),
      body: PageView(
        controller: _pc,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LoadingPage(),
          HomePage(
            dataKeyNim: widget.dataKeyNim,
            dataKeySemester: "${userProfile?.data?[0].semester}",
            // dataKeyHari: Hari,
          ),
          //0
          DosenPage(), //1
          // ChatPage(),

          NilaiPage(
            dataKeyNim: widget.dataKeyNim,
          ), //2
          ProfilePage(
            dataKey: widget.dataKeyNim,
          ), //3
        ],
      ),
    );
  }

  Container _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Colors.black.withOpacity(0.06))
      ]),
      child: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 60,
            child: Row(children: [
              Expanded(
                child: Padding(
                  // padding: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        index = 1;
                        _pc.jumpToPage(index);
                        // _pc.animateToPage(index,
                        //     duration: Duration(milliseconds: 500),
                        //     curve: Curves.bounceInOut);
                      },
                      child: Column(
                        children: [
                          Icon(Icons.home_filled),
                          Text("Home"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        print("dosen");
                        index = 2;
                        _pc.jumpToPage(index);
                        // _pc.animateToPage(
                        //   index,
                        //   duration: Duration(milliseconds: 500),
                        //   curve: Curves.easeInOut,
                        // );
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Icon(Icons.school_rounded),
                          Text("Dosen"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    child: InkWell(
                      child: Column(
                        children: [
                          Opacity(
                            opacity: 0,
                            child: Icon(Icons.person),
                          ),
                          Text("Jadwal"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        print("nilai");
                        index = 3;
                        _pc.jumpToPage(index);
                        // _pc.animateToPage(
                        //   index,
                        //   duration: Duration(milliseconds: 500),
                        //   curve: Curves.easeInOut,
                        // );
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Icon(Icons.event_note),
                          Text("Nilai"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        print("profile");
                        index = 4;
                        _pc.jumpToPage(index);
                        // _pc.animateToPage(
                        //   index,
                        //   duration: Duration(milliseconds: 500),
                        //   curve: Curves.easeInOut,
                        // );
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Icon(Icons.person),
                          Text("Profile"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
