import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/icon_build.dart';
import 'package:tugasakhirmobile/constant/intmonth_constant.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/screens/absen/absen_detail.dart';
import 'package:tugasakhirmobile/screens/absen/absen_screen.dart';
import 'package:tugasakhirmobile/screens/guru/guru_screen.dart';
import 'package:tugasakhirmobile/screens/login/login_screen.dart';
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
        page: const GuruScreen(),
        name: "Guru",
        iconName: Image.asset("assets/guru_icon.png")),
    IconBuild(
        onTap: () {},
        page: const NilaiScreen(),
        name: "Nilai",
        iconName: const Icon(
          Icons.library_add,
          size: 23,
          color: Color(0xff185FA9),
        )),
    IconBuild(
        onTap: () {},
        page: null,
        name: "Logout",
        iconName: const Icon(
          Icons.logout,
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
    Provider.of<AuthViewModel>(context, listen: false).profileImage();
    greeting = getGreeting();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AbsenViewModel>(builder: (context, absenVM, _) {
      return Consumer<AuthViewModel>(builder: (context, authVM, _) {
        return Scaffold(
          backgroundColor: Colors.white,
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
                        authVM.imageData == null && authVM.dataJwt.id == null
                            ? SizedBox()
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
                                          authVM.imageData == "default.jpg"
                                              ? "https://api-ninjas.com/images/cats/abyssinian.jpg"
                                              : "http://103.174.115.58:4500/img-profile/${authVM.imageData}",
                                          fit: BoxFit.fill,
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Class XI-B | Roll no : 04",
                                      ),
                                      title: Text("Hi ${authVM.dataJwt.nama}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30,
                                              color: Colors.white)),
                                    )),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Transform(
                              transform:
                                  Matrix4.translationValues(0.0, -90.0, 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      width: 150,
                                      height: 190,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 19.0, top: 22),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                "assets/ic_attendance.png"),
                                            Text("80%",
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text("ABSEN",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xff777777),
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      )),
                                  Container(
                                      width: 140,
                                      height: 190,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 19.0, top: 22),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                "assets/ic_fees_due.png"),
                                            Text("A",
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text("Grade",
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
                                    Get.to(AbsenDetail());
                                  },
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    title: const Text("Riwayat Absensi"),
                                    leading:
                                        Image.asset("assets/history_icon.png"),
                                    subtitle: const Text(
                                        "Lihat semua riwayat absensi"),
                                    trailing: const Icon(Icons.arrow_right),
                                  ),
                                ),
                                GridView.builder(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: iconBuild.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 40,
                                            mainAxisSpacing: 30),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          iconBuild[index].name != "Logout"
                                              ? Get.to(iconBuild[index].page,
                                                  transition:
                                                      Transition.rightToLeft)
                                              : Provider.of<AuthViewModel>(
                                                      context,
                                                      listen: false)
                                                  .logout();
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
                                                    offset: const Offset(0, 1))
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
  }
}
