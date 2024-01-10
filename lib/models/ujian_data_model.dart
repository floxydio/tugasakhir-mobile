class UjianList {
  int? status;
  List<DataUjianList>? data;
  String? message;

  UjianList({this.status, this.data, this.message});

  UjianList.fromJson(final Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataUjianList>[];
      json['data'].forEach((final v) {
        data!.add(DataUjianList.fromJson(v));
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

class DataUjianList {
  String? namaUjian;
  String? tanggal;
  int? ujianId;
  int? durasi;
  String? jamMulai;
  String? keterangan;
  int? statusUjian;
  int? totalSoal;
  Pelajaran? pelajaran;

  DataUjianList(
      {this.namaUjian,
      this.tanggal,
      this.ujianId,
      this.durasi,
      this.jamMulai,
      this.keterangan,
      this.statusUjian,
      this.totalSoal,
      this.pelajaran});

  DataUjianList.fromJson(final Map<String, dynamic> json) {
    namaUjian = json['nama_ujian'];
    tanggal = json['tanggal'];
    ujianId = json['ujian_id'];
    durasi = json['durasi'];
    jamMulai = json['jam_mulai'];
    keterangan = json['keterangan'];
    statusUjian = json['status_ujian'];
    totalSoal = json['total_soal'];
    pelajaran = json['pelajaran'] != null
        ? Pelajaran.fromJson(json['pelajaran'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_ujian'] = namaUjian;
    data['tanggal'] = tanggal;
    data['ujian_id'] = ujianId;
    data['durasi'] = durasi;
    data['jam_mulai'] = jamMulai;
    data['keterangan'] = keterangan;
    data['status_ujian'] = statusUjian;
    data['total_soal'] = totalSoal;
    if (pelajaran != null) {
      data['pelajaran'] = pelajaran!.toJson();
    }
    return data;
  }
}

class Pelajaran {
  String? nama;
  int? guruId;

  Pelajaran({this.nama, this.guruId});

  Pelajaran.fromJson(final Map<String, dynamic> json) {
    nama = json['nama'];
    guruId = json['guru_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['guru_id'] = guruId;
    return data;
  }
}
