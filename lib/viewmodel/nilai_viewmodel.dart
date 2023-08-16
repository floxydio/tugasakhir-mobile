import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tugasakhirmobile/models/nilai_model.dart';
import 'package:tugasakhirmobile/repository/nilai.repo.dart';


class NilaiViewModel extends ChangeNotifier {
  List<NilaiList> nilaiListData = [];

  void getNilai(int semester) async {
    nilaiListData = [];

    var nilaiRepository = await NilaiRepository().getNilaiBySemester(semester);

    nilaiRepository.fold((l) {
      EasyLoading.showError(l.message!);
    }, (r) {
      nilaiListData.addAll(r.data!.toList());
    });

    notifyListeners();
  }
}
