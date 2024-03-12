import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/color_constant.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/create_absen_model.dart';
import 'package:tugasakhirmobile/notification/notification_service.dart';
import 'package:tugasakhirmobile/viewmodel/absen_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/auth_viewmodel.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((final timeStamp) {
      Provider.of<AbsenViewModel>(context, listen: false).getCurrentDay();
      Provider.of<AbsenViewModel>(context, listen: false).getAbsen();
      Provider.of<AuthViewModel>(context, listen: false).getRefreshToken();
    });
  }

  @override
  Widget build(final BuildContext context) {
    final authVm = Provider.of<AuthViewModel>(context, listen: false);
    return Consumer<AbsenViewModel>(
        builder: (final context, final absenVM, final _) {
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
              const Align(
                  alignment: Alignment.center,
                  child:
                      SizedBox(width: 200, height: 200, child: AnalogClock())),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(children: [
                  Text(
                    absenVM.getDay.toString(),
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: Get.width,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.colorPrimary),
                        onPressed: () async {
                          final data = CreateAbsen(
                              userId: authVm.dataJwt!.id!,
                              keterangan: "ABSEN",
                              reason: "-");
                          final checkAbsen =
                              await SharedPrefs().getAbsenToday();
                          if (checkAbsen == true) {
                            NotificationService().showNotification(
                                "Gagal Absen", "Anda Sudah Absen Hari Ini");
                          } else {
                            // ignore: use_build_context_synchronously
                            Provider.of<AbsenViewModel>(context, listen: false)
                                .createAbsen(data);
                          }
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
                            backgroundColor: ColorConstant.colorPrimary),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (final context) {
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
                                          final data = CreateAbsen(
                                              userId: authVm.dataJwt!.id!,
                                              keterangan: "IZIN",
                                              reason:
                                                  keteranganController.text);
                                          Provider.of<AbsenViewModel>(context,
                                                  listen: false)
                                              .createAbsen(data);
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
