import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/viewmodel/absen_viewmodel.dart';

class AbsenDetail extends StatefulWidget {
  const AbsenDetail({super.key});

  @override
  State<AbsenDetail> createState() => _AbsenDetailState();
}

class _AbsenDetailState extends State<AbsenDetail> {
  @override
  void initState() {
    super.initState();
    Provider.of<AbsenViewModel>(context, listen: false).getAbsenDetailById();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(body: SafeArea(child: Consumer<AbsenViewModel>(
      builder: (final context, final absenVm, final _) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
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
                      "History Absen",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: absenVm.absenHistoryDetail.length,
                    itemBuilder: (final context, final index) {
                      final data = absenVm.absenHistoryDetail[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                              "${data.pelajaranNama} - ${data.namaGuru}",
                              style: const TextStyle(fontSize: 14)),
                          subtitle: Text(
                              "${data.day} - ${data.month} - ${data.year}"),
                          trailing: data.keterangan == "IZIN"
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40))),
                                  onPressed: () {},
                                  child: const Text("Izin"))
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.greenAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40))),
                                  onPressed: () {},
                                  child: const Text("Absen",
                                      style: TextStyle(color: Colors.black))),
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      },
    )));
  }
}
