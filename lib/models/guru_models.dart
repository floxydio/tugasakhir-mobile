class GuruModel {
  int? status;
  List<GuruData>? data;
  String? message;

  GuruModel({this.status, this.data, this.message});

  GuruModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GuruData>[];
      json['data'].forEach((v) {
        data!.add(GuruData.fromJson(v));
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

class GuruData {
  int? id;
  String? nama;
  String? mengajar;
  int? statusGuru;
  int? rating;

  GuruData({this.id, this.nama, this.mengajar, this.statusGuru, this.rating});

  GuruData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    mengajar = json['mengajar'];
    statusGuru = json['status_guru'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['mengajar'] = mengajar;
    data['status_guru'] = statusGuru;
    data['rating'] = rating;
    return data;
  }
}
