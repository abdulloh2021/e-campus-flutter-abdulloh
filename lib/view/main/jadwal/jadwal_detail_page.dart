import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/jadwal_detail.dart';
import 'package:flutter_ecampus/models/jadwals.dart';
import 'package:flutter_ecampus/services/services.dart';
import 'package:flutter_ecampus/view/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  JadwalDetail? jadwalDetail;
  // Users? lokalProfile;
  void getDataJadwalDetail() async {
    JadwalDetail? hasilJadwalDetail =
        await Services.getJadwalDetailByKodeMatkul(widget.dataKeyNim,
            widget.dataKeySemester, widget.dataKeyKodeMatkul); //get data user
    if (hasilJadwalDetail != null) {
      setState(() {
        jadwalDetail = hasilJadwalDetail;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataJadwalDetail();
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunchMeet = Uri(
        scheme: 'https',
        host: 'meet.google.com',
        path: '${jadwalDetail?.data?[0].linkMeet}');
    final Uri toLaunchClassroom = Uri(
        scheme: 'https',
        host: 'classroom.google.com',
        path: 'u/0/c/${jadwalDetail?.data?[0].linkClassroom}');
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
          msg: 'Nomor Rekening Tersalin ${jadwalDetail?.data?[0].linkMeet}',
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
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
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
                            image:
                                NetworkImage('${jadwalDetail?.data?[0].foto}'),
                            // image: AssetImage(R.assets.imgUser),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Center(
                    child: Text(
                      "${jadwalDetail?.data?[0].namaMatkul}", // Nama Matkul
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${jadwalDetail?.data?[0].kodeMatkul}", // Nama Matkul
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
                    "${jadwalDetail?.data?[0].hari} ${jadwalDetail?.data?[0].jamMulai} - ${jadwalDetail?.data?[0].jamSelesai}", // Hari Matkul
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
                    "${jadwalDetail?.data?[0].namaDosen}", // Hari Matkul
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
                    "${jadwalDetail?.data?[0].email}", // Hari Matkul
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
                    "${jadwalDetail?.data?[0].semester}", // Hari Matkul
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   "${jadwalDetail?.data?.linkClassroom}", // Hari Matkul
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // Text(
                  //   "${jadwalDetail?.data?.linkMeet}", // Hari Matkul
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Clipboard.setData(ClipboardData(
                  //         text: "${jadwalDetail?.data?.linkMeet}"));
                  //     showToast();
                  //   },
                  //   child: Row(children: [
                  //     Text(
                  //       "${jadwalDetail?.data?.linkMeet}",
                  //       style: TextStyle(
                  //         color: Colors.red,
                  //         // fontSize: 12,
                  //       ),
                  //     ),
                  //     SizedBox(width: 10),
                  //     Icon(
                  //       Icons.content_copy,
                  //       color: Colors.red,
                  //     ),
                  //   ]),
                  // )
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
