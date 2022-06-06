class Users {
  bool? status;
  List<Data>? data;

  Users({this.status, this.data});

  Users.fromJson(Map<String, dynamic> json) {
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
  String? alamat;
  String? angkatan;
  String? email;
  String? jenisKelamin;
  String? nama;
  String? noHp;
  String? prodi;
  String? status;
  String? foto;
  String? semester;

  Data(
      {this.nim,
      this.alamat,
      this.angkatan,
      this.email,
      this.jenisKelamin,
      this.nama,
      this.noHp,
      this.prodi,
      this.status,
      this.foto,
      this.semester});

  Data.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    alamat = json['alamat'];
    angkatan = json['angkatan'];
    email = json['email'];
    jenisKelamin = json['jenis_kelamin'];
    nama = json['nama'];
    noHp = json['no_hp'];
    prodi = json['prodi'];
    status = json['status'];
    foto = json['foto'];
    semester = json['semester'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nim'] = this.nim;
    data['alamat'] = this.alamat;
    data['angkatan'] = this.angkatan;
    data['email'] = this.email;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['nama'] = this.nama;
    data['no_hp'] = this.noHp;
    data['prodi'] = this.prodi;
    data['status'] = this.status;
    data['foto'] = this.foto;
    data['semester'] = this.semester;
    return data;
  }
}
