import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/viewmodel/guru_viewmodel.dart';

class GuruScreen extends StatefulWidget {
  const GuruScreen({super.key});

  @override
  State<GuruScreen> createState() => _GuruScreenState();
}

class _GuruScreenState extends State<GuruScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GuruViewModel>(context, listen: false).getGuru();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
                      "Daftar Guru",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Consumer<GuruViewModel>(
                  builder: (final context, final guruVM, final _) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: guruVM.guruData.length,
                        itemBuilder: (final context, final i) {
                          return Card(
                              elevation: 0.2,
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ),
                                title: Text(guruVM.guruData[i].nama!),
                                subtitle: Text(
                                    "Mengajar : ${guruVM.guruData[i].mengajar!}"),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(guruVM.guruData[i].rating.toString())
                                    ]),
                              ));
                        });
                  },
                )
              ],
            )),
      )),
    );
  }
}
