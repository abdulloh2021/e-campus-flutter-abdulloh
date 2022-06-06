class DosenDetail {
  bool? status;
  List<Data>? data;

  DosenDetail({this.status, this.data});

  DosenDetail.fromJson(Map<String, dynamic> json) {
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
  String? idDosen;
  String? email;
  String? nomorwhatsapp;
  String? alamat;
  String? foto;
  String? nama;
  String? nidn;
  String? perguruantinggi;
  String? prodi;
  String? tingkatpendidikan;

  Data(
      {this.idDosen,
      this.email,
      this.nomorwhatsapp,
      this.alamat,
      this.foto,
      this.nama,
      this.nidn,
      this.perguruantinggi,
      this.prodi,
      this.tingkatpendidikan});

  Data.fromJson(Map<String, dynamic> json) {
    idDosen = json['id_dosen'];
    email = json['email'];
    nomorwhatsapp = json['nomorwhatsapp'];
    alamat = json['alamat'];
    foto = json['foto'];
    nama = json['nama'];
    nidn = json['nidn'];
    perguruantinggi = json['perguruantinggi'];
    prodi = json['prodi'];
    tingkatpendidikan = json['tingkatpendidikan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_dosen'] = this.idDosen;
    data['email'] = this.email;
    data['nomorwhatsapp'] = this.nomorwhatsapp;
    data['alamat'] = this.alamat;
    data['foto'] = this.foto;
    data['nama'] = this.nama;
    data['nidn'] = this.nidn;
    data['perguruantinggi'] = this.perguruantinggi;
    data['prodi'] = this.prodi;
    data['tingkatpendidikan'] = this.tingkatpendidikan;
    return data;
  }
}
