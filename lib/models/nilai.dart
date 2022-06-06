class Nilai {
  bool? status;
  List<Data>? data;

  Nilai({this.status, this.data});

  Nilai.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? nim;
  String? kodeMatkul;
  String? namaMatkul;
  String? sks;
  String? nilaiAngka;
  String? nilaiHuruf;
  String? tahun;
  String? semester;

  Data(
      {this.nim,
      this.kodeMatkul,
      this.namaMatkul,
      this.sks,
      this.nilaiAngka,
      this.nilaiHuruf,
      this.tahun,
      this.semester});

  Data.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    kodeMatkul = json['kode_matkul'];
    namaMatkul = json['nama_matkul'];
    sks = json['sks'];
    nilaiAngka = json['nilai_angka'];
    nilaiHuruf = json['nilai_huruf'];
    tahun = json['tahun'];
    semester = json['semester'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nim'] = this.nim;
    data['kode_matkul'] = this.kodeMatkul;
    data['nama_matkul'] = this.namaMatkul;
    data['sks'] = this.sks;
    data['nilai_angka'] = this.nilaiAngka;
    data['nilai_huruf'] = this.nilaiHuruf;
    data['tahun'] = this.tahun;
    data['semester'] = this.semester;
    return data;
  }
}
