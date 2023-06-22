import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/guru_models.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GuruViewModel extends ChangeNotifier {
  List<GuruData> guruData = [];
  String urlLink = dotenv.env["BASE_URL"]!;

  void getGuru() async {
    guruData = [];
    EasyLoading.show(status: 'Loading Get Guru...');
    var response = await Dio().get("$urlLink/v1/guru",
        options: Options(
          headers: {"x-access-token": await SharedPrefs().getAccessToken()},
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
