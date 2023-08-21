import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/models/ujianrules_model.dart';
import 'package:tugasakhirmobile/viewmodel/ujian_viewmodel.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showNotification();

      Provider.of<UjianViewModel>(context, listen: false).getUjianByKelas();
    });
  }

  var scrollController = ScrollController();

  Future<void> showNotification() {
    return Get.dialog(AlertDialog(
      title: const Text("Peraturan Ujian",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      content: Consumer<UjianViewModel>(builder: (context, ujianVM, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SizedBox(
                width: Get.width,
                height: 450,
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: UjianRules.ujianList.length,
                  shrinkWrap: true,
                  controller: scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    var data = UjianRules.ujianList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: RichText(
                          text: TextSpan(
                              text: "${data.id}.",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              children: [
                            TextSpan(
                                text: "${data.title}: ",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: data.subtitle,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ])
                          ])),
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: ujianVM.isChecked,
                  onChanged: (value) {
                    ujianVM.changeStatusUjian();
                  },
                ),
                const Expanded(
                  child: Text(
                    "Saya menyetujui Terms and Conditions.",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ujianVM.changeStatusUjian();
                },
                child: const Text("Submit")),
          ],
        );
      }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Consumer<UjianViewModel>(
            builder: (context, ujianVM, _) {
              if (ujianVM.dataUjian.isEmpty) {
                return Text("Ujian Tidak Ditemukan");
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: ujianVM.dataUjian.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      var data = ujianVM.dataUjian[i];
                      return ListTile(
                        title: Text(data.namaUjian.toString()),
                      );
                    });
              }
            },
          )
        ]),
      )),
    );
  }
}
