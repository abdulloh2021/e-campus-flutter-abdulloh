import 'package:flutter/material.dart';
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

class HomePage extends StatefulWidget {
  final String dataKeyNim;
  final String dataKeySemester;
  // final String dataKeyHari;
  const HomePage({
    Key? key,
    required this.dataKeyNim,
    required this.dataKeySemester,
    // required this.dataKeyHari
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('EEEE');
  final String Hari = formatter.format(now);
  //_get berfungsi untuk menampung data dari internet nanti
  List getJadwals = [];

  //paste apikey yang didapatkan dari newsapi.org
  // var apikey = '69d4783612054e4585f2d5a5883fc3a8';
  var apikey = '560c0eca-da28-4a92-9057-2aef5828754a';

  Users? userProfile;
  void getDataUser() async {
    Users? hasilUsers =
        await Services.getUsersById(widget.dataKeyNim); //get data user
    if (hasilUsers != null) {
      setState(() {
        userProfile = hasilUsers;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
    getDataJadwalsByEmail();
    // getDataJadwal();
  }

  //method untuk merequest/mengambil data dari internet
  Future getDataJadwalsByEmail() async {
    try {
      final response = await http.get(Uri.parse(
          // "https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=${apikey}"
          "https://ecampus-flutter.000webhostapp.com/jadwalweek/${widget.dataKeyNim}/${widget.dataKeySemester}/" +
              Hari +
              ""));

      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          //memasukan data yang di dapat dari internet ke variabel _get
          getJadwals = data['data'];
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
      backgroundColor: R.colors.grey,
      body: SafeArea(
        child: ListView(
          children: [
            _buildUserHomeProfile(),
            _buildTopBanner(context),
            _buildHomeListMapel(),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      "Berita",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Image.asset(
                            R.assets.banneHome,
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 35),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildHomeListMapel() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Pilih Pelajaran",
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
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // itemcount adalah total panjang data yang ingin ditampilkan
                // _get.length adalah total panjang data dari data berita yang diambil
                itemCount: getJadwals.length,

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
                                      dataKeyNim: widget.dataKeyNim,
                                      dataKeySemester: widget.dataKeySemester,
                                      dataKeyKodeMatkul: getJadwals[index]
                                              ['id_jadwal_mata_kuliah'] ??
                                          "Id Jadwal Matkul",
                                    )));
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
                                  image: NetworkImage(getJadwals[index]
                                          ['foto'] ??
                                      "https://cdn.pixabay.com/photo/2018/03/17/20/51/white-buildings-3235135__340.jpg"),
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
                                  getJadwals[index]['nama_matkul'] ??
                                      "Nama Matkul",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  getJadwals[index]['kode_matkul'] ??
                                      "Kode Matkul",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 8,
                                      color: R.colors.greySubtitleHome),
                                ),
                                Text(
                                  getJadwals[index]['hari'] +
                                          ", " +
                                          getJadwals[index]['jam_mulai'] +
                                          " - " +
                                          getJadwals[index]['jam_selesai'] ??
                                      "Hari, JamMul - JamSel",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 8,
                                      color: R.colors.greySubtitleHome),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  getJadwals[index]['nama_dosen'] ??
                                      "Nama Dosen",
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
            child: Text(
              "Bingung Cari Kampus? Yuk Join! di                     STMIK JAYAKARTA",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, ${userProfile?.data?[0].nama} ",
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                Text(
                  "${userProfile?.data?[0].nim}",
                  style: GoogleFonts.poppins().copyWith(
                    fontSize: 12,
                    // fontWeight: FontWeight.w700,
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
                  image: NetworkImage('${userProfile?.data?[0].foto}'),
                  // image: AssetImage(R.assets.imgUser),
                  fit: BoxFit.cover),
            ),
          ),

          // Image.asset(
          //   R.assets.imgUser,
          //   width: 35,
          //   height: 35,
          // ),
        ],
      ),
    );
  }
}

// class MapelWidget extends StatelessWidget {
//   const MapelWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(10)),
//       margin: EdgeInsets.only(bottom: 10),
//       padding: EdgeInsets.symmetric(horizontal: 18, vertical: 21),
//       child: Row(children: [
//         Container(
//           height: 53,
//           width: 53,
//           padding: EdgeInsets.all(13),
//           decoration: BoxDecoration(
//               color: R.colors.grey, borderRadius: BorderRadius.circular(10)),
//           child: Image.asset(R.assets.icAtom),
//         ),
//         SizedBox(
//           width: 6,
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Matematika",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 ),
//               ),
//               Text(
//                 "0/50 Paket latihan soal",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 12,
//                     color: R.colors.greySubtitleHome),
//               ),
//               SizedBox(height: 5),
//               Stack(
//                 children: [
//                   Container(
//                     height: 5,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         color: R.colors.grey,
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                   Container(
//                     height: 5,
//                     width: MediaQuery.of(context).size.width * 0.4,
//                     decoration: BoxDecoration(
//                         color: R.colors.primary,
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         )
//       ]),
//     );
//   }
// }

class JadwalWidget extends StatelessWidget {
  const JadwalWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 21),
      child: Row(children: [
        Container(
          height: 53,
          width: 53,
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              color: R.colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Image.asset(R.assets.icAtom),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Matakuliah",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                "Kode Matakuliah",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: R.colors.greySubtitleHome),
              ),
              Text(
                "Hari, JamMul - JamSel",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: R.colors.greySubtitleHome),
              ),
              SizedBox(height: 5),
              Text(
                "Nama Dosen",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: R.colors.greySubtitleHome),
              ),
              // Stack(
              //   children: [
              //     Container(
              //       height: 5,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //           color: R.colors.grey,
              //           borderRadius: BorderRadius.circular(10)),
              //     ),
              //     Container(
              //       height: 5,
              //       width: MediaQuery.of(context).size.width * 0.4,
              //       decoration: BoxDecoration(
              //           color: R.colors.primary,
              //           borderRadius: BorderRadius.circular(10)),
              //     ),
              //   ],
              // )
            ],
          ),
        )
      ]),
    );
  }
}
