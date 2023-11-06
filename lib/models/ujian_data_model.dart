class UjianList {
  int? status;
  Datas? data;
  String? message;

  UjianList({this.status, this.data, this.message});

  UjianList.fromJson(final Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Datas.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Datas {
  List<DataUjian>? dataUjian;

  Datas({this.dataUjian});

  Datas.fromJson(final Map<String, dynamic> json) {
    if (json['data_ujian'] != null) {
      dataUjian = <DataUjian>[];
      json['data_ujian'].forEach((final v) {
        dataUjian!.add(DataUjian.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataUjian != null) {
      data['data_ujian'] = dataUjian!.map((final v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataUjian {
  int? id;
  String? namaUjian;
  String? createdAt;
  int? durasi;
  String? jamMulai;
  String? keterangan;
  int? mataPelajaran;
  int? statusUjian;
  String? tanggal;
  int? kelasId;
  int? totalSoal;

  DataUjian(
      {this.id,
      this.namaUjian,
      this.createdAt,
      this.durasi,
      this.jamMulai,
      this.keterangan,
      this.mataPelajaran,
      this.statusUjian,
      this.tanggal,
      this.kelasId,
      this.totalSoal});

  DataUjian.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    namaUjian = json['nama_ujian'];
    createdAt = json['createdAt'];
    durasi = json['durasi'];
    jamMulai = json['jam_mulai'];
    keterangan = json['keterangan'];
    mataPelajaran = json['mata_pelajaran'];
    statusUjian = json['status_ujian'];
    tanggal = json['tanggal'];
    kelasId = json['kelas_id'];
    totalSoal = json['total_soal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama_ujian'] = namaUjian;
    data['createdAt'] = createdAt;
    data['durasi'] = durasi;
    data['jam_mulai'] = jamMulai;
    data['keterangan'] = keterangan;
    data['mata_pelajaran'] = mataPelajaran;
    data['status_ujian'] = statusUjian;
    data['tanggal'] = tanggal;
    data['kelas_id'] = kelasId;
    data['total_soal'] = totalSoal;
    return data;
  }
}

