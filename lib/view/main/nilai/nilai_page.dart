import 'package:flutter/material.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/users.dart';
import 'package:flutter_ecampus/services/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NilaiPage extends StatefulWidget {
  final String dataKeyNim;

  const NilaiPage({
    Key? key,
    required this.dataKeyNim,
  }) : super(key: key);

  @override
  State<NilaiPage> createState() => _NilaiPageState();
}

class _NilaiPageState extends State<NilaiPage> {
  //_get berfungsi untuk menampung data dari internet nanti
  List getNilai = [];

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
    getDataNilaiByNim();
  }

  //method untuk merequest/mengambil data dari internet
  Future getDataNilaiByNim() async {
    try {
      final response = await http.get(Uri.parse(
          "https://ecampus-flutter.000webhostapp.com/krs/${widget.dataKeyNim}"));

      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          //memasukan data yang di dapat dari internet ke variabel _get
          getNilai = data['data'];
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
        title: Text("Nilai"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // actions: [
        //   TextButton(
        //     onPressed: () {},
        //     child: Text(
        //       "Edit",
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 30,
              right: 15,
              left: 15,
            ),
            decoration: BoxDecoration(
              color: R.colors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(9),
                bottomRight: Radius.circular(9),
              ),
            ),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userProfile?.data?[0].nama}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${userProfile?.data?[0].nim}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${userProfile?.data?[0].prodi}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage('${userProfile?.data?[0].foto}'),
                      // image: AssetImage(R.assets.imgUser),
                      fit: BoxFit.cover),
                ),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              // itemcount adalah total panjang data yang ingin ditampilkan
              // _get.length adalah total panjang data dari data berita yang diambil
              itemCount: getNilai.length,

              // itembuilder adalah bentuk widget yang akan ditampilkan, wajib menggunakan 2 parameter.
              itemBuilder: (context, index) {
                //padding digunakan untuk memberikan jarak bagian atas listtile agar tidak terlalu mepet
                //menggunakan edgeInsets.only untuk membuat jarak hanya pada bagian atas saja
                return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 21),
                      child: Row(children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getNilai[index]['kode_matkul'] ?? "Kode Matkul",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: R.colors.greySubtitleHome),
                              ),
                              Text(
                                getNilai[index]['nama_matkul'] ?? "Nama Matkul",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: R.colors.primary,
                                ),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "SKS : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: R.colors.greySubtitleHome),
                                      ),
                                      Text(
                                        getNilai[index]['sks'.toString()],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: R.colors.greySubtitleHome),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Semester : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: R.colors.greySubtitleHome),
                                      ),
                                      Text(
                                        getNilai[index]['semester'.toString()],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: R.colors.greySubtitleHome),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Text(
                          getNilai[index]['nilai_huruf'] ?? "Nilai Huruf",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                          ),
                        ),
                      ]),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
