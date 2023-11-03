import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tugasakhirmobile/models/ujian_soal_model.dart';
import 'package:tugasakhirmobile/repository/ujian.repo.dart';

class UjianSoalViewModel extends ChangeNotifier {
  List<Question> questions = [];
  List<Essay> essay = [];
  int? idUjian;

  void changeIndex(final int id) {
    idUjian = id;
    notifyListeners();
  }

  void fetchUjian() async {
    questions = [];
    essay = [];
    final ujianSoalRepository =
        await UjianRepository().getDetailUjian(idUjian!);
    ujianSoalRepository.fold((final l) {
      EasyLoading.showError(l.message!);
    }, (final r) {
      questions.addAll(r.soal);
      if (r.essay.isNotEmpty) {
        essay.addAll(r.essay);
      }
    });
    notifyListeners();
  }
}
