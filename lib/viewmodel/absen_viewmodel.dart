import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/absen_model.dart';
import 'package:tugasakhirmobile/models/create_absen_model.dart';

class AbsenViewModel extends ChangeNotifier {
  String urlLink = "http://103.174.115.58:3000";
  String? getDay;
  int? getIntDay;

  void getCurrentDay() {
    getDay = DateFormat("EEEE").format(DateTime.now());
    if (getDay == "Monday") {
      getDay = "Senin";
    } else if (getDay == "Tuesday") {
      getDay = "Selasa";
    } else if (getDay == "Wednesday") {
      getDay = "Rabu";
    } else if (getDay == "Thursday") {
      getDay = "Kamis";
    } else if (getDay == "Friday") {
      getDay = "Jumat";
    } else if (getDay == "Saturday") {
      getDay = "Sabtu";
    } else if (getDay == "Sunday") {
      getDay = "Minggu";
    }

    if (getDay == "Senin") {
      getIntDay = 1;
    } else if (getDay == "Selasa") {
      getIntDay = 2;
    } else if (getDay == "Rabu") {
      getIntDay = 3;
    } else if (getDay == "Kamis") {
      getIntDay = 4;
    } else if (getDay == "Jumat") {
      getIntDay = 5;
    } else if (getDay == "Sabtu") {
      getIntDay = 6;
    } else if (getDay == "Minggu") {
      getIntDay = 7;
    }
    notifyListeners();
  }

  List<AbsenData> absenData = [];
  bool isLoadingAbsen = false;
  void getAbsen() async {
    isLoadingAbsen = true;
    EasyLoading.show(status: 'Loading Get Absen...');
    absenData = [];
    var kelasId = await SharedPrefs().getKelasId();
    var response = await Dio().get("$urlLink/v1/pelajaran/$getIntDay/$kelasId",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
    print(response.data);
    if (response.statusCode == 200) {
      absenData.addAll(AbsenModel.fromJson(response.data).data!);
      isLoadingAbsen = false;
    }
    notifyListeners();
    EasyLoading.dismiss();
  }

  void createAbsen(CreateAbsen absenForm) async {
    var now = DateTime.now();

    Map<String, dynamic> formData = {
      "user_id": absenForm.userId,
      "guru_id": absenForm.guruId,
      "pelajaran_id": absenForm.pelajaranId,
      "kelas_id": absenForm.kelasId,
      "keterangan": "ABSEN",
      "createdAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(now),
    };
    var response = await Dio().post("$urlLink/v1/absen",
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
    print(response.data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      EasyLoading.showSuccess("Berhasil Absen");
    } else {
      EasyLoading.showError("Gagal Absen");
    }
  }
}