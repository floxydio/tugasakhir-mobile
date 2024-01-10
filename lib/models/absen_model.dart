class AbsenModel {
  int? status;
  List<AbsenData>? data;
  String? message;

  AbsenModel({this.status, this.data, this.message});

  AbsenModel.fromJson(final Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AbsenData>[];
      json['data'].forEach((final v) {
        data!.add(AbsenData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((final v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class AbsenData {
  int? pelajaranId;
  String? nama;
  Kelas? kelas;
  Users? users;

  AbsenData({this.pelajaranId, this.nama, this.kelas, this.users});

  AbsenData.fromJson(final Map<String, dynamic> json) {
    pelajaranId = json['pelajaran_id'];
    nama = json['nama'];
    kelas = json['kelas'] != null ? Kelas.fromJson(json['kelas']) : null;
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pelajaran_id'] = pelajaranId;
    data['nama'] = nama;
    if (kelas != null) {
      data['kelas'] = kelas!.toJson();
    }
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}

class Kelas {
  int? id;
  int? nomor;

  Kelas({this.id, this.nomor});

  Kelas.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    nomor = json['nomor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nomor'] = nomor;
    return data;
  }
}

class Users {
  int? userId;
  String? nama;

  Users({this.userId, this.nama});

  Users.fromJson(final Map<String, dynamic> json) {
    userId = json['user_id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['nama'] = nama;
    return data;
  }
}
