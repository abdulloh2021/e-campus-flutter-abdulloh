import 'package:flutter/material.dart';
import 'package:flutter_ecampus/constants/api_url.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/jadwals.dart';
import 'package:flutter_ecampus/models/users.dart';
import 'package:flutter_ecampus/services/services.dart';
import 'package:flutter_ecampus/view/main/jadwal/jadwal_detail_page.dart';
import 'package:flutter_ecampus/view/main/jadwal/jadwal_page.dart';
import 'package:flutter_ecampus/view/main/latihan_soal/mapel_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  final String dataKeyNim;
  final String dataKeySemester;

  const HomePage({
    Key? key,
    required this.dataKeyNim,
    required this.dataKeySemester,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String? cekDataJadwal;
  static final DateTime now = DateTime.now(); //get current date
  static final DateFormat formatter =
      DateFormat('EEEE'); //data format for day (Monday, Tuesday, etc)
  final String Hari = formatter.format(now); //get day dari hasil format Hari

  Map<String, dynamic>? responseApi;
  Map<String, dynamic>? responseApiJadwals;
  Jadwals? parsedJadwalsResponse;
  Users? parsedUsersResponse;
  Future getDataUsersByNim() async {
    try {
      final response = await http
          .get(Uri.parse(ApiUrl.baseUrl + "/mahasiswa/${widget.dataKeyNim}"));

      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        responseApi = jsonDecode(response.body);

        setState(() {
          //memasukan data yang di dapat dari internet ke variabel _get
          parsedUsersResponse = Users.fromJson(responseApi!);
        });
      }
      // cek apakah respon berhasil
      if (response.statusCode == 404) {
        // responseApi = jsonDecode(response.body);

        setState(() {
          //memasukan data yang di dapat dari internet ke variabel _get
          parsedUsersResponse = Users.fromJson(responseApi!);
        });
      }
    } catch (e) {
      //tampilkan error di terminal
      print(e);
    }
  }

  Future getDataJadwalsByNimBySemesterByHari() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.baseUrl +
          "/jadwalweek/${widget.dataKeyNim}/${widget.dataKeySemester}/" +
          Hari +
          ""));

      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        responseApi = jsonDecode(response.body);

        setState(() {
          //memasukan data yang di dapat dari internet ke variabel _get
          parsedJadwalsResponse = Jadwals.fromJson(responseApi!);
        });
      }
      // // cek apakah respon berhasil
      // if (response.statusCode == 404) {
      //   //  responseApi = jsonDecode(response.);
      //   setState(() {
      //     //memasukan data yang di dapat dari internet ke variabel _get
      //     cekDataJadwal = 'Tidak Ada Jadwal';
      //   });
      // }
    } catch (e) {
      //tampilkan error di terminal
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); //super initState
    getDataUsersByNim(); //get data user
    getDataJadwalsByNimBySemesterByHari(); //get data jadwal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.grey,
      body: SafeArea(
        child: ListView(
          children: [
            _buildUserHomeProfile(), //memanggil method _buildUserHomeProfile
            _buildTopBanner(context), //memanggil method _buildTopBanner
            buildHomeListMapel(), //memanggil method _buildHomeListMapel
            // Container(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.symmetric(
            //           horizontal: 20,
            //         ),
            //         child: Text(
            //           "Berita",
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 10),
            //       Container(
            //         height: 150,
            //         child: ListView.builder(
            //           itemCount: 5,
            //           scrollDirection: Axis.horizontal,
            //           itemBuilder: ((context, index) {
            //             return Container(
            //               margin: EdgeInsets.symmetric(
            //                 horizontal: 20.0,
            //               ),
            //               decoration: BoxDecoration(
            //                   color: R.colors.primary,
            //                   image: DecorationImage(
            //                     colorFilter: new ColorFilter.mode(
            //                         Colors.black.withOpacity(0.5),
            //                         BlendMode.dstATop),
            //                     image: NetworkImage(
            //                         "https://fashionsista.co/wallpaper/wallpaper/20210202/background-keren-biru-muda-preview.jpg"),
            //                     fit: BoxFit.cover,
            //                   ),
            //                   borderRadius: BorderRadius.circular(20)),
            //               height: 147,
            //               width: MediaQuery.of(context).size.width * 0.8,
            //               child: Container(
            //                   width: MediaQuery.of(context).size.width * 0.7,
            //                   padding: const EdgeInsets.symmetric(
            //                     horizontal: 20.0,
            //                     vertical: 15,
            //                   ),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.start,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         "Berita " + index.toString(),
            //                         style: TextStyle(
            //                           fontSize: 9,
            //                           color: Colors.white,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                       Text(
            //                         "Kegiatan Bakti Sosial Pembagian Sembako",
            //                         style: TextStyle(
            //                           fontSize: 18,
            //                           color: Colors.white,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                       Text(
            //                         "Kampus B STIE & STMIK JAYAKARTA",
            //                         style: TextStyle(
            //                           fontSize: 9,
            //                           color: Colors.white,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ],
            //                   )),
            //             );
            //           }),
            //         ),
            //       ),
            //       SizedBox(height: 35),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Container buildHomeListMapel() {
    //method untuk menampilkan list mapel
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Matkul, Hari ini",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JadwalPage(
                                dataKeyNim: widget.dataKeyNim,
                                dataKeySemester: widget.dataKeySemester,
                              )));
                },
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: R.colors.primary),
                ),
              )
            ],
          ),
          SizedBox(
              height: 250,
              child: parsedJadwalsResponse == null
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: parsedJadwalsResponse?.data?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => JadwalDetailPage(
                              //               dataKeyNim:
                              //                   '${parsedJadwalsResponse!.data?[index].nim}',
                              //               dataKeySemester:
                              //                   '${parsedJadwalsResponse!.data?[index].semester}',
                              //               dataKeyKodeMatkul:
                              //                   '${parsedJadwalsResponse!.data?[index].idJadwalMataKuliah}',
                              //             )));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                      BorderRadius.circular(
                                                          5))),
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
                                                      BorderRadius.circular(
                                                          5))),
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
                                                      BorderRadius.circular(
                                                          5))),
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
                                                      BorderRadius.circular(
                                                          5))),
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
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: parsedJadwalsResponse?.data?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JadwalDetailPage(
                                            dataKeyNim: widget.dataKeyNim,
                                            dataKeySemester:
                                                widget.dataKeySemester,
                                            dataKeyKodeMatkul:
                                                '${parsedJadwalsResponse?.data?[index].idJadwalMataKuliah}',
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
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${parsedJadwalsResponse?.data?[index].namaMatkul}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${parsedJadwalsResponse?.data?[index].kodeMatkul}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 8,
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
                                            fontSize: 8,
                                            color: R.colors.greySubtitleHome),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '${parsedJadwalsResponse?.data?[index].namaDosen}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 9,
                                            color: R.colors.greySubtitleHome),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ));
                      },
                    )),
        ],
      ),
    );
  }

  Container _buildTopBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        // vertical: 15,
      ),
      decoration: BoxDecoration(
          color: R.colors.primary, borderRadius: BorderRadius.circular(20)),
      height: 147,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bingung Cari Kampus?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Yuk Join! di",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "STMIK JAYAKARTA",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              R.assets.imgHome,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildUserHomeProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15,
      ),
      child: parsedUsersResponse == null
          ? Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Color.fromARGB(20, 245, 245, 245),
                        period: Duration(seconds: 2),
                        child: Container(
                          width: 140,
                          height: 12,
                          decoration: ShapeDecoration(
                              color: Colors.grey[100]!,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      SizedBox(height: 5),
                      Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Color.fromARGB(20, 245, 245, 245),
                        period: Duration(seconds: 2),
                        child: Container(
                          width: 60,
                          height: 12,
                          decoration: ShapeDecoration(
                              color: Colors.grey[100]!,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Color.fromARGB(20, 245, 245, 245),
                    period: Duration(seconds: 2),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                          color: Colors.grey[100]!, shape: CircleBorder()),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${parsedUsersResponse?.data?[0].nama} ",
                        style: GoogleFonts.poppins().copyWith(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${parsedUsersResponse?.data?[0].nim}",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            '${parsedUsersResponse?.data?[0].foto}'),
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
    );
  }
}
