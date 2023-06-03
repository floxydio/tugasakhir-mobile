class StatusAbsen {
  int? status;
  String? message;
  List<AbsenDataHistory>? data;

  StatusAbsen({this.status, this.message, this.data});

  StatusAbsen.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AbsenDataHistory>[];
      json['data'].forEach((v) {
        data!.add(AbsenDataHistory.fromJson(v));
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

class AbsenDataHistory {
  String? totalAbsen;
  String? totalIzin;
  String? totalAlpha;

  AbsenDataHistory({this.totalAbsen, this.totalIzin, this.totalAlpha});

  AbsenDataHistory.fromJson(Map<String, dynamic> json) {
    totalAbsen = json['total_absen'];
    totalIzin = json['total_izin'];
    totalAlpha = json['total_alpha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_absen'] = totalAbsen;
    data['total_izin'] = totalIzin;
    data['total_alpha'] = totalAlpha;
    return data;
  }
}
