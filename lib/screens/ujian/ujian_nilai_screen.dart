import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/color_constant.dart';
import 'package:tugasakhirmobile/viewmodel/auth_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/ujian_nilai_viewmodel.dart';

class UjianNilaiPage extends StatefulWidget {
  final int userId;
  const UjianNilaiPage({super.key, required this.userId});

  @override
  State<UjianNilaiPage> createState() => _UjianNilaiPageState();
}

class _UjianNilaiPageState extends State<UjianNilaiPage> {
  @override
  void initState() {
    fetchAllData();
    super.initState();
  }

  void fetchAllData() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      Provider.of<AuthViewModel>(context, listen: false).getRefreshToken();
      Provider.of<UjianNilaiViewModel>(context, listen: false)
          .getDataNilaiUjian(widget.userId);
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Consumer<UjianNilaiViewModel>(
        builder: (final context, final nilaiVM, final _) {
      return Consumer<AuthViewModel>(
          builder: (final context, final authVM, final _) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: ColorConstant.colorPrimary,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    width: Get.width,
                    height: 200,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Nilai Ujian / Ulangan",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: nilaiVM.nilaiUjianUser.length,
                    itemBuilder: (final context, final i) {
                      final data = nilaiVM.nilaiUjianUser[i];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              data.ujian!.pelajaran!.nama ?? "",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                "${data.ujian!.namaUjian ?? ""} - Semester ${data.semester ?? ""}",
                                style: const TextStyle(fontSize: 12)),
                            trailing: data.logHistory == "Menunggu Review"
                                ? TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Menunggu Review",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic),
                                    ))
                                : TextButton(
                                    onPressed: () {
                                      // show dialog and show data
                                      showDialog(
                                          context: context,
                                          builder: (final context) {
                                            return AlertDialog(
                                              title: Text(
                                                  "Hasil Ujian/Ulangan ${data.ujian!.pelajaran!.nama ?? ""}"),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                          "Total Benar : "),
                                                      Text(
                                                        "${data.totalBenar ?? ""}",
                                                        style: const TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 30),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                          "Total Salah : "),
                                                      Text(
                                                        "${data.totalSalah ?? ""}",
                                                        style: const TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Tutup"))
                                              ],
                                            );
                                          });
                                    },
                                    child: const Text("Detail >")),
                          ),
                        ),
                      );
                    })
              ],
            )),
          ),
        );
      });
    });
  }
}
