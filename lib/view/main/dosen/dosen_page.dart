import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/view/main/dosen/dosen_detail_page.dart';
import 'package:flutter_ecampus/view/main/jadwal/jadwal_detail_page.dart';
import 'package:http/http.dart' as http;

class DosenPage extends StatefulWidget {
  const DosenPage({Key? key}) : super(key: key);

  @override
  State<DosenPage> createState() => _DosenPageState();
}

class _DosenPageState extends State<DosenPage> {
  List getDosens = [];

  var apikey = '936f480d-0e26-4f44-8698-0f1c2ada07c1';

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getDataDosens();
  }

  //method untuk merequest/mengambil data dari internet
  Future getDataDosens() async {
    try {
      final response = await http
          .get(Uri.parse("https://ecampus-flutter.000webhostapp.com/dosen"));

      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          //memasukan data yang di dapat dari internet ke variabel _get
          getDosens = data['data'];
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
          title: Text("Akun Dosen"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          // itemcount adalah total panjang data yang ingin ditampilkan
          // _get.length adalah total panjang data dari data berita yang diambil
          itemCount: getDosens.length,

          // itembuilder adalah bentuk widget yang akan ditampilkan, wajib menggunakan 2 parameter.
          itemBuilder: (context, index) {
            //padding digunakan untuk memberikan jarak bagian atas listtile agar tidak terlalu mepet
            //menggunakan edgeInsets.only untuk membuat jarak hanya pada bagian atas saja
            return GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(JadwalDetailPage.route);
                  Navigator.push(
                      context,
                      // JadwalDetailPage(
                      //           dataKeyKodeMatkul:
                      //               "c4a77af8-3555-4abb-8358-72d40721ecdc",
                      //         )
                      MaterialPageRoute(
                          builder: (context) => DosenDetailPage(
                              dataKeyKodeDosen: getDosens[index]['id_dosen'])));
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
                            image: NetworkImage(getDosens[index]['foto'] ??
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
                            getDosens[index]['nama'] ?? "Nama Dosen",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            getDosens[index]['nidn'] ?? "NIDN",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: R.colors.greySubtitleHome),
                          ),
                          SizedBox(height: 5),
                          Text(
                            getDosens[index]['email'] ?? "Email Dosen",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: R.colors.greySubtitleHome),
                          ),
                          Text(
                            getDosens[index]['nomorwhatsapp'] ??
                                "Nomor Whatsapp",
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
