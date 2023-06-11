import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/color_constant.dart';
import 'package:tugasakhirmobile/models/create_absen_model.dart';
import 'package:tugasakhirmobile/viewmodel/absen_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/auth_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

class AbsenPage extends StatefulWidget {
  const AbsenPage({super.key});

  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  final keteranganController = TextEditingController();

  @override
  void dispose() {
    keteranganController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AbsenViewModel>(context, listen: false).getCurrentDay();
    Provider.of<AbsenViewModel>(context, listen: false).getAbsen();
    Provider.of<AuthViewModel>(context, listen: false).getRefreshToken();
  }

  @override
  Widget build(BuildContext context) {
    var authVm = Provider.of<AuthViewModel>(context, listen: false);
    return Consumer<AbsenViewModel>(builder: (context, absenVM, _) {
      return Scaffold(
          body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Text(
                    "Absen",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 200, height: 200, child: const AnalogClock())),
              const SizedBox(
                height: 20,
              ),
              absenVM.absenData.isEmpty
                  ? const Center(child: Text("Jadwal Tidak Ditemukan"))
                  : Center(
                      child: Column(children: [
                        Text(
                          absenVM.getDay.toString(),
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          absenVM.absenData[0].nama.toString(),
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "(${absenVM.absenData[0].guru.toString()})",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: ColorConstant.colorPrimary),
                              onPressed: () {
                                var data = CreateAbsen(
                                    userId: authVm.dataJwt.id!,
                                    guruId: absenVM.absenData[0].guruId!,
                                    kelasId: absenVM.absenData[0].kelasId!,
                                    pelajaranId:
                                        absenVM.absenData[0].pelajaranId!,
                                    keterangan: "ABSEN",
                                    reason: "-");
                                Provider.of<AbsenViewModel>(context,
                                        listen: false)
                                    .createAbsen(context, data);
                              },
                              child: const Text("Absen Sekarang")),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: ColorConstant.colorPrimary),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Izin Absen"),
                                        content: TextFormField(
                                          controller: keteranganController,
                                          decoration: const InputDecoration(
                                              hintText: "Masukkan Alasan"),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Batal")),
                                          TextButton(
                                              onPressed: () {
                                                var data = CreateAbsen(
                                                    userId: authVm.dataJwt.id!,
                                                    guruId: absenVM
                                                        .absenData[0].guruId!,
                                                    kelasId: absenVM
                                                        .absenData[0].kelasId!,
                                                    pelajaranId: absenVM
                                                        .absenData[0]
                                                        .pelajaranId!,
                                                    keterangan: "IZIN",
                                                    reason: keteranganController
                                                        .text);
                                                Provider.of<AbsenViewModel>(
                                                        context,
                                                        listen: false)
                                                    .createAbsen(context, data);
                                                keteranganController.clear();
                                              },
                                              child: const Text("Kirim"))
                                        ],
                                      );
                                    });
                              },
                              child: const Text("Izin Absen")),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ]),
                    )
            ],
          ),
        )),
      ));
    });
  }
}
