import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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

  void changeIndex(final int id) {
    idUjian = id;
    checkExam(id);

    notifyListeners();
  }

  void sendUjian(final UjianFormSubmit formSubmit) async {
    final ujianSoalRepository =
        await UjianRepository().sendUjian(formSubmit, idUjian!);
    ujianSoalRepository.fold((final l) {
      EasyLoading.showError(l.message!);
    }, (final r) {
      EasyLoading.showSuccess("Sukses Ujian");
    });
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

  void checkExam(final int idujian) async {
    final ujianRepository = await UjianRepository().checkExam(idujian);

    ujianRepository.fold(
        (final l) => {EasyLoading.showError(l.message!)},
        (final r) => {
              if (r.status == true)
                {
                  Fluttertoast.showToast(
                      msg: "Maaf! Kamu telah mengerjakan ujian ini",
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM),
                }
              else
                {Get.to(const UjianPlay())}
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
