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
        data!.add(new NilaiList.fromJson(v));
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

class NilaiList {
  int? id;
  int? uts;
  int? uas;
  int? kelasId;
  int? userId;
  int? semester;

  NilaiList(
      {this.id, this.uts, this.uas, this.kelasId, this.userId, this.semester});

  NilaiList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uts = json['uts'];
    uas = json['uas'];
    kelasId = json['kelas_id'];
    userId = json['user_id'];
    semester = json['semester'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uts'] = this.uts;
    data['uas'] = this.uas;
    data['kelas_id'] = this.kelasId;
    data['user_id'] = this.userId;
    data['semester'] = this.semester;
    return data;
  }
}
