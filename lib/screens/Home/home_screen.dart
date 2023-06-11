import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/icon_build.dart';
import 'package:tugasakhirmobile/constant/intmonth_constant.dart';
import 'package:tugasakhirmobile/screens/absen/absen_detail.dart';
import 'package:tugasakhirmobile/screens/absen/absen_screen.dart';
import 'package:tugasakhirmobile/screens/guru/guru_screen.dart';
import 'package:tugasakhirmobile/screens/nilai/nilai.screen.dart';
import 'package:tugasakhirmobile/viewmodel/absen_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/auth_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var month = IntToMonth.monthConverter(DateTime.now().month);
  String greeting = '';

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      return 'Selamat pagi';
    } else if (hour >= 12 && hour < 15) {
      return 'Selamat siang';
    } else if (hour >= 15 && hour < 18) {
      return 'Selamat sore';
    } else {
      return 'Selamat malam';
    }
  }

  List<IconBuild> iconBuild = [
    IconBuild(
        page: const AbsenPage(),
        name: "Absen",
        iconName: Image.asset("assets/absen_icon.png")),
    // IconBuild(
    //     page: const AbsenPage(),
    //     name: "Mapel",
    //     iconName: const Icon(Icons.my_library_books_sharp)),
    // IconBuild(
    //     page: const AbsenPage(),
    //     name: "Ebook",
    //     iconName: const Icon(Icons.book)),
    IconBuild(
        page: const GuruScreen(),
        name: "Guru",
        iconName: Image.asset("assets/guru_icon.png")),
    IconBuild(
        page: const NilaiScreen(),
        name: "Nilai",
        iconName: const Icon(
          Icons.library_add,
          size: 23,
          color: Color(0xff185FA9),
        ))
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<AuthViewModel>(context, listen: false).getRefreshToken().then(
        (value) => {
              Provider.of<AbsenViewModel>(context, listen: false).getAbsenData()
            });
    greeting = getGreeting();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AbsenViewModel>(builder: (context, absenVM, _) {
      return Consumer<AuthViewModel>(builder: (context, authVM, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  height: 320,
                  color: const Color(0xff00448B),
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              "https://randomuser.me/api/portraits/women/78.jpg",
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("${greeting},",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white)),
                          Text("${authVM.dataJwt.nama}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white)),

                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text("$greeting,\n${authVM.dataJwt.nama}",
                          //         style: const TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 18,
                          //             color: Colors.white)),
                          //     InkWell(
                          //       onTap: () {
                          //         authVM.logout();
                          //       },
                          //       child: CircleAvatar(
                          //           child: ClipRRect(
                          //         borderRadius: BorderRadius.circular(100),
                          //         child: Image.network(
                          //             "https://randomuser.me/api/portraits/women/78.jpg"),
                          //       )),
                          //     )
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 30,
                          // ),
                          // Row(children: [
                          //   Expanded(
                          //       child: Container(
                          //           decoration: BoxDecoration(
                          //               color: const Color(0xffF1F7B5),
                          //               borderRadius:
                          //                   BorderRadius.circular(10)),
                          //           child: Column(children: [
                          //             const SizedBox(
                          //               height: 5,
                          //             ),
                          //             Text(
                          //               "Absen Masuk - $month",
                          //               textAlign: TextAlign.center,
                          //             ),
                          //             const SizedBox(
                          //               height: 20,
                          //             ),
                          //             absenVM.absenDataHistory.isEmpty
                          //                 ? SizedBox()
                          //                 : Text(
                          //                     "${absenVM.absenDataHistory[0].totalAbsen}",
                          //                     style: const TextStyle(
                          //                         fontSize: 26)),
                          //             const SizedBox(
                          //               height: 10,
                          //             )
                          //           ]))),
                          //   const SizedBox(
                          //     width: 10,
                          //   ),
                          //   Expanded(
                          //       child: Container(
                          //           decoration: BoxDecoration(
                          //               color: const Color(0xffFD8A8A),
                          //               borderRadius:
                          //                   BorderRadius.circular(10)),
                          //           child: Column(children: const [
                          //             SizedBox(
                          //               height: 5,
                          //             ),
                          //             Text(
                          //               "Total Akumulasi Nilai",
                          //               textAlign: TextAlign.center,
                          //             ),
                          //             SizedBox(
                          //               height: 20,
                          //             ),
                          //             Text("B", style: TextStyle(fontSize: 26)),
                          //             SizedBox(
                          //               height: 10,
                          //             )
                          //           ])))
                          // ])
                        ],
                      )),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                    width: Get.width / 1.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Data Absensi",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.calendar_month,
                                      color: Colors.blueAccent),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Text("Total Absen"),
                                      absenVM.absenDataHistory.isEmpty
                                          ? const SizedBox()
                                          : Text(
                                              "${absenVM.absenDataHistory[0].totalAbsen} hari",
                                              style: const TextStyle(
                                                  fontSize: 22)),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.calendar_month,
                                      color: Colors.redAccent),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Text("Total Alpha"),
                                      absenVM.absenDataHistory.isEmpty
                                          ? const SizedBox()
                                          : Text(
                                              "${absenVM.absenDataHistory[0].totalAlpha} hari",
                                              style: const TextStyle(
                                                  fontSize: 22)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(AbsenDetail());
                    },
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 40, right: 40),
                      title: const Text("Riwayat Absensi"),
                      leading: Image.asset("assets/history_icon.png"),
                      subtitle: const Text("Lihat semua riwayat absensi"),
                      trailing: const Icon(Icons.arrow_right),
                    ),
                  ),
                )
                // Container(
                //   transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                //   padding: const EdgeInsets.only(left: 20.0),
                //   child: SingleChildScrollView(
                //       scrollDirection: Axis.horizontal,
                //       physics: const BouncingScrollPhysics(),
                //       child: Row(
                //         children: [
                //           for (int i = 0; i < 3; i++)
                //             Padding(
                //               padding: const EdgeInsets.only(right: 10),
                //               child: ClipRRect(
                //                 borderRadius: BorderRadius.circular(10),
                //                 child: Image.asset(
                //                   "assets/slider_dummy.png",
                //                   fit: BoxFit.fill,
                //                   height: 150,
                //                   width: 270,
                //                 ),
                //               ),
                //             ),
                //         ],
                //       )),
                // ),
                // const SizedBox(height: 30),
                ,
                GridView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: iconBuild.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 40,
                            mainAxisSpacing: 30),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(iconBuild[index].page,
                              transition: Transition.rightToLeft);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              iconBuild[index].iconName,
                              const SizedBox(height: 10),
                              Text(iconBuild[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ],
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 60),
              ],
            )),
          ),
        );
      });
    });
  }
}
