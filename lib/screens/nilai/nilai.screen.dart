import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/viewmodel/nilai_viewmodel.dart';

class NilaiScreen extends StatefulWidget {
  const NilaiScreen({super.key});

  @override
  State<NilaiScreen> createState() => _NilaiScreenState();
}

class _NilaiScreenState extends State<NilaiScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NilaiViewModel>(context, listen: false).getNilai();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Consumer<NilaiViewModel>(
      builder: (_, nilaiVm, __) {
        return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: nilaiVm.nilaiListData.length,
                    itemBuilder: (context, i) {
                      return Card(
                          child: Column(
                        children: [
                          Text("Nilai Semester",
                              style: TextStyle(fontSize: 28)),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Nilai UAS :"), Text("50")],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Nilai UTS :"), Text("70")],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Semester :"), Text("3")],
                            ),
                          )
                        ],
                      ));
                    })
              ],
            ));
      },
    )));
  }
}
