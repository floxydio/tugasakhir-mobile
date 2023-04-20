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
        data!.add(new AbsenData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class AbsenData {
  String? nama;
  String? guru;
  int? kelasNomor;

  AbsenData({this.nama, this.guru, this.kelasNomor});

  AbsenData.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    guru = json['guru'];
    kelasNomor = json['kelas_nomor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['guru'] = this.guru;
    data['kelas_nomor'] = this.kelasNomor;
    return data;
  }
}
