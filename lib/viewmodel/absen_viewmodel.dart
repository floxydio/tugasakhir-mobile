import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/absen_model.dart';
import 'package:tugasakhirmobile/models/absendetail_model.dart';
import 'package:tugasakhirmobile/models/create_absen_model.dart';
import 'package:tugasakhirmobile/models/status_absen_model.dart';
import 'package:tugasakhirmobile/notification/notification_service.dart';

class AbsenViewModel extends ChangeNotifier {
  String urlLink = dotenv.env["BASE_URL"]!;
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

    var response = await Dio().get("$urlLink/v2/pelajaran/$getIntDay/$kelasId",
        options: Options(
          headers: {"x-access-token": await SharedPrefs().getAccessToken()},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
    if (response.statusCode == 200) {
      absenData.addAll(AbsenModel.fromJson(response.data).data!);
      isLoadingAbsen = false;
    }
    notifyListeners();
    EasyLoading.dismiss();
  }

  List<AbsenDataHistory> absenDataHistory = [];

  void getAbsenData() async {
    await EasyLoading.show(status: 'Loading Get History Absen...');

    absenDataHistory = [];

    var idUser = await SharedPrefs().getIdUser();
    var month = DateTime.now().month;

    var response = await Dio().get("$urlLink/v2/absen/$idUser/$month",
        options: Options(
          headers: {"x-access-token": await SharedPrefs().getAccessToken()},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
    if (response.statusCode == 200) {
      absenDataHistory
          .addAll(StatusAbsen.fromJson(response.data).data!.toList());
      await EasyLoading.dismiss();
    } else {
      await EasyLoading.showError("Error In Get History Absen");
    }
    notifyListeners();
  }

  List<AbsenDataDetail> absenHistoryDetail = [];

  void getAbsenDetailById() async {
    absenHistoryDetail.clear();
    await EasyLoading.show(status: "Tunggu Sebentar...");
    var idUser = await SharedPrefs().getIdUser();
    var month = DateTime.now().month;
    var response = await Dio().get("$urlLink/v2/absen/detail/$idUser/$month",
        options: Options(
          headers: {"x-access-token": await SharedPrefs().getAccessToken()},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
    if (response.statusCode == 200) {
      absenHistoryDetail
          .addAll(AbsenDetail.fromJson(response.data).data!.toList());
    } else {
      await EasyLoading.showError("Error, Hubungi admin");
    }
    await EasyLoading.dismiss();
    notifyListeners();
  }

  void createAbsen(BuildContext context, CreateAbsen absenForm) async {
    var now = DateTime.now();

    Map<String, dynamic> formData = {
      "user_id": absenForm.userId,
      "guru_id": absenForm.guruId,
      "pelajaran_id": absenForm.pelajaranId,
      "kelas_id": absenForm.kelasId,
      "keterangan": absenForm.keterangan,
      "reason": absenForm.reason,
      "day": "${now.day}",
      "month": "${now.month}",
      "year": "${now.year}",
      "time": DateFormat.Hms().format(now)
    };
    var response = await Dio().post("$urlLink/v2/absen",
        data: formData,
        options: Options(
          headers: {"x-access-token": await SharedPrefs().getAccessToken()},
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
    if (response.statusCode == 201 || response.statusCode == 200) {
      NotificationService().showNotification("Berhasil Absen",
          "Anda Berhasil Absen Pada ${DateFormat.Hms().format(now)}");
      SharedPrefs().setTodayAbsen(absenForm.pelajaranId);
    } else {
      EasyLoading.showError(response.data["message"]);
    }
  }
}
