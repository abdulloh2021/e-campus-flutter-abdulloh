import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
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
import 'package:shimmer/shimmer.dart';
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
  Future<void>? _launched;
  Map<String, dynamic>? responseApi;
  DosenDetail? parsedDosensDetailResponse;

  Future getDataDosenDetail() async {
    try {
      final response = await http.get(Uri.parse(
          "https://ecampus-flutter.000webhostapp.com/dosen/${widget.dataKeyKodeDosen}"));

      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        responseApi = jsonDecode(response.body);

        setState(() {
          parsedDosensDetailResponse = DosenDetail.fromJson(responseApi!);
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
    getDataDosenDetail();
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
        path: '${parsedDosensDetailResponse?.data?[0].nomorwhatsapp}');

    void showToastEmail() {
      Fluttertoast.showToast(
          msg: '${parsedDosensDetailResponse?.data?[0].email} disalin',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }

    void showToastWhatsapp() {
      Fluttertoast.showToast(
          msg: '${parsedDosensDetailResponse?.data?[0].nomorwhatsapp} disalin',
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
            parsedDosensDetailResponse == null
                ? Container(
                    width: double.infinity,
                    height: 470,
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
                        Text(
                          "Nama",
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
                            width: 150,
                            height: 14,
                            decoration: ShapeDecoration(
                                color: Colors.grey[100]!,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "NIDN",
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
                            width: 60,
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
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                text:
                                    "${parsedDosensDetailResponse?.data?[0].email}"));
                            showToastEmail();
                          },
                          child: Row(children: [
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
                                        borderRadius:
                                            BorderRadius.circular(5))),
                              ),
                            ),
                            SizedBox(height: 5),
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
                                text:
                                    "${parsedDosensDetailResponse?.data?[0].nomorwhatsapp}"));
                            showToastWhatsapp();
                          },
                          child: Row(children: [
                            SizedBox(height: 5),
                            Shimmer.fromColors(
                              baseColor: Colors.black12,
                              highlightColor: Color.fromARGB(20, 245, 245, 245),
                              period: Duration(seconds: 2),
                              child: Container(
                                width: 100,
                                height: 14,
                                decoration: ShapeDecoration(
                                    color: Colors.grey[100]!,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                              ),
                            ),
                            SizedBox(height: 5),
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
                        SizedBox(height: 5),
                        Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Color.fromARGB(20, 245, 245, 245),
                          period: Duration(seconds: 2),
                          child: Container(
                            width: 150,
                            height: 14,
                            decoration: ShapeDecoration(
                                color: Colors.grey[100]!,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Program Studi",
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
                            width: 100,
                            height: 14,
                            decoration: ShapeDecoration(
                                color: Colors.grey[100]!,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Tingkat Pendidikan",
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
                            width: 30,
                            height: 14,
                            decoration: ShapeDecoration(
                                color: Colors.grey[100]!,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 470,
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
                                      '${parsedDosensDetailResponse?.data?[0].foto}'),
                                  // image: AssetImage(R.assets.imgUser),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Center(
                          child: Text(
                            "${parsedDosensDetailResponse?.data?[0].nama}", // Nama Matkul
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "${parsedDosensDetailResponse?.data?[0].idDosen}", // Nama Matkul
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
                          "${parsedDosensDetailResponse?.data?[0].nama} ", // Hari Matkul
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
                          "${parsedDosensDetailResponse?.data?[0].nidn}", // Hari Matkul
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
                                text:
                                    "${parsedDosensDetailResponse?.data?[0].email}"));
                            showToastEmail();
                          },
                          child: Row(children: [
                            Text(
                              "${parsedDosensDetailResponse?.data?[0].email}",
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
                                text:
                                    "${parsedDosensDetailResponse?.data?[0].nomorwhatsapp}"));
                            showToastWhatsapp();
                          },
                          child: Row(children: [
                            Text(
                              "${parsedDosensDetailResponse?.data?[0].nomorwhatsapp}",
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
                          "${parsedDosensDetailResponse?.data?[0].perguruantinggi}", // Hari Matkul
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
                          "${parsedDosensDetailResponse?.data?[0].prodi}", // Hari Matkul
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
                          "${parsedDosensDetailResponse?.data?[0].tingkatpendidikan}", // Hari Matkul
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
