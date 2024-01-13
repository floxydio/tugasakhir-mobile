import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tugasakhirmobile/models/ujian_nilai_model.dart';
import 'package:tugasakhirmobile/repository/ujian.repo.dart';

class UjianNilaiViewModel extends ChangeNotifier {
  List<NilaiUjianData> nilaiUjianUser = [];

  void getDataNilaiUjian(final int id) async {
    nilaiUjianUser = [];
    final result = await UjianRepository().getNilaiUjianUser(id);
    result.fold((final l) {
      EasyLoading.showError(l.message ?? "Something went wrong");
    }, (final r) {
      nilaiUjianUser = r.data!;
      notifyListeners();
    });
  }
}
