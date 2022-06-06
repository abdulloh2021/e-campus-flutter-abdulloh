import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_ecampus/constants/r.dart';

import 'package:flutter_ecampus/models/jadwals.dart';
import 'package:flutter_ecampus/services/services.dart';
import 'package:flutter_ecampus/view/main/jadwal/jadwal_detail_page.dart';
import 'package:flutter_ecampus/view/main/latihan_soal/home_page.dart';
import 'package:flutter_ecampus/view/main/latihan_soal/paket_soal_page.dart';

// class JadwalPage extends StatelessWidget {
//   const JadwalPage({Key? key}) : super(key: key);
//   static String route = "jadwal_page";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Jadwal"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 8.0,
//           horizontal: 20,
//         ),
//         child: ListView.builder(
//           itemBuilder: (context, index) {
//             return GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).pushNamed(JadwalDetailPage.route);
//                 },
//                 child: JadwalWidget());
//           },
//           itemCount: 4,
//         ),
//       ),
//     );
//   }
// }

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
  //_get berfungsi untuk menampung data dari internet nanti
  List getJadwals = [];
  // String dataNim = widget.dataKeyNim;

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
      final response = await http.get(Uri.parse(
          // "https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=${apikey}"
          // "https://mocki.io/v1/${widget.dataKeyNim}"
          "https://ecampus-flutter.000webhostapp.com/jadwal/${widget.dataKeyNim}/${widget.dataKeySemester}"));

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
        appBar: AppBar(
          title: Text("Jadwal"),
          centerTitle: true,
        ),
        body: ListView.builder(
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
                                dataKeyNim: getJadwals[index]['nim'],
                                dataKeySemester: getJadwals[index]['semester'],
                                dataKeyKodeMatkul: getJadwals[index]
                                    ['id_jadwal_mata_kuliah'],
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 21),
                  child: Row(children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 53,
                      height: 53,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(getJadwals[index]['foto'] ??
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
                            getJadwals[index]['nama_matkul'] ?? "Nama Matkul",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            getJadwals[index]['kode_matkul'] ?? "Kode Matkul",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
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
                                fontSize: 12,
                                color: R.colors.greySubtitleHome),
                          ),
                          SizedBox(height: 5),
                          Text(
                            getJadwals[index]['nama_dosen'] ?? "Nama Dosen",
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
