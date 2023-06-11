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
    // TODO: implement initState
    super.initState();
    Provider.of<AbsenViewModel>(context, listen: false).getAbsenDetailById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Consumer<AbsenViewModel>(
      builder: (context, absenVm, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              children: [
                Center(child: Text("Data Absen")),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: absenVm.absenHistoryDetail.length,
                    itemBuilder: (context, index) {
                      var data = absenVm.absenHistoryDetail[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                              "${data.pelajaranNama} - ${data.namaGuru}",
                              style: TextStyle(fontSize: 14)),
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
                                  child: Text("Izin"))
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.greenAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40))),
                                  onPressed: () {},
                                  child: Text("Absen",
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
