import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tugasakhirmobile/models/create_absen_model.dart';
import 'package:tugasakhirmobile/models/guru_models.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GuruViewModel extends ChangeNotifier {
  List<GuruData> guruData = [];
  String urlLink = "http://103.174.115.58:3000";

  void getGuru() async {
    guruData = [];
    EasyLoading.show(status: 'Loading Get Guru...');
    var response = await Dio().get("$urlLink/v1/guru",
        options: Options(
          
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    if (response.statusCode == 200) {
      guruData.addAll(GuruModel.fromJson(response.data).data!);
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError("Gagal Mengambil Data Guru");
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

}
