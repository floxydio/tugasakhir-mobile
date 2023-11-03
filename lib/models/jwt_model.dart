class JWTModel {
  int? status;
  DataJwt? data;

  JWTModel({this.status, this.data});

  // ignore: prefer_final_parameters
  JWTModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataJwt.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataJwt {
  int? id;
  String? nama;
  int? role;
  int? kelasId;

  DataJwt({this.id, this.nama, this.role});

  DataJwt.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    role = json['role'];
    kelasId = json['kelas_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['role'] = role;
    data['kelas_id'] = kelasId;
    return data;
  }
}
