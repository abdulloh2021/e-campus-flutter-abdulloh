import 'package:flutter/material.dart';
import 'package:flutter_ecampus/constants/r.dart';
import 'package:flutter_ecampus/models/nilai.dart';
import 'package:flutter_ecampus/models/users.dart';
import 'package:flutter_ecampus/services/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

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
  Map<String, dynamic>? responseApi;
  Map<String, dynamic>? responseApiNilai;
  Users? parsedUsersResponse;
  Nilai? parsedNilaiResponse;

  Future getDataProfileByNim() async {
    try {
      final response = await http.get(Uri.parse(
          "https://ecampus-flutter.000webhostapp.com/mahasiswa/${widget.dataKeyNim}"));

      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        responseApi = jsonDecode(response.body);

        setState(() {
          parsedUsersResponse = Users.fromJson(responseApi!);
        });
      }
    } catch (e) {
      //tampilkan error di terminal
      print(e);
    }
  }

  //method untuk merequest/mengambil data dari internet
  Future getDataNilaiByNim() async {
    try {
      final response = await http.get(Uri.parse(
          "https://ecampus-flutter.000webhostapp.com/krs/${widget.dataKeyNim}"));

      // cek apakah respon berhasil
      if (response.statusCode == 200) {
        responseApiNilai = jsonDecode(response.body);

        setState(() {
          //memasukan data yang di dapat dari internet ke variabel _get
          parsedNilaiResponse = Nilai.fromJson(responseApiNilai!);
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
    getDataProfileByNim();
    getDataNilaiByNim();
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
      body: parsedNilaiResponse == null
          ? Column(
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
                          SizedBox(
                            height: 5,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Color.fromARGB(20, 245, 245, 245),
                            period: Duration(seconds: 2),
                            child: Container(
                              width: 150,
                              height: 20,
                              decoration: ShapeDecoration(
                                  color: Colors.grey[100]!,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Color.fromARGB(20, 245, 245, 245),
                            period: Duration(seconds: 2),
                            child: Container(
                              width: 80,
                              height: 12,
                              decoration: ShapeDecoration(
                                  color: Colors.grey[100]!,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Color.fromARGB(20, 245, 245, 245),
                            period: Duration(seconds: 2),
                            child: Container(
                              width: 100,
                              height: 12,
                              decoration: ShapeDecoration(
                                  color: Colors.grey[100]!,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Color.fromARGB(20, 245, 245, 245),
                        period: Duration(seconds: 2),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: ShapeDecoration(
                              color: Colors.grey[100]!, shape: CircleBorder()),
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: ListView.builder(
                    // itemcount adalah total panjang data yang ingin ditampilkan
                    // _get.length adalah total panjang data dari data berita yang diambil
                    itemCount: parsedNilaiResponse?.data?.length,

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
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 21),
                            child: Row(children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Shimmer.fromColors(
                                      baseColor:
                                          Color(0xff182543).withOpacity(.5),
                                      highlightColor:
                                          Color.fromARGB(20, 245, 245, 245),
                                      period: Duration(seconds: 2),
                                      child: Container(
                                        width: 160,
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
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "SKS : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: R
                                                      .colors.greySubtitleHome),
                                            ),
                                            Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor: Color.fromARGB(
                                                  20, 245, 245, 245),
                                              period: Duration(seconds: 2),
                                              child: Container(
                                                width: 30,
                                                height: 12,
                                                decoration: ShapeDecoration(
                                                    color: Colors.grey[100]!,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                              ),
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
                                                  color: R
                                                      .colors.greySubtitleHome),
                                            ),
                                            Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor: Color.fromARGB(
                                                  20, 245, 245, 245),
                                              period: Duration(seconds: 2),
                                              child: Container(
                                                width: 30,
                                                height: 12,
                                                decoration: ShapeDecoration(
                                                    color: Colors.grey[100]!,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.black12,
                                highlightColor:
                                    Color.fromARGB(20, 245, 245, 245),
                                period: Duration(seconds: 2),
                                child: Container(
                                  width: 50,
                                  height: 45,
                                  decoration: ShapeDecoration(
                                      color: Colors.grey[100]!,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                              )
                            ]),
                          ));
                    },
                  ),
                )
              ],
            )
          : Column(
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
                            "${parsedUsersResponse?.data?[0].nama}",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${parsedUsersResponse?.data?[0].nim}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${parsedUsersResponse?.data?[0].prodi}",
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
                            image: NetworkImage(
                                '${parsedUsersResponse?.data?[0].foto}'),
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
                    itemCount: parsedNilaiResponse?.data?.length,

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
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 21),
                            child: Row(children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${parsedNilaiResponse?.data?[index].kodeMatkul}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: R.colors.greySubtitleHome),
                                    ),
                                    Text(
                                      "${parsedNilaiResponse?.data?[index].namaMatkul}",
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
                                                  color: R
                                                      .colors.greySubtitleHome),
                                            ),
                                            Text(
                                              "${parsedNilaiResponse?.data?[index].sks}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: R
                                                      .colors.greySubtitleHome),
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
                                                  color: R
                                                      .colors.greySubtitleHome),
                                            ),
                                            Text(
                                              "${parsedNilaiResponse?.data?[index].semester}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: R
                                                      .colors.greySubtitleHome),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                "${parsedNilaiResponse?.data?[index].nilaiHuruf}",
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
