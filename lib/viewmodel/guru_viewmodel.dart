import 'package:flutter/material.dart';
import 'package:tugasakhirmobile/models/guru_models.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tugasakhirmobile/repository/guru.repo.dart';

class GuruViewModel extends ChangeNotifier {
  List<GuruData> guruData = [];
  void getGuru() async {
    guruData = [];
    EasyLoading.show(status: 'Loading Get Guru...');
    final guruRepo = await GuruRepository().getDataGuru();

    guruRepo.fold((final l) {
      EasyLoading.showError(l.message!);
    }, (final r) {
      guruData.addAll(r.data!.toList());
    });
    EasyLoading.dismiss();
    notifyListeners();
  }
}
