class AbsenDetail {
  int? status;
  String? message;
  List<AbsenDataDetail>? data;

  AbsenDetail({this.status, this.message, this.data});

  AbsenDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AbsenDataDetail>[];
      json['data'].forEach((v) {
        data!.add( AbsenDataDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AbsenDataDetail {
  int? id;
  String? namaUser;
  String? namaGuru;
  String? pelajaranNama;
  int? nomorKelas;
  String? keterangan;
  int? day;
  int? month;
  int? year;
  String? time;
  String? reason;

  AbsenDataDetail(
      {this.id,
      this.namaUser,
      this.namaGuru,
      this.pelajaranNama,
      this.nomorKelas,
      this.keterangan,
      this.day,
      this.month,
      this.year,
      this.time,
      this.reason});

  AbsenDataDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaUser = json['nama_user'];
    namaGuru = json['nama_guru'];
    pelajaranNama = json['pelajaran_nama'];
    nomorKelas = json['nomor_kelas'];
    keterangan = json['keterangan'];
    day = json['day'];
    month = json['month'];
    year = json['year'];
    time = json['time'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama_user'] = namaUser;
    data['nama_guru'] = namaGuru;
    data['pelajaran_nama'] = pelajaranNama;
    data['nomor_kelas'] = nomorKelas;
    data['keterangan'] = keterangan;
    data['day'] = day;
    data['month'] = month;
    data['year'] = year;
    data['time'] = time;
    data['reason'] = reason;
    return data;
  }
}
