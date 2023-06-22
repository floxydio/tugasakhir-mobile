class AbsenModel {
  int? status;
  List<AbsenData>? data;
  String? message;

  AbsenModel({this.status, this.data, this.message});

  AbsenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AbsenData>[];
      json['data'].forEach((v) {
        data!.add(AbsenData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class AbsenData {
  int? kelasId;
  int? guruId;
  int? pelajaranId;
  String? nama;
  String? guru;
  int? kelasNomor;

  AbsenData(
      {this.kelasId,
      this.guruId,
      this.pelajaranId,
      this.nama,
      this.guru,
      this.kelasNomor});

  AbsenData.fromJson(Map<String, dynamic> json) {
    kelasId = json["kelas_id"];
    guruId = json["guru_id"];
    pelajaranId = json["pelajaran_id"];
    nama = json['nama'];
    guru = json['guru'];
    kelasNomor = json['kelas_nomor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kelas_id'] = kelasId;
    data['guru_id'] = guruId;
    data['pelajaran_id'] = pelajaranId;
    data['nama'] = nama;
    data['guru'] = guru;
    data['kelas_nomor'] = kelasNomor;
    return data;
  }
}
