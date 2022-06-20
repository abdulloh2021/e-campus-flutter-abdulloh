import 'dart:convert';
// import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/jadwal_detail.dart';
// import 'package:flutter_ecampus/models/jadwals.dart';
// import 'package:flutter_ecampus/services/services.dart';
// import 'package:flutter_ecampus/view/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class JadwalDetailPage extends StatefulWidget {
  final String dataKeyNim;
  final String dataKeySemester;
  final String dataKeyKodeMatkul;
  JadwalDetailPage(
      {Key? key,
      required this.dataKeyNim,
      required this.dataKeySemester,
      required this.dataKeyKodeMatkul})
      : super(key: key);
  static String route = "jadwal_detail_page";
  @override
  State<JadwalDetailPage> createState() => _JadwalDetailPageState();
}

class _JadwalDetailPageState extends State<JadwalDetailPage> {
  Map<String, dynamic>? responseApi;
  JadwalDetail? parsedJadwalDetailResponse;

  Future getDataJadwalsByNimBySemesterByKodeMatkul() async {
    try {
      final response = await http.get(Uri.parse(
          "https://ecampus-flutter.000webhostapp.com/jadwal/${widget.dataKeyNim}/${widget.dataKeySemester}/${widget.dataKeyKodeMatkul}"));

      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        responseApi = jsonDecode(response.body);

        setState(() {
          //memasukan data yang di dapat dari internet ke variabel _get
          // getJadwals = data['data'];
          parsedJadwalDetailResponse = JadwalDetail.fromJson(responseApi!);
        });
      }
    } catch (e) {
      //tampilkan error di terminal
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataJadwalsByNimBySemesterByKodeMatkul();
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunchMeet = Uri(
        scheme: 'https',
        host: 'meet.google.com',
        path: '${parsedJadwalDetailResponse?.data?[0].linkMeet}');
    final Uri toLaunchClassroom = Uri(
        scheme: 'https',
        host: 'classroom.google.com',
        path: 'u/0/c/${parsedJadwalDetailResponse?.data?[0].linkClassroom}');
    // https://meet.google.com/ivp-cyzg-yiu?authuser=0
    Future<void>? _launched;
    Future<void> _launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    }

    void showToast() {
      Fluttertoast.showToast(
          msg:
              'Nomor Rekening Tersalin ${parsedJadwalDetailResponse!.data?[0].linkMeet}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }

    return Scaffold(
      backgroundColor: R.colors.grey,
      appBar: AppBar(
        title: Text("Mata Kuliah"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Detail",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            parsedJadwalDetailResponse == null
                ? Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    // margin: const EdgeInsets.all(13.0),
                    padding: const EdgeInsets.only(
                      left: 13.0,
                      right: 13.0,
                      top: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Shimmer.fromColors(
                              baseColor: Colors.black12,
                              highlightColor: Color.fromARGB(20, 245, 245, 245),
                              period: Duration(seconds: 2),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: ShapeDecoration(
                                    color: Colors.grey[100]!,
                                    shape: CircleBorder()),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Color.fromARGB(20, 245, 245, 245),
                            period: Duration(seconds: 2),
                            child: Container(
                              width: 140,
                              height: 14,
                              decoration: ShapeDecoration(
                                  color: Colors.grey[100]!,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Color.fromARGB(20, 245, 245, 245),
                            period: Duration(seconds: 2),
                            child: Container(
                              width: 100,
                              height: 14,
                              decoration: ShapeDecoration(
                                  color: Colors.grey[100]!,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Hari",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: R.colors.greySubtitleHome),
                        ),
                        SizedBox(height: 5),
                        Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Color.fromARGB(20, 245, 245, 245),
                          period: Duration(seconds: 2),
                          child: Container(
                            width: 180,
                            height: 14,
                            decoration: ShapeDecoration(
                                color: Colors.grey[100]!,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Dosen",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: R.colors.greySubtitleHome),
                        ),
                        SizedBox(height: 5),
                        Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Color.fromARGB(20, 245, 245, 245),
                          period: Duration(seconds: 2),
                          child: Container(
                            width: 220,
                            height: 14,
                            decoration: ShapeDecoration(
                                color: Colors.grey[100]!,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: R.colors.greySubtitleHome),
                        ),
                        SizedBox(height: 5),
                        Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Color.fromARGB(20, 245, 245, 245),
                          period: Duration(seconds: 2),
                          child: Container(
                            width: 240,
                            height: 14,
                            decoration: ShapeDecoration(
                                color: Colors.grey[100]!,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Ruangan",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: R.colors.greySubtitleHome),
                        ),
                        SizedBox(height: 5),
                        Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Color.fromARGB(20, 245, 245, 245),
                          period: Duration(seconds: 2),
                          child: Container(
                            width: 50,
                            height: 14,
                            decoration: ShapeDecoration(
                                color: Colors.grey[100]!,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    // margin: const EdgeInsets.all(13.0),
                    padding: const EdgeInsets.only(
                      left: 13.0,
                      right: 13.0,
                      top: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${parsedJadwalDetailResponse?.data?[0].foto}'),
                                  // image: AssetImage(R.assets.imgUser),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Center(
                          child: Text(
                            "${parsedJadwalDetailResponse?.data?[0].namaMatkul}", // Nama Matkul
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "${parsedJadwalDetailResponse?.data?[0].kodeMatkul}", // Nama Matkul
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "Hari",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: R.colors.greySubtitleHome),
                        ),
                        Text(
                          "${parsedJadwalDetailResponse?.data?[0].hari} ${parsedJadwalDetailResponse?.data?[0].jamMulai} - ${parsedJadwalDetailResponse?.data?[0].jamSelesai}", // Hari Matkul
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Dosen",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: R.colors.greySubtitleHome),
                        ),
                        Text(
                          "${parsedJadwalDetailResponse?.data?[0].namaDosen}", // Hari Matkul
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: R.colors.greySubtitleHome),
                        ),
                        Text(
                          "${parsedJadwalDetailResponse?.data?[0].email}", // Hari Matkul
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Ruangan",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: R.colors.greySubtitleHome),
                        ),
                        Text(
                          "${parsedJadwalDetailResponse?.data?[0].semester}", // Hari Matkul
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
            ButtonJadwalDetail(
              onTap: () {
                // Navigator.of(context).pushNamed(RegisterPage.route);
                _launched = _launchInBrowser(toLaunchClassroom);
              },
              backgroundColor: R.colors.primary,
              borderColor: R.colors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icGoogle),
                  SizedBox(width: 15),
                  Text(
                    "Classroom",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            ButtonJadwalDetail(
              onTap: () {
                // Navigator.of(context).pushNamed(RegisterPage.route);
                _launched = _launchInBrowser(toLaunchMeet);
              },
              backgroundColor: R.colors.primary,
              borderColor: R.colors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icGoogle),
                  SizedBox(width: 15),
                  Text(
                    "Meet",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: GridView.count(
            //     mainAxisSpacing: 2,
            //     crossAxisSpacing: 10,
            //     crossAxisCount: 2,
            //     childAspectRatio: 3 / 2,
            //     children: [],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class JadwalDetailWidget extends StatelessWidget {
//   const JadwalDetailWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 400,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10), color: Colors.white),
//       // margin: const EdgeInsets.all(13.0),
//       padding: const EdgeInsets.only(
//         left: 13.0,
//         right: 13.0,
//         top: 40,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.blue.withOpacity(0.2)),
//               padding: EdgeInsets.all(12),
//               child: Image.asset(
//                 R.assets.icHome,
//                 width: 45,
//               ),
//             ),
//           ),
//           SizedBox(height: 4),
//           Center(
//             child: Text(
//               "aa",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Text(
//             "0/0 Paket Soal",
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 9,
//                 color: R.colors.greySubtitleHome),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ButtonJadwalDetail extends StatelessWidget {
  const ButtonJadwalDetail({
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
