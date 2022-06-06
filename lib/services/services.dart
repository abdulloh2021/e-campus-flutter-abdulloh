import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecampus/models/dosen_detail.dart';
import 'package:flutter_ecampus/models/dosens.dart';
import 'package:flutter_ecampus/models/jadwal_detail.dart';

import 'package:flutter_ecampus/models/users.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class Services {
  static Future<Users?> getUsersById(String key) async {
    try {
      var response = await Dio()
          .get("https://ecampus-flutter.000webhostapp.com/mahasiswa/$key");
      if (response.statusCode == 200) {
        return Users.fromJson(response.data);
      }
      // } catch (e) {
      //   throw Exception(e.toString());
      // }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        print(e.response?.statusCode);
      } else {
        print(e.message);
        // print(e.request);
      }
    }
  }

  static Future<Users?> getUsersByEmail(String key) async {
    try {
      var response = await Dio().get(
          "https://ecampus-flutter.000webhostapp.com/mahasiswabyemail/$key");
      if (response.statusCode == 200) {
        return Users.fromJson(response.data);
      }
      // } catch (e) {
      //   throw Exception(e.toString());
      // }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        print(e.response?.statusCode);
        GoogleSignIn().signOut();
        FirebaseAuth.instance.signOut();
      } else {
        print(e.message);
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

  static Future<Dosens?> getDosens() async {
    try {
      var response =
          await Dio().get("https://ecampus-flutter.000webhostapp.com/dosen");
      if (response.statusCode == 200) {
        return Dosens.fromJson(response.data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

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

  // static Future<Jadwals?> getJadwalsById(String key) async {
  //   try {
  //     var response = await Dio().get("https://mocki.io/v1/$key");
  //     if (response.statusCode == 200) {
  //       return Jadwals.fromJson(response.data);
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
