import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/absen_model.dart';
import 'package:tugasakhirmobile/models/absendetail_model.dart';
import 'package:tugasakhirmobile/models/create_absen_model.dart';
import 'package:tugasakhirmobile/models/status_absen_model.dart';
import 'package:tugasakhirmobile/notification/notification_service.dart';
import 'package:tugasakhirmobile/repository/absen.repo.dart';

class AbsenViewModel extends ChangeNotifier {
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
    EasyLoading.show(status: 'Loading Get Absen...');
    absenData = [];
    final kelasId = await SharedPrefs().getKelasId();
    final absenRepo = await AbsenRepository().findAbsen(getIntDay!, kelasId);

    absenRepo.fold((final l) {
      EasyLoading.showError(l.message!);
    }, (final r) => {absenData.addAll(r.data!.toList())});

    EasyLoading.dismiss();
    notifyListeners();
  }

  List<AbsenDataHistory> absenDataHistory = [];

  void getAbsenData() async {
    await EasyLoading.show(status: 'Loading Get History Absen...');
    absenDataHistory = [];
    final absenRepo = await AbsenRepository().statusAbsenData();
    absenRepo.fold((final l) => {EasyLoading.showError(l.message!)},
        (final r) => {absenDataHistory.addAll(r.data!.toList())});
    notifyListeners();
  }

  List<AbsenDataDetail> absenHistoryDetail = [];

  void getAbsenDetailById() async {
    absenHistoryDetail.clear();
    await EasyLoading.show(status: "Tunggu Sebentar...");
    final absenRepo = await AbsenRepository().absenDetail();

    absenRepo.fold((final l) {
      EasyLoading.showError(l.message!);
    }, (final r) {
      absenHistoryDetail.addAll(r.data!.toList());
    });

    await EasyLoading.dismiss();
    notifyListeners();
  }

  void createAbsen(final CreateAbsen absenForm) async {
    final now = DateTime.now();

    final absenRepo = await AbsenRepository().createAbsen(absenForm);

    absenRepo.fold(
        (final l) => {EasyLoading.showError(l.message!)},
        (final r) => {
              NotificationService().showNotification("Berhasil Absen",
                  "Anda Berhasil Absen Pada ${DateFormat.Hms().format(now)}"),
              SharedPrefs().setTodayAbsen(absenForm.pelajaranId)
            });
  }
}
