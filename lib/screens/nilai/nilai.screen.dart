import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/viewmodel/nilai_viewmodel.dart';

class NilaiScreen extends StatefulWidget {
  const NilaiScreen({super.key});

  @override
  State<NilaiScreen> createState() => _NilaiScreenState();
}

class _NilaiScreenState extends State<NilaiScreen> {
  final semesterController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<NilaiViewModel>(context, listen: false).getNilai(2);
  }

  @override
  void dispose() {
    super.dispose();
    semesterController.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(body: SafeArea(child: SingleChildScrollView(
      child: Consumer<NilaiViewModel>(
        builder: (final _, final nilaiVm, final __) {
          return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: semesterController,
                    decoration:
                        const InputDecoration(hintText: "Masukkan Semester"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            nilaiVm
                                .getNilai(int.parse(semesterController.text));
                          });
                        },
                        child: const Text("Cari Nilai")),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: nilaiVm.nilaiListData.length,
                      itemBuilder: (final context, final i) {
                        return Card(
                            child: Column(
                          children: [
                            const Text("Nilai Semester",
                                style: TextStyle(fontSize: 28)),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Nilai UAS :"),
                                  Text(nilaiVm.nilaiListData[i].uas.toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Nilai UTS :"),
                                  Text(nilaiVm.nilaiListData[i].uts.toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Mata Pelajaran :"),
                                  Text(nilaiVm.nilaiListData[i].nama.toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Semester :"),
                                  Text(nilaiVm.nilaiListData[i].semester
                                      .toString())
                                ],
                              ),
                            )
                          ],
                        ));
                      })
                ],
              ));
        },
      ),
    )));
  }
}
