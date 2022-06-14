import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/jadwal_detail.dart';
import 'package:flutter_ecampus/models/jadwals.dart';
import 'package:flutter_ecampus/services/services.dart';
import 'package:flutter_ecampus/view/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PembayaranPage extends StatefulWidget {
  final String dataKeyNim;
  final String dataKeyNama;
  PembayaranPage(
      {Key? key, required this.dataKeyNim, required this.dataKeyNama})
      : super(key: key);

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showToast() {
      Fluttertoast.showToast(
          msg: 'Nomor Rekening Tersalin 0667' + widget.dataKeyNim,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }

    return Scaffold(
      backgroundColor: R.colors.grey,
      appBar: AppBar(
        title: Text("Pembayaran"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 600,
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
                      width: 200,
                      height: 100,
                      child: Image.asset(R.assets.imgBca),
                      decoration: BoxDecoration(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "BANK",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: R.colors.greySubtitleHome),
                    ),
                  ),
                  Center(
                    child: Text(
                      // "${jadwalDetail?.data?.namaMatkul}", // Nama Matkul
                      "BANK CENTRAL ASIA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Metode Pembayaran",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: R.colors.greySubtitleHome),
                    ),
                  ),
                  Center(
                    child: Text(
                      // "${jadwalDetail?.data?.kodeMatkul}", // Nama Matkul
                      "Virtual Account",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Nomor Virtual Account",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: R.colors.greySubtitleHome),
                    ),
                  ),
                  Center(
                      child: GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: "0667" + widget.dataKeyNim));
                      showToast();
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "0667" + widget.dataKeyNim,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              // fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.content_copy,
                            color: R.colors.greySubtitleHome,
                          ),
                        ]),
                  )),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Nama Rekening",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: R.colors.greySubtitleHome),
                    ),
                  ),
                  Center(
                    child: Text(
                      "YAY DHARMA PERSADA", // Nama Matkul
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ButtonPembayaranNama(
                    onTap: () {},
                    backgroundColor: R.colors.primary,
                    borderColor: R.colors.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.dataKeyNama,
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
          ],
        ),
      ),
    );
  }
}

class ButtonPembayaranNama extends StatelessWidget {
  const ButtonPembayaranNama({
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
