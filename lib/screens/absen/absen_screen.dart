import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/color_constant.dart';
import 'package:tugasakhirmobile/viewmodel/absen_viewmodel.dart';

class AbsenPage extends StatefulWidget {
  const AbsenPage({super.key});

  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AbsenViewModel>(context, listen: false).getCurrentDay();
      Provider.of<AbsenViewModel>(context, listen: false).getAbsen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AbsenViewModel>(builder: (context, absenVM, _) {
      return Scaffold(
          body: SafeArea(
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
            absenVM.absenData.isEmpty
                ? CircularProgressIndicator()
                : Center(
                    child: Column(children: [
                      Text(
                        absenVM.getDay.toString(),
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        absenVM.absenData[0].nama.toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "(${absenVM.absenData[0].guru.toString()})",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: Get.width,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: ColorConstant.colorPrimary),
                            onPressed: () {},
                            child: Text("Absen Sekarang")),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: Get.width,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: ColorConstant.colorPrimary),
                            onPressed: () {},
                            child: Text("Riwayat Absen")),
                      )
                    ]),
                  )
          ],
        ),
      )));
    });
  }
}
