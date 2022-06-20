import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecampus/models/dosen_detail.dart';
import 'package:flutter_ecampus/models/dosens.dart';
import 'package:flutter_ecampus/models/jadwal_detail.dart';

import 'package:flutter_ecampus/models/users.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class Services {
  //class untuk mengambil data dari firebase
  static Future<Users?> getUsersById(String key) async {
    //method untuk mengambil data dari api
    try {
      var response =
          await Dio() //dio adalah library yang digunakan untuk mengambil data dari internet
              .get(
                  "https://ecampus-flutter.000webhostapp.com/mahasiswa/$key"); //mengambil data dari api
      if (response.statusCode == 200) {
        //cek apakah respon berhasil
        return Users.fromJson(response.data); //mengubah data json menjadi objek
      }
    } on DioError catch (e) {
      //jika respon gagal
      if (e.response?.statusCode == 404) {
        //cek apakah respon error 404
        print(e.response?.statusCode); //tampilkan error di terminal
      } else {
        print(e.message); //tampilkan error di terminal
        // print(e.request);
      }
    }
  }

  static Future<Users?> getUsersByEmail(String key) async {
    //method untuk mengambil data user dari api by email
    try {
      var response = await Dio().get(
          //dio adalah library yang digunakan untuk mengambil data dari internet
          "https://ecampus-flutter.000webhostapp.com/mahasiswabyemail/$key"); //mengambil data dari api
      if (response.statusCode == 200) {
        //cek apakah respon berhasil
        return Users.fromJson(response.data); //mengubah data json menjadi objek
      }
    } on DioError catch (e) {
      //jika respon gagal
      if (e.response?.statusCode == 404) {
        //cek apakah respon error 404
        print(e.response?.statusCode);
        GoogleSignIn().signOut(); //sign out dari akun google
        FirebaseAuth.instance.signOut(); //sign out dari akun firebase
      } else {
        print(e.message); //tampilkan error di terminal
        // print(e.request);
      }
    }
  }

  static Future<JadwalDetail?> getJadwalDetailByKodeMatkul(
      String nim, String semester, String idjadwal) async {
    try {
      var response = await Dio().get(
          "https://ecampus-flutter.000webhostapp.com/jadwal/$nim/$semester/$idjadwal");
      if (response.statusCode == 200) {
        return JadwalDetail.fromJson(response.data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // static Future<Dosens?> getDosens() async {
  //   try {
  //     var response =
  //         await Dio().get("https://ecampus-flutter.000webhostapp.com/dosen");
  //     if (response.statusCode == 200) {
  //       return Dosens.fromJson(response.data);
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  static Future<DosenDetail?> getDosenDetailByKodeDosen(String key) async {
    try {
      var response = await Dio()
          .get("https://ecampus-flutter.000webhostapp.com/dosen/$key");
      if (response.statusCode == 200) {
        return DosenDetail.fromJson(response.data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
