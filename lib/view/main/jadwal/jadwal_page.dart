import 'dart:convert';
import 'package:flutter_ecampus/constants/api_url.dart';
import 'package:flutter_ecampus/models/jadwals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/view/main/jadwal/jadwal_detail_page.dart';
import 'package:shimmer/shimmer.dart';

class JadwalPage extends StatefulWidget {
  final String dataKeyNim;
  final String dataKeySemester;
  JadwalPage(
      {Key? key, required this.dataKeyNim, required this.dataKeySemester})
      : super(key: key);
  static String route = "jadwal_page";

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  Map<String, dynamic>? responseApi;
  Jadwals? parsedJadwalsResponse;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getDataJadwalsByEmail();
  }

  //method untuk merequest/mengambil data dari internet
  Future getDataJadwalsByEmail() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.baseUrl +
          "/jadwal/${widget.dataKeyNim}/${widget.dataKeySemester}"));
      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        responseApi = jsonDecode(response.body);
        setState(() {
          //memasukan data yang di dapat dari internet ke variabel parsedJadwalsResponse
          parsedJadwalsResponse = Jadwals.fromJson(responseApi!);
        });
      }
    } catch (e) {
      //tampilkan error di terminal
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Jadwal"),
          centerTitle: true,
        ),
        body:
            // parsedJadwalsResponse == null
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     :
            parsedJadwalsResponse == null
                ? ListView.builder(
                    // itemcount adalah total panjang data yang ingin ditampilkan
                    // _get.length adalah total panjang data dari data berita yang diambil
                    itemCount: parsedJadwalsResponse?.data?.length,

                    // itembuilder adalah bentuk widget yang akan ditampilkan, wajib menggunakan 2 parameter.
                    itemBuilder: (context, index) {
                      //padding digunakan untuk memberikan jarak bagian atas listtile agar tidak terlalu mepet
                      //menggunakan edgeInsets.only untuk membuat jarak hanya pada bagian atas saja
                      return GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushNamed(JadwalDetailPage.route);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JadwalDetailPage(
                                          dataKeyNim:
                                              '${parsedJadwalsResponse!.data?[index].nim}',
                                          dataKeySemester:
                                              '${parsedJadwalsResponse!.data?[index].semester}',
                                          dataKeyKodeMatkul:
                                              '${parsedJadwalsResponse!.data?[index].idJadwalMataKuliah}',
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 21),
                            child: Row(children: [
                              // Container(
                              //   margin: EdgeInsets.all(10),
                              //   width: 53,
                              //   height: 53,
                              //   decoration: BoxDecoration(
                              //     shape: BoxShape.circle,
                              //     image: DecorationImage(
                              //         image: NetworkImage(
                              //             '${parsedJadwalsResponse?.data?[index].foto}'),
                              //         // image: AssetImage(R.assets.imgUser),
                              //         fit: BoxFit.cover),
                              //   ),
                              // ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor:
                                      Color.fromARGB(20, 245, 245, 245),
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
                                width: 6,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor:
                                          Color(0xff182543).withOpacity(.5),
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
                                    SizedBox(height: 5),
                                    Shimmer.fromColors(
                                      baseColor: Colors.black12,
                                      highlightColor:
                                          Color.fromARGB(20, 245, 245, 245),
                                      period: Duration(seconds: 2),
                                      child: Container(
                                        width: 80,
                                        height: 12,
                                        decoration: ShapeDecoration(
                                            color: Colors.grey[100]!,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Shimmer.fromColors(
                                      baseColor: Colors.black12,
                                      highlightColor:
                                          Color.fromARGB(20, 245, 245, 245),
                                      period: Duration(seconds: 2),
                                      child: Container(
                                        width: 140,
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
                    // itemcount adalah total panjang data yang ingin ditampilkan
                    // _get.length adalah total panjang data dari data berita yang diambil
                    itemCount: parsedJadwalsResponse?.data?.length,

                    // itembuilder adalah bentuk widget yang akan ditampilkan, wajib menggunakan 2 parameter.
                    itemBuilder: (context, index) {
                      //padding digunakan untuk memberikan jarak bagian atas listtile agar tidak terlalu mepet
                      //menggunakan edgeInsets.only untuk membuat jarak hanya pada bagian atas saja
                      return GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushNamed(JadwalDetailPage.route);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JadwalDetailPage(
                                          dataKeyNim:
                                              '${parsedJadwalsResponse!.data?[index].nim}',
                                          dataKeySemester:
                                              '${parsedJadwalsResponse!.data?[index].semester}',
                                          dataKeyKodeMatkul:
                                              '${parsedJadwalsResponse!.data?[index].idJadwalMataKuliah}',
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 21),
                            child: Row(children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                width: 53,
                                height: 53,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${parsedJadwalsResponse?.data?[index].foto}'),
                                      // image: AssetImage(R.assets.imgUser),
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
                                      '${parsedJadwalsResponse?.data?[index].namaMatkul}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${parsedJadwalsResponse?.data?[index].kodeMatkul}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: R.colors.greySubtitleHome),
                                    ),
                                    Text(
                                      '${parsedJadwalsResponse?.data?[index].hari}' +
                                          ", " +
                                          '${parsedJadwalsResponse?.data?[index].jamMulai}' +
                                          " - " +
                                          '${parsedJadwalsResponse?.data?[index].jamSelesai}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: R.colors.greySubtitleHome),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${parsedJadwalsResponse?.data?[index].namaDosen}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: R.colors.greySubtitleHome),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          ));
                    },
                  ));
  }
}
