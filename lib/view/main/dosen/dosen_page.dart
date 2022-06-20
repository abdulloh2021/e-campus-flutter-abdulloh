import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/dosens.dart';
import 'package:flutter_ecampus/view/main/dosen/dosen_detail_page.dart';
import 'package:flutter_ecampus/view/main/jadwal/jadwal_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class DosenPage extends StatefulWidget {
  const DosenPage({Key? key}) : super(key: key);

  @override
  State<DosenPage> createState() => _DosenPageState();
}

class _DosenPageState extends State<DosenPage> {
  // List getDosens = []; // list data dosen
  Map<String, dynamic>? responseApi;
  Dosens? parsedDosensResponse;

  Future getDataDosens() async {
    try {
      final response = await http
          .get(Uri.parse("https://ecampus-flutter.000webhostapp.com/dosen"));

      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        responseApi = jsonDecode(response.body);

        setState(() {
          parsedDosensResponse = Dosens.fromJson(responseApi!);
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
    getDataDosens(); // get data dosen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dosen"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: parsedDosensResponse == null
            ? ListView.builder(
                itemCount: parsedDosensResponse?.data?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DosenDetailPage(
                                    dataKeyKodeDosen:
                                        '${parsedDosensResponse?.data?[index].idDosen}'))); // route untuk menampilkan halaman detail dosen
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 21),
                        child: Row(children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Shimmer.fromColors(
                              baseColor: Colors.black12,
                              highlightColor: Color.fromARGB(20, 245, 245, 245),
                              period: Duration(seconds: 2),
                              child: Container(
                                width: 53,
                                height: 53,
                                decoration: ShapeDecoration(
                                    color: Colors.grey[100]!,
                                    shape: CircleBorder()),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Color(0xff182543).withOpacity(.5),
                                  highlightColor:
                                      Color.fromARGB(20, 245, 245, 245),
                                  period: Duration(seconds: 2),
                                  child: Container(
                                    width: 200,
                                    height: 14,
                                    decoration: ShapeDecoration(
                                        color: Colors.grey[100]!,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor:
                                      Color.fromARGB(20, 245, 245, 245),
                                  period: Duration(seconds: 2),
                                  child: Container(
                                    width: 60,
                                    height: 12,
                                    decoration: ShapeDecoration(
                                        color: Colors.grey[100]!,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor:
                                      Color.fromARGB(20, 245, 245, 245),
                                  period: Duration(seconds: 2),
                                  child: Container(
                                    width: 150,
                                    height: 12,
                                    decoration: ShapeDecoration(
                                        color: Colors.grey[100]!,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor:
                                      Color.fromARGB(20, 245, 245, 245),
                                  period: Duration(seconds: 2),
                                  child: Container(
                                    width: 100,
                                    height: 12,
                                    decoration: ShapeDecoration(
                                        color: Colors.grey[100]!,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ));
                },
              )
            : ListView.builder(
                itemCount: parsedDosensResponse?.data?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DosenDetailPage(
                                    dataKeyKodeDosen:
                                        '${parsedDosensResponse?.data?[index].idDosen}'))); // route untuk menampilkan halaman detail dosen
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 21),
                        child: Row(children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 53,
                            height: 53,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${parsedDosensResponse?.data?[index].foto}'), // url gambar

                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${parsedDosensResponse?.data?[index].nama}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ), // nama dosen
                                Text(
                                  '${parsedDosensResponse?.data?[index].nidn}', //
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: R.colors.greySubtitleHome),
                                ), // nidn
                                SizedBox(height: 5),
                                Text(
                                  '${parsedDosensResponse?.data?[index].email}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: R.colors.greySubtitleHome),
                                ), // email dosen
                                Text(
                                  '${parsedDosensResponse?.data?[index].nomorwhatsapp}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: R.colors.greySubtitleHome),
                                ), // nomor whatsapp
                              ],
                            ),
                          )
                        ]),
                      ));
                },
              ));
  }
}
