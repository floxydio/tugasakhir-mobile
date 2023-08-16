class NilaiData {
  int? status;
  List<NilaiList>? data;
  String? message;

  NilaiData({this.status, this.data, this.message});

  NilaiData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <NilaiList>[];
      json['data'].forEach((v) {
        data!.add( NilaiList.fromJson(v));
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

class NilaiList {
  int? id;
  int? uts;
  int? uas;
  int? kelasId;
  int? userId;
  int? semester;
  String? nama;

  NilaiList(
      {this.id, this.uts, this.uas, this.kelasId, this.userId, this.semester,this.nama});

  NilaiList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uts = json['uts'];
    uas = json['uas'];
    kelasId = json['kelas_id'];
    userId = json['user_id'];
    semester = json['semester'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uts'] = uts;
    data['uas'] = uas;
    data['kelas_id'] = kelasId;
    data['user_id'] = userId;
    data['semester'] = semester;
    data['nama'] = nama;
    return data;
  }
}
