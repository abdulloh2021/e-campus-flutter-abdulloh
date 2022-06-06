import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecampus/firebase_options.dart';
import 'package:flutter_ecampus/view/login_page.dart';
import 'package:flutter_ecampus/view/main/jadwal/jadwal_detail_page.dart';
import 'package:flutter_ecampus/view/main/jadwal/jadwal_page.dart';
import 'package:flutter_ecampus/view/main/latihan_soal/mapel_page.dart';
import 'package:flutter_ecampus/view/main/latihan_soal/paket_soal_page.dart';
import 'package:flutter_ecampus/view/main_page.dart';
import 'package:flutter_ecampus/view/register_page.dart';
import 'package:flutter_ecampus/view/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/r.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Campus',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: R.colors.primary,
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const SplashScreen(),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        LoginPage.route: (context) => LoginPage(),
        RegisterPage.route: (context) => const RegisterPage(),
        // MainPage.route: (context) => const MainPage(),
        // JadwalPage.route: (context) => JadwalPage(),
        // JadwalDetailPage.route: (context) => const JadwalDetailPage(),
        MapelPage.route: (context) => const MapelPage(),
        PakeSoalPage.route: (context) => const PakeSoalPage(),
      },
    );
  }
}
