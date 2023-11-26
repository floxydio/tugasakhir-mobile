import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/models/ujian_form_model.dart';
import 'package:tugasakhirmobile/viewmodel/ujian_soal_viewmodel.dart';
import 'package:get/get.dart';

class UjianPlay extends StatefulWidget {
  const UjianPlay({super.key});

  @override
  State<UjianPlay> createState() => _UjianPlayState();
}

class _UjianPlayState extends State<UjianPlay> with WidgetsBindingObserver {
  final essayController = TextEditingController();
  String? answer;
  int index = 0;
  int nomor = 0;
  Timer? _timer;
  int _seconds = 60 * 60;

  // void startTimer() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (final timer) {
  //     if (_seconds == 0) {
  //       _timer?.cancel();
  //     } else {
  //       setState(() {
  //         _seconds--;
  //       });
  //     }
  //   });
  // }

  Uint8List convertBase64ToImage(final String base64String) {
    return base64Decode(base64String.replaceAll("data:image/jpeg;base64,", ""));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<UjianSoalViewModel>(context, listen: false).fetchUjian();
    // startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    essayController.dispose();
    _timer?.cancel();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        // App is in the background
        break;
      case AppLifecycleState.resumed:
        // App is in the foreground
        break;
      case AppLifecycleState.detached:
        // App is terminating
        break;
    }
  }

  @override
  Widget build(final BuildContext context) {
    print("Build ?");
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
              (index ==
                      Provider.of<UjianSoalViewModel>(context, listen: false)
                              .questions
                              .length -
                          1)
                  ? SizedBox(
                      width: Get.width,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            final formSubmit = UjianFormSubmit(
                                jawabanPg: Provider.of<UjianSoalViewModel>(
                                        context,
                                        listen: false)
                                    .jawabanPilihanRadio,
                                jawabanEssay: Provider.of<UjianSoalViewModel>(
                                        context,
                                        listen: false)
                                    .jawabanEssay);
                            Provider.of<UjianSoalViewModel>(context,
                                    listen: false)
                                .sendUjian(formSubmit);
                          },
                          child: const Text("Submit")),
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
                    ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Consumer<UjianSoalViewModel>(
                builder: (final context, final ujianVM, final _) {
              return Column(
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
                            "${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}",
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
                    padding: EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
                    child: Divider(
                      color: Colors.white,
                      thickness: 0.3,
                    ),
                  ),
                  ujianVM.questions.isEmpty
                      ? const CircularProgressIndicator()
                      : index < ujianVM.questions.length
                          ? ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: 30, right: 30),
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
                                            .questions[index].pilihan.length,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (final context, final i) {
                                          return ujianVM.questions[index]
                                                      .pilihan[i][1] ==
                                                  ""
                                              ? const SizedBox()
                                              : RadioListTile(
                                                  activeColor: Colors.white,
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
                                                  onChanged: (final value) {
                                                    ujianVM.onChangeJawaban(
                                                        value.toString(),
                                                        index);
                                                  },
                                                  title: ujianVM
                                                          .questions[index]
                                                          .pilihan[i][1]
                                                          .toString()
                                                          .contains(
                                                              "data:image/")
                                                      ? Image.memory(
                                                          convertBase64ToImage(
                                                              ujianVM
                                                                      .questions[
                                                                          index]
                                                                      .pilihan[
                                                                  i][1]),
                                                          height: 100,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Text(
                                                          ujianVM
                                                              .questions[index]
                                                              .pilihan[i][1],
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                );
                                        }),
                                  ]),
                            )
                          : const SizedBox(),
                  // ujianVM.essay.isEmpty
                  //     ? SizedBox()
                  //     : index > ujianVM.questions.length
                  //         ? ListTile(
                  //             contentPadding:
                  //                 const EdgeInsets.only(left: 30, right: 30),
                  //             title: Text(
                  //               ujianVM
                  //                   .essay[index - ujianVM.questions.length].soal,
                  //               style: const TextStyle(
                  //                   fontSize: 25, color: Colors.white),
                  //             ),
                  //             subtitle: Column(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 const SizedBox(
                  //                   height: 20,
                  //                 ),
                  //                 TextFormField(
                  //                   controller: essayController,
                  //                   maxLines: 10,
                  //                   decoration: const InputDecoration(
                  //                       border: OutlineInputBorder(
                  //                           borderRadius: BorderRadius.all(
                  //                               Radius.circular(20))),
                  //                       fillColor: Colors.white,
                  //                       filled: true,
                  //                       hintText: "Jawaban"),
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //         : const SizedBox(),
                ],
              );
            }),
          ),
        ));
  }
}
