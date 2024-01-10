import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tugasakhirmobile/models/nilai_model.dart';
import 'package:tugasakhirmobile/repository/nilai.repo.dart';

class NilaiViewModel extends ChangeNotifier {
  List<NilaiList> nilaiListData = [];

  void getNilai(final int semester) async {
    nilaiListData = [];

    final nilaiRepository =
        await NilaiRepository().getNilaiBySemester(semester);

    nilaiRepository.fold((final l) {
      EasyLoading.showError(l.message!);
    }, (final r) {
      nilaiListData.addAll(r.data!.toList());
    });

    notifyListeners();
  }
}
