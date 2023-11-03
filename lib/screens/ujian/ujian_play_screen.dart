import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/viewmodel/ujian_soal_viewmodel.dart';
import 'package:get/get.dart';

class UjianPlay extends StatefulWidget {
  const UjianPlay({super.key});

  @override
  State<UjianPlay> createState() => _UjianPlayState();
}

class _UjianPlayState extends State<UjianPlay> with WidgetsBindingObserver {
  List<String> jawabanPilihanRadio = [];
  List<String> jawabanEssay = [];
  final TextEditingController essayController = TextEditingController();
  String? answer;
  int index = 1;
  @override
  void initState() {
    super.initState();
    Provider.of<UjianSoalViewModel>(context, listen: false).fetchUjian();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    essayController.dispose();
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
                            });
                          },
                          child: const Text('Back')),
                    ),
              const SizedBox(
                height: 20,
              ),
              (index + 1 ==
                      Provider.of<UjianSoalViewModel>(context, listen: false)
                              .questions
                              .length +
                          Provider.of<UjianSoalViewModel>(context,
                                  listen: false)
                              .essay
                              .length)
                  ? SizedBox(
                      width: Get.width,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            jawabanEssay.add(essayController.text);
                          },
                          child: const Text("Submit")),
                    )
                  : SizedBox(
                      width: Get.width,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              index++;
                              if (index >
                                  Provider.of<UjianSoalViewModel>(context,
                                          listen: false)
                                      .questions
                                      .length) {
                                jawabanEssay.add(essayController.text);
                                essayController.clear();
                              }
                            });
                          },
                          child: const Text("Selanjutnya")),
                    ),
            ],
          ),
        ),
        body: SafeArea(
          child: Consumer<UjianSoalViewModel>(
              builder: (final context, final ujianVM, final _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, bottom: 10, top: 50),
                  child: Text(
                      "Question ${index + 1}/${ujianVM.questions.length + ujianVM.essay.length}",
                      style: const TextStyle(
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
                                      itemBuilder: (final context, final i) {
                                        return ujianVM.questions[index]
                                                    .pilihan[i][1] ==
                                                ""
                                            ? const SizedBox()
                                            : RadioListTile(
                                                activeColor: Colors.white,
                                                contentPadding: EdgeInsets.zero,
                                                value: ujianVM.questions[index]
                                                    .pilihan[i][0],
                                                groupValue: jawabanPilihanRadio ==
                                                            [] ||
                                                        jawabanPilihanRadio
                                                            .isEmpty
                                                    ? ""
                                                    : index <
                                                            jawabanPilihanRadio
                                                                .length
                                                        ? jawabanPilihanRadio[
                                                            index]
                                                        : "",
                                                onChanged: (final value) {
                                                  setState(() {
                                                    if (jawabanPilihanRadio ==
                                                            [] ||
                                                        jawabanPilihanRadio
                                                            .isEmpty) {
                                                      jawabanPilihanRadio.add(
                                                          value.toString());
                                                    } else if (index <
                                                        jawabanPilihanRadio
                                                            .length) {
                                                      jawabanPilihanRadio[
                                                              index] =
                                                          value.toString();
                                                    } else {
                                                      jawabanPilihanRadio.add(
                                                          value.toString());
                                                    }
                                                  });
                                                },
                                                title: Text(
                                                    ujianVM.questions[index]
                                                        .pilihan[i][1],
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                              );
                                      }),
                                ]),
                          )
                        : index == ujianVM.questions.length ||
                                index > ujianVM.questions.length
                            ? ListTile(
                                contentPadding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                title: Text(
                                  ujianVM
                                      .essay[index - ujianVM.questions.length]
                                      .soal,
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
                            : const SizedBox(),
              ],
            );
          }),
        ));
  }
}
