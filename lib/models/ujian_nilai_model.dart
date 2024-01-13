class NilaiUjianModel {
  int? status;
  String? message;
  List<NilaiUjianData>? data;

  NilaiUjianModel({this.status, this.message, this.data});

  NilaiUjianModel.fromJson(final Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NilaiUjianData>[];
      json['data'].forEach((final v) {
        data!.add(NilaiUjianData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((final v) => v.toJson()).toList();
    }
    return data;
  }
}

class NilaiUjianData {
  int? jawabanUserId;
  int? siswaId;
  int? ujianId;
  int? totalBenar;
  int? totalSalah;
  int? semester;
  String? logHistory;
  Ujian? ujian;

  NilaiUjianData(
      {this.jawabanUserId,
      this.siswaId,
      this.ujianId,
      this.totalBenar,
      this.totalSalah,
      this.semester,
      this.logHistory,
      this.ujian});

  NilaiUjianData.fromJson(final Map<String, dynamic> json) {
    jawabanUserId = json['jawaban_user_id'];
    siswaId = json['siswa_id'];
    ujianId = json['ujian_id'];
    totalBenar = json['total_benar'];
    totalSalah = json['total_salah'];
    semester = json['semester'];
    logHistory = json['log_history'];
    ujian = json['ujian'] != null ? Ujian.fromJson(json['ujian']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jawaban_user_id'] = jawabanUserId;
    data['siswa_id'] = siswaId;
    data['ujian_id'] = ujianId;
    data['total_benar'] = totalBenar;
    data['total_salah'] = totalSalah;
    data['semester'] = semester;
    data['log_history'] = logHistory;
    if (ujian != null) {
      data['ujian'] = ujian!.toJson();
    }
    return data;
  }
}

class Ujian {
  int? ujianId;
  String? namaUjian;
  Pelajaran? pelajaran;

  Ujian({this.ujianId, this.namaUjian, this.pelajaran});

  Ujian.fromJson(final Map<String, dynamic> json) {
    ujianId = json['ujian_id'];
    namaUjian = json['nama_ujian'];
    pelajaran = json['pelajaran'] != null
        ? Pelajaran.fromJson(json['pelajaran'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ujian_id'] = ujianId;
    data['nama_ujian'] = namaUjian;
    if (pelajaran != null) {
      data['pelajaran'] = pelajaran!.toJson();
    }
    return data;
  }
}

class Pelajaran {
  String? nama;
  int? pelajaranId;

  Pelajaran({this.nama, this.pelajaranId});

  Pelajaran.fromJson(final Map<String, dynamic> json) {
    nama = json['nama'];
    pelajaranId = json['pelajaran_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['pelajaran_id'] = pelajaranId;
    return data;
  }
}
