import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhirmobile/models/ujian_form_model.dart';
import 'package:tugasakhirmobile/viewmodel/ujian_soal_viewmodel.dart';
import 'package:get/get.dart';
import 'package:widget_zoom/widget_zoom.dart';

class UjianPlay extends StatefulWidget {
  final int timer;
  const UjianPlay({super.key, required this.timer});

  @override
  State<UjianPlay> createState() => _UjianPlayState();
}

class _UjianPlayState extends State<UjianPlay> with WidgetsBindingObserver {
  final essayController = TextEditingController();
  String? answer;
  int index = 0;
  int indexEssay = 0;
  int nomor = 0;
  Timer? _timer;
  int? seconds = 0;
  bool? isEssay = false;

  void startTimer() {
    seconds = widget.timer;
    _timer = Timer.periodic(const Duration(seconds: 1), (final timer) {
      if (seconds == 0) {
        _timer?.cancel();
      } else {
        setState(() {
          seconds = seconds! - 1;
        });
      }
    });
  }

  Uint8List convertBase64ToImage(final String base64String) {
    return base64Decode(base64String.replaceAll("data:image/jpeg;base64,", ""));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Provider.of<UjianSoalViewModel>(context, listen: false).fetchUjian();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    essayController.dispose();
    _timer?.cancel();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    var sharedPrefs = SharedPreferences.getInstance();
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        // stop timer with same second and start again when active
          

        break;
      case AppLifecycleState.paused:
        // App is in the background
        break;
      case AppLifecycleState.resumed:
        // App is in the foreground
        break;
      case AppLifecycleState.detached:
        // App is terminating
        sharedPrefs.then((final value) => value.setInt("lastTimer", seconds!));
        break;
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Consumer<UjianSoalViewModel>(
        builder: (final context, final ujianVM, final _) {
      return Scaffold(
          backgroundColor: const Color(0xff252C4A),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                index == 0
                    ? const SizedBox()
                    : SizedBox(
                        width: Get.width,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                index--;
                                nomor--;
                              });
                            },
                            child: const Text('Back')),
                      ),
                const SizedBox(
                  height: 20,
                ),
                //  question first
                isEssay == false
                    ? index == ujianVM.questions.length - 1
                        ? SizedBox(
                            width: Get.width,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  // final sharedPrefs =
                                  //     SharedPreferences.getInstance();
                                  // final formSubmit = UjianFormSubmit(
                                  //     semester: ujianVM.semester!,
                                  //     jawabanPg: Provider.of<UjianSoalViewModel>(
                                  //             context,
                                  //             listen: false)
                                  //         .jawabanPilihanRadio,
                                  //     jawabanEssay: Provider.of<UjianSoalViewModel>(
                                  //             context,
                                  //             listen: false)
                                  //         .jawabanEssay);
                                  // Provider.of<UjianSoalViewModel>(context,
                                  //         listen: false)
                                  //     .sendUjian(formSubmit, () {
                                  //   Navigator.pop(context);
                                  //   // Remove last timer
                                  //   sharedPrefs.then(
                                  //       (final value) => value.remove("lastTimer"));
                                  //   // Delete all value after submit
                                  //   Provider.of<UjianSoalViewModel>(context,
                                  //           listen: false)
                                  //       .jawabanPilihanRadio
                                  //       .clear();
                                  // });
                                  if (ujianVM.essay.isNotEmpty) {
                                    setState(() {
                                      isEssay = true;
                                    });
                                  }
                                },
                                child: const Text("Submit Pilihan Ganda")),
                          )
                        : SizedBox(
                            width: Get.width,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (Provider.of<UjianSoalViewModel>(context,
                                                listen: false)
                                            .jawabanPilihanRadio
                                            .length ==
                                        index) {
                                      Fluttertoast.showToast(
                                          msg: "Pilih Jawaban Terlebih Dahulu",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      index++;
                                      nomor++;
                                    }
                                  });
                                },
                                child: const Text("Selanjutnya")),
                          )
                    : (indexEssay == ujianVM.essay.length - 1)
                        ? SizedBox(
                            width: Get.width,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  Provider.of<UjianSoalViewModel>(context,
                                          listen: false)
                                      .jawabanEssay
                                      .add(essayController.text);
                                  final sharedPrefs =
                                      SharedPreferences.getInstance();
                                  final formSubmit = UjianFormSubmit(
                                      semester: ujianVM.semester!,
                                      jawabanPg:
                                          Provider.of<UjianSoalViewModel>(
                                                  context,
                                                  listen: false)
                                              .jawabanPilihanRadio,
                                      jawabanEssay:
                                          Provider.of<UjianSoalViewModel>(
                                                  context,
                                                  listen: false)
                                              .jawabanEssay);
                                  Provider.of<UjianSoalViewModel>(context,
                                          listen: false)
                                      .sendUjian(formSubmit, () {
                                    Navigator.pop(context);
                                    // Remove last timer
                                    sharedPrefs.then((final value) =>
                                        value.remove("lastTimer"));
                                    // Delete all value after submit
                                    Provider.of<UjianSoalViewModel>(context,
                                            listen: false)
                                        .jawabanPilihanRadio
                                        .clear();
                                    Provider.of<UjianSoalViewModel>(context,
                                            listen: false)
                                        .resetJawabanEssay();
                                  });
                                },
                                child: const Text(
                                    "Submit Essay dan Pilihan Ganda")),
                          )
                        : SizedBox(
                            width: Get.width,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (essayController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Isi Jawaban Terlebih Dahulu",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      Provider.of<UjianSoalViewModel>(context,
                                              listen: false)
                                          .jawabanEssay
                                          .add(essayController.text);
                                      essayController.clear();
                                      indexEssay++;
                                    }
                                  });
                                },
                                child: const Text("Selanjutnya")),
                          ),

                // (index ==
                //         Provider.of<UjianSoalViewModel>(context, listen: false)
                //                 .questions
                //                 .length -
                //             1)
                //     ? SizedBox(
                //         width: Get.width,
                //         height: 50,
                //         child: ElevatedButton(
                //             onPressed: () {
                //               final sharedPrefs =
                //                   SharedPreferences.getInstance();
                //               final formSubmit = UjianFormSubmit(
                //                   semester: ujianVM.semester!,
                //                   jawabanPg: Provider.of<UjianSoalViewModel>(
                //                           context,
                //                           listen: false)
                //                       .jawabanPilihanRadio,
                //                   jawabanEssay: Provider.of<UjianSoalViewModel>(
                //                           context,
                //                           listen: false)
                //                       .jawabanEssay);
                //               Provider.of<UjianSoalViewModel>(context,
                //                       listen: false)
                //                   .sendUjian(formSubmit, () {
                //                 Navigator.pop(context);
                //                 // Remove last timer
                //                 sharedPrefs.then(
                //                     (final value) => value.remove("lastTimer"));
                //                 // Delete all value after submit
                //                 Provider.of<UjianSoalViewModel>(context,
                //                         listen: false)
                //                     .jawabanPilihanRadio
                //                     .clear();
                //               });
                //             },
                //             child: const Text("Selanjutnya")),
                //       )
                //     : SizedBox(
                //         width: Get.width,
                //         height: 50,
                //         child: ElevatedButton(
                //             onPressed: () {
                //               setState(() {
                //                 if (Provider.of<UjianSoalViewModel>(context,
                //                             listen: false)
                //                         .jawabanPilihanRadio
                //                         .length ==
                //                     index) {
                //                   Fluttertoast.showToast(
                //                       msg: "Pilih Jawaban Terlebih Dahulu",
                //                       toastLength: Toast.LENGTH_SHORT,
                //                       gravity: ToastGravity.CENTER,
                //                       timeInSecForIosWeb: 2,
                //                       backgroundColor: Colors.red,
                //                       textColor: Colors.white,
                //                       fontSize: 16.0);
                //                 } else {
                //                   index++;
                //                   nomor++;
                //                 }
                //               });
                //             },
                //             child: const Text("Selanjutnya")),
                //       )
                //  SizedBox(
                //           width: Get.width,
                //           height: 50,
                //           child: ElevatedButton(
                //               onPressed: () {
                //                 setState(() {
                //                   if (essayController.text.isEmpty) {
                //                     Fluttertoast.showToast(
                //                         msg: "Isi Jawaban Terlebih Dahulu",
                //                         toastLength: Toast.LENGTH_SHORT,
                //                         gravity: ToastGravity.CENTER,
                //                         timeInSecForIosWeb: 2,
                //                         backgroundColor: Colors.red,
                //                         textColor: Colors.white,
                //                         fontSize: 16.0);
                //                   } else {
                //                     Provider.of<UjianSoalViewModel>(context,
                //                             listen: false)
                //                         .jawabanEssay
                //                         .add(essayController.text);
                //                     essayController.clear();
                //                     index++;
                //                     nomor++;
                //                   }
                //                 });
                //               },
                //               child: const Text("Selanjutnya")),
                //         ),
              ],
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              final sharedPrefs = await SharedPreferences.getInstance();
              Get.defaultDialog(
                  title: "Peringatan",
                  middleText: "Apakah anda yakin ingin keluar?",
                  textConfirm: "Ya",
                  textCancel: "Tidak",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    sharedPrefs.setInt("lastTimer", seconds! ~/ 60);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    // dismiss dialog
                    // Get.back();
                  });
              return false;
            },
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.timelapse,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              "${(seconds! ~/ 60).toString().padLeft(2, '0')}:${(seconds! % 60).toString().padLeft(2, '0')}",
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0, bottom: 10, top: 50),
                      child: Text("Question Pilihan Ganda",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB4B9CD))),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
                      child: Divider(
                        color: Colors.white,
                        thickness: 0.3,
                      ),
                    ),
                    isEssay == false
                        ? ujianVM.questions.isEmpty
                            ? const CircularProgressIndicator()
                            : index < ujianVM.questions.length
                                ? ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    title: Text(
                                      ujianVM.questions[index].soal,
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                    subtitle: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListView.builder(
                                              itemCount: ujianVM
                                                  .questions[index]
                                                  .pilihan
                                                  .length,
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemBuilder:
                                                  (final context, final i) {
                                                return ujianVM.questions[index]
                                                            .pilihan[i][1] ==
                                                        ""
                                                    ? const SizedBox()
                                                    : RadioListTile(
                                                        activeColor:
                                                            Colors.white,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        value: ujianVM
                                                            .questions[index]
                                                            .pilihan[i][0],
                                                        groupValue: ujianVM
                                                                        .jawabanPilihanRadio ==
                                                                    [] ||
                                                                ujianVM
                                                                    .jawabanPilihanRadio
                                                                    .isEmpty
                                                            ? ""
                                                            : index <
                                                                    ujianVM
                                                                        .jawabanPilihanRadio
                                                                        .length
                                                                ? ujianVM
                                                                        .jawabanPilihanRadio[
                                                                    index]
                                                                : "",
                                                        onChanged:
                                                            (final value) {
                                                          ujianVM.onChangeJawaban(
                                                              value.toString(),
                                                              index);
                                                        },
                                                        title: ujianVM
                                                                .questions[
                                                                    index]
                                                                .pilihan[i][1]
                                                                .toString()
                                                                .contains(
                                                                    "data:image/")
                                                            ? WidgetZoom(
                                                                heroAnimationTag:
                                                                    UniqueKey(),
                                                                zoomWidget:
                                                                    Image
                                                                        .memory(
                                                                  convertBase64ToImage(ujianVM
                                                                      .questions[
                                                                          index]
                                                                      .pilihan[i][1]),
                                                                  width: 100,
                                                                  height: 100,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ))
                                                            : Text(
                                                                ujianVM
                                                                        .questions[
                                                                            index]
                                                                        .pilihan[
                                                                    i][1],
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                      );
                                              }),
                                        ]),
                                  )
                                : const SizedBox()
                        : const SizedBox(),
                    isEssay == true
                        ? ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 30, right: 30),
                            title: Text(
                              ujianVM.essay[indexEssay].soal,
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.white),
                            ),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: essayController,
                                  maxLines: 10,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Jawaban"),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
