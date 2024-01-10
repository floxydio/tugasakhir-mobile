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

  List<DataUjianList> dataUjian = [];
  List<bool> checkAlready = [];

  void getUjianByKelas() async {
    dataUjian = [];

    final ujianRepository = await UjianRepository().getDataUjian();

    ujianRepository.fold(
        (final l) => {EasyLoading.showError(l.message!)},
        (final r) => {
              dataUjian.addAll(r.data!.toList()),
              checkAlready =
                  List.generate(r.data!.toList().length, (final index) => false)
            });

    EasyLoading.dismiss();
    notifyListeners();
  }
}
