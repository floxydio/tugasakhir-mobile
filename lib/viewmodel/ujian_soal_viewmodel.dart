import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhirmobile/models/ujian_form_model.dart';
import 'package:tugasakhirmobile/models/ujian_soal_model.dart';
import 'package:tugasakhirmobile/repository/ujian.repo.dart';
import 'package:tugasakhirmobile/screens/ujian/ujian_play_screen.dart';

class UjianSoalViewModel extends ChangeNotifier {
  List<Question> questions = [];
  List<Essay> essay = [];
  int? idUjian;
  List<String> jawabanPilihanRadio = [];
  List<String> jawabanEssay = [];
  int? semester;
  int? timer;

  void changeIndex(final int id, final List<bool> exam, final int index,
      final int timerExam) {
    idUjian = id;
    timer = timerExam;
    checkExam(id, exam, index);
    notifyListeners();
  }

  void sendUjian(
      final UjianFormSubmit formSubmit, final VoidCallback onSuccess) async {
    final ujianSoalRepository =
        await UjianRepository().sendUjian(formSubmit, idUjian!);
    ujianSoalRepository.fold((final l) {
      EasyLoading.showError(l.message!);
    }, (final r) {
      EasyLoading.showSuccess("Sukses Ujian");
      onSuccess();
    });
    notifyListeners();
  }

  void resetJawabanEssay() {
    jawabanEssay = [];
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
      semester = r.semester;
    });
    notifyListeners();
  }

  void checkExam(
      final int idujian, final List<bool> checkExam, final int index) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final checkTimer = sharedPrefs.getInt("lastTimer");
    final fixTimer = checkTimer ?? timer!;
    final ujianRepository = await UjianRepository().checkExam(idujian);
    ujianRepository.fold(
        (final l) => {EasyLoading.showError(l.message!)},
        (final r) => {
              if (r.status == true)
                {checkExam[index] = true}
              else
                {
                  Get.to(UjianPlay(
                    timer: fixTimer * 60,
                  ))
                }
            });

    EasyLoading.dismiss();
    notifyListeners();
  }

  void onChangeJawaban(final String value, final int index) {
    if (jawabanPilihanRadio == [] || jawabanPilihanRadio.isEmpty) {
      jawabanPilihanRadio.add(value.toString());
    } else if (index < jawabanPilihanRadio.length) {
      jawabanPilihanRadio[index] = value.toString();
    } else {
      jawabanPilihanRadio.add(value.toString());
    }
    notifyListeners();
  }
}
