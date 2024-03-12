import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/icon_build.dart';
import 'package:tugasakhirmobile/constant/intmonth_constant.dart';
import 'package:tugasakhirmobile/notification/notification_service.dart';
import 'package:tugasakhirmobile/screens/absen/absen_detail.dart';
import 'package:tugasakhirmobile/screens/absen/absen_screen.dart';
import 'package:tugasakhirmobile/screens/profile/profile_screen.dart';
import 'package:tugasakhirmobile/screens/ujian/ujian_screen.dart';
import 'package:tugasakhirmobile/viewmodel/absen_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/auth_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/settings_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var month = IntToMonth.monthConverter(DateTime.now().month);
  String greeting = '';
  String imageNetwork = "";
  final notificationService = NotificationService();

  String getGreeting() {
    final hour = DateTime.now().hour;
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
        onTap: () {},
        page: const AbsenPage(),
        name: "Absen",
        iconName: const Icon(
          Icons.timelapse,
          size: 23,
          color: Color(0xff185FA9),
        )),
    IconBuild(
        onTap: () {},
        page: const ExamScreen(),
        name: "Ujian",
        iconName: const Icon(
          Icons.menu_book_rounded,
          size: 23,
          color: Color(0xff185FA9),
        )),
    // IconBuild(
    //     onTap: () {},
    //     page: const NilaiScreen(),
    //     name: "Nilai",
    //     iconName: const Icon(
    //       Icons.library_add,
    //       size: 23,
    //       color: Color(0xff185FA9),
    //     )),
    // IconBuild(
    //   onTap: () {},
    //   page: null,
    //   name: "Catatan",
    //   iconName: const Icon(Icons.note_alt, size: 23, color: Color(0xff185FA9)),
    // ),
    IconBuild(
      onTap: () {},
      page: null,
      name: "Profile",
      iconName: const Icon(Icons.person, size: 23, color: Color(0xff185FA9)),
    ),
    IconBuild(
        onTap: () {},
        page: null,
        name: "Logout",
        iconName: const Icon(
          Icons.logout,
          size: 23,
          color: Color(0xff185FA9),
        )),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      Provider.of<SettingsViewModel>(context, listen: false).loadEnvUrl();

      Provider.of<AuthViewModel>(context, listen: false).getRefreshToken();
      Provider.of<AuthViewModel>(context, listen: false).profileImage();
      Provider.of<AbsenViewModel>(context, listen: false).getAbsenData();
    });
    greeting = getGreeting();
  }

  @override
  Widget build(final BuildContext context) {
    return Consumer<SettingsViewModel>(
        builder: (final context, final settingsVM, final _) {
      return Consumer<AbsenViewModel>(
          builder: (final context, final absenVM, final _) {
        return Consumer<AuthViewModel>(
            builder: (final context, final authVM, final _) {
          return Scaffold(
            backgroundColor: Colors.white,
            drawer: Drawer(
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.update),
                      title: const Text("Check Update"),
                      onTap: () {
                        // Navigator.pop(context);
                        Get.dialog(
                          AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Kamu menggunakan versi terakhir"),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "====== Change Log 0.92 ======",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                    "1. Perbaikan dialog pada fitur daftar ujian"),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                    "2. Optimasi performa aplikasi dan perbaikan pada bug"),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                    "3. Fitur untuk mengantisipasi status waktu ketika exit ujian atau aplikasi crash"),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                    "4. Perubahan Terhadap beberapa design"),
                                // Button Close
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("Tutup"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.warning),
                      title: const Text("Keluhan / Kritik / Saran"),
                      onTap: () {
                        // Navigator.pop(context);
                        // Get.toNamed("/settings");
                        Get.dialog(AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Email: diooktar@gmail.com"),
                              // Button Close
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Tutup"),
                                ),
                              )
                            ],
                          ),
                        ));
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: SafeArea(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          authVM.imageData == null && authVM.dataJwt == null
                              ? const SizedBox()
                              : Container(
                                  width: Get.width,
                                  height: 250,
                                  color: const Color(0xff345FB4),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        trailing: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            "https://api-ninjas.com/images/cats/abyssinian.jpg",
                                            fit: BoxFit.fill,
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                        title: Text(
                                            "Hi, ${authVM.dataJwt!.nama}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 30,
                                                color: Colors.white)),
                                      )),
                                ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Transform(
                                transform:
                                    Matrix4.translationValues(0.0, -90.0, 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        NotificationService().showNotification(
                                            "Berhasil Absen",
                                            "Anda Berhasil Absen Pada ${DateTime.now()}");
                                      },
                                      child: Container(
                                          height: 190,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: const Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 19.0, top: 22, right: 19),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                    "assets/ic_attendance.png"),
                                                const Text("80%",
                                                    style: TextStyle(
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const Text("ABSEN",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xff777777),
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          )),
                                    ),
                                    Container(
                                        height: 190,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 19.0, top: 22, right: 19),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                  "assets/ic_fees_due.png"),
                                              const Text("A",
                                                  style: TextStyle(
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text("Grade",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xff777777),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ))
                                  ],
                                )),
                          ),
                          Transform(
                              transform:
                                  Matrix4.translationValues(0.0, -70.0, 0.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(const AbsenDetail());
                                    },
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 40, right: 40),
                                      title: const Text("Riwayat Absensi"),
                                      leading: Image.asset(
                                          "assets/history_icon.png"),
                                      subtitle: const Text(
                                          "Lihat semua riwayat absensi"),
                                      trailing: const Icon(Icons.arrow_right),
                                    ),
                                  ),
                                  GridView.builder(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 30),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: iconBuild.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 30),
                                      itemBuilder:
                                          (final context, final index) {
                                        return InkWell(
                                          onTap: () {
                                            if (iconBuild[index].name ==
                                                "Catatan") {
                                              Get.dialog(AlertDialog(
                                                content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              child: const Icon(
                                                                  Icons
                                                                      .close))),
                                                      const Text(
                                                          "Maaf untuk fitur ini belum tersedia")
                                                    ]),
                                              ));
                                            } else {
                                              iconBuild[index].name !=
                                                          "Logout" &&
                                                      iconBuild[index].name !=
                                                          "Profile"
                                                  ? Get.to(
                                                      iconBuild[index].page,
                                                      transition: Transition
                                                          .rightToLeft)
                                                  : iconBuild[index].name ==
                                                          "Profile"
                                                      ? Get.to(ProfilePage(
                                                          imageNetwork: authVM
                                                              .imageData!))
                                                      : Provider.of<
                                                                  AuthViewModel>(
                                                              context,
                                                              listen: false)
                                                          .logout();
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset:
                                                          const Offset(0, 1))
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                iconBuild[index].iconName,
                                                const SizedBox(height: 10),
                                                Text(iconBuild[index].name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16))
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Version: 0.8.0 (Beta)",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 60),
                                ],
                              )),
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      });
    });
  }
}
