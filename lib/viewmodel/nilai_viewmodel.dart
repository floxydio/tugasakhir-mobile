import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tugasakhirmobile/models/nilai_model.dart';

import '../constant/shared_pref.dart';

class NilaiViewModel extends ChangeNotifier {
  List<NilaiList> nilaiListData = [];
  String urlLink = "http://103.174.115.58:3000";

  void getNilai() async {
    nilaiListData = [];
    var id = await SharedPrefs().getIdUser();
    await EasyLoading.show(status: 'Loading Get Nilai...');
    var response = await Dio().get("$urlLink/v1/nilai/$id",
        options: Options(
          headers: {"x-access-token": await SharedPrefs().getAccessToken()},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
    print(response.data);
    if (response.statusCode == 200) {
      nilaiListData.addAll(NilaiData.fromJson(response.data).data!);
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError("Gagal Mengambil Data Nilai");
    }
    EasyLoading.dismiss();
    notifyListeners();
  }
}
