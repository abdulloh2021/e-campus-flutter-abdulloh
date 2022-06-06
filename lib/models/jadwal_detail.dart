class JadwalDetail {
  bool? status;
  List<Data>? data;

  JadwalDetail({this.status, this.data});

  JadwalDetail.fromJson(Map<String, dynamic> json) {
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
  String? idJadwalMataKuliah;
  String? kodeMatkul;
  String? namaMatkul;
  String? namaDosen;
  String? email;
  String? nomorwhatsapp;
  String? foto;
  String? sks;
  String? hari;
  String? jamMulai;
  String? jamSelesai;
  String? tahun;
  String? linkClassroom;
  String? linkMeet;
  String? semester;

  Data(
      {this.nim,
      this.idJadwalMataKuliah,
      this.kodeMatkul,
      this.namaMatkul,
      this.namaDosen,
      this.email,
      this.nomorwhatsapp,
      this.foto,
      this.sks,
      this.hari,
      this.jamMulai,
      this.jamSelesai,
      this.tahun,
      this.linkClassroom,
      this.linkMeet,
      this.semester});

  Data.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    idJadwalMataKuliah = json['id_jadwal_mata_kuliah'];
    kodeMatkul = json['kode_matkul'];
    namaMatkul = json['nama_matkul'];
    namaDosen = json['nama_dosen'];
    email = json['email'];
    nomorwhatsapp = json['nomorwhatsapp'];
    foto = json['foto'];
    sks = json['sks'];
    hari = json['hari'];
    jamMulai = json['jam_mulai'];
    jamSelesai = json['jam_selesai'];
    tahun = json['tahun'];
    linkClassroom = json['link_classroom'];
    linkMeet = json['link_meet'];
    semester = json['semester'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nim'] = this.nim;
    data['id_jadwal_mata_kuliah'] = this.idJadwalMataKuliah;
    data['kode_matkul'] = this.kodeMatkul;
    data['nama_matkul'] = this.namaMatkul;
    data['nama_dosen'] = this.namaDosen;
    data['email'] = this.email;
    data['nomorwhatsapp'] = this.nomorwhatsapp;
    data['foto'] = this.foto;
    data['sks'] = this.sks;
    data['hari'] = this.hari;
    data['jam_mulai'] = this.jamMulai;
    data['jam_selesai'] = this.jamSelesai;
    data['tahun'] = this.tahun;
    data['link_classroom'] = this.linkClassroom;
    data['link_meet'] = this.linkMeet;
    data['semester'] = this.semester;
    return data;
  }
}
