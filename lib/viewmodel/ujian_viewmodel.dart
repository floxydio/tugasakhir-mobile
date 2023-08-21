import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tugasakhirmobile/models/ujian_data_model.dart';
import 'package:tugasakhirmobile/repository/ujian.repo.dart';

class UjianViewModel extends ChangeNotifier {
  bool isChecked = false;

  void changeStatusUjian() {
    isChecked = !isChecked;
    notifyListeners();
  }

  List<DataUjian> dataUjian = [];

  void getUjianByKelas() async {
    dataUjian = [];

    var ujianRepository = await UjianRepository().getDataUjian();

    ujianRepository.fold((l) => {EasyLoading.showError(l.message!)},
        (r) => {dataUjian.addAll(r.data!.dataUjian!.toList())});

    EasyLoading.dismiss();
    notifyListeners();
  }
}
