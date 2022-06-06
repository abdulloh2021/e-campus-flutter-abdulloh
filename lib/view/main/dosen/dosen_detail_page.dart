import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/dosen_detail.dart';
import 'package:flutter_ecampus/models/jadwal_detail.dart';
import 'package:flutter_ecampus/models/jadwals.dart';
import 'package:flutter_ecampus/services/services.dart';
import 'package:flutter_ecampus/view/login_page.dart';
// mport 'ipackage:flutter_launch/flutter_launch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

class DosenDetailPage extends StatefulWidget {
  final String dataKeyKodeDosen;
  DosenDetailPage({Key? key, required this.dataKeyKodeDosen}) : super(key: key);
  static String route = "dosen_detail_page";
  @override
  State<DosenDetailPage> createState() => _DosenDetailPageState();
}

class _DosenDetailPageState extends State<DosenDetailPage> {
  DosenDetail? dosenDetail;
  // bool _hasCallSupport = false;
  Future<void>? _launched;
  // String _phone = '';
  void getDataDosenDetail() async {
    DosenDetail? hasilDosenDetail = await Services.getDosenDetailByKodeDosen(
        widget.dataKeyKodeDosen); //get data user
    if (hasilDosenDetail != null) {
      setState(() {
        dosenDetail = hasilDosenDetail;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataDosenDetail();
    // canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
    //   setState(() {
    //     _hasCallSupport = result;
    //   });
    // });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri(
        scheme: 'https',
        host: 'wa.me',
        path: '${dosenDetail?.data?[0].nomorwhatsapp}');
    // void launchWhatsapp({@required number, @required message}) async {
    //   // Uri url = "whatsapp://send?phone=$number&text=$message";
    //   Uri url = Uri.parse("whatsapp://send?phone=$number&text=$message");
    //   // ignore: deprecated_member_use
    //   await canLaunchUrl(url)
    //       ? launch("whatsapp://send?phone=$number&text=$message")
    //       : Fluttertoast.showToast(msg: "Whatsapp tidak tersedia");
    // }

    void showToastEmail() {
      Fluttertoast.showToast(
          msg: '${dosenDetail?.data?[0].email} disalin',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }

    void showToastWhatsapp() {
      Fluttertoast.showToast(
          msg: '${dosenDetail?.data?[0].nomorwhatsapp} disalin',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }

    return Scaffold(
      backgroundColor: R.colors.grey,
      appBar: AppBar(
        title: Text("Dosen Detail"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Detail",
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Container(
              width: double.infinity,
              height: 470,
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
                                NetworkImage('${dosenDetail?.data?[0].foto}'),
                            // image: AssetImage(R.assets.imgUser),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Center(
                    child: Text(
                      "${dosenDetail?.data?[0].nama}", // Nama Matkul
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${dosenDetail?.data?[0].idDosen}", // Nama Matkul
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: R.colors.greySubtitleHome),
                    ),
                  ),
                  Text(
                    "Nama",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: R.colors.greySubtitleHome),
                  ),
                  Text(
                    "${dosenDetail?.data?[0].nama} ", // Hari Matkul
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "NIDN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: R.colors.greySubtitleHome),
                  ),
                  Text(
                    "${dosenDetail?.data?[0].nidn}", // Hari Matkul
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
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: "${dosenDetail?.data?[0].email}"));
                      showToastEmail();
                    },
                    child: Row(children: [
                      Text(
                        "${dosenDetail?.data?[0].email}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.content_copy,
                        color: R.colors.greySubtitleHome,
                      ),
                    ]),
                  ),
                  Text(
                    "No Whatsapp",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: R.colors.greySubtitleHome),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: "${dosenDetail?.data?[0].nomorwhatsapp}"));
                      showToastWhatsapp();
                    },
                    child: Row(children: [
                      Text(
                        "${dosenDetail?.data?[0].nomorwhatsapp}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.content_copy,
                        color: R.colors.greySubtitleHome,
                      ),
                    ]),
                  ),
                  Text(
                    "Perguruan Tinggi",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: R.colors.greySubtitleHome),
                  ),
                  Text(
                    "${dosenDetail?.data?[0].perguruantinggi}", // Hari Matkul
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Program Studi",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: R.colors.greySubtitleHome),
                  ),
                  Text(
                    "${dosenDetail?.data?[0].prodi}", // Hari Matkul
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Tingkat Pendidikan",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: R.colors.greySubtitleHome),
                  ),
                  Text(
                    "${dosenDetail?.data?[0].tingkatpendidikan}", // Hari Matkul
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ButtonDosenDetail(
              onTap: () {
                // Navigator.of(context).pushNamed(RegisterPage.route);
                _launched = _launchInBrowser(toLaunch);
              },
              backgroundColor: R.colors.primary,
              borderColor: R.colors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.whatsapp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Whatsapp",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonDosenDetail extends StatelessWidget {
  const ButtonDosenDetail({
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
