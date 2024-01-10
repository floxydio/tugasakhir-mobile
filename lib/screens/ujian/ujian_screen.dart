// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/color_constant.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/ujianrules_model.dart';
import 'package:tugasakhirmobile/viewmodel/absen_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/auth_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/ujian_soal_viewmodel.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((final timeStamp) {
      // showNotification();
      Provider.of<UjianViewModel>(context, listen: false).getUjianByKelas();
      Provider.of<AbsenViewModel>(context, listen: false).getAbsen();
      Provider.of<AbsenViewModel>(context, listen: false).getCurrentDay();
      Provider.of<AuthViewModel>(context, listen: false).getRefreshToken();
    });
  }

  var scrollController = ScrollController();

  Future<void> showNotification() {
    return Get.dialog(AlertDialog(
      title: const Text("Peraturan Ujian",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      content: Consumer<UjianViewModel>(
          builder: (final context, final ujianVM, final _) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                child: SizedBox(
                  width: Get.width,
                  height: 400,
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: UjianRules.ujianList.length,
                    shrinkWrap: true,
                    controller: scrollController,
                    itemBuilder: (final BuildContext context, final int index) {
                      final data = UjianRules.ujianList[index];
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
                    onChanged: (final value) {
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
          ),
        );
      }),
    ));
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Consumer<AbsenViewModel>(
              builder: (final context, final absenVM, final _) {
            return Consumer<UjianSoalViewModel>(
                builder: (final context, final ujianSoalVM, final _) {
              return Consumer<UjianViewModel>(
                builder: (final context, final ujianVM, final _) {
                  if (ujianVM.dataUjian.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.colorPrimary,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40))),
                            width: Get.width,
                            height: 300,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Daftar Ujian / Ulangan",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            showNotification();
                                          },
                                          icon: const Icon(
                                            Icons.menu,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            "Peraturan",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      TextButton.icon(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.library_add,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            "Nilai",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        Transform(
                          transform: Matrix4.translationValues(0, -30, 0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              itemCount: ujianVM.dataUjian.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (final context, final i) {
                                final data = ujianVM.dataUjian[i];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        ujianVM.dataUjian[i].pelajaran?.nama ??
                                            "",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(data.namaUjian.toString()),
                                        ],
                                      ),
                                      trailing: Column(
                                        children: [
                                          TextButton.icon(
                                            onPressed: () async {
                                              Provider.of<UjianSoalViewModel>(
                                                      context,
                                                      listen: false)
                                                  .changeIndex(
                                                      data.ujianId!,
                                                      ujianVM.checkAlready,
                                                      i,
                                                      data.durasi!);
                                            },
                                            icon: ujianVM.checkAlready[i]
                                                ? const SizedBox()
                                                : const Icon(Icons.book),
                                            label: Text(
                                              ujianVM.checkAlready[i]
                                                  ? "Sudah Ujian"
                                                  : "Mulai Ujian",
                                              style: TextStyle(
                                                  color: ujianVM.checkAlready[i]
                                                      ? Colors.grey
                                                      : Colors.blueAccent),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  }
                },
              );
            });
          })
        ]),
      )),
    );
  }
}
