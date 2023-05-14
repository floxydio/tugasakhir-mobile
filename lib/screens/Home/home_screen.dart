import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/icon_build.dart';
import 'package:tugasakhirmobile/screens/absen/absen_screen.dart';
import 'package:tugasakhirmobile/screens/guru/guru_screen.dart';
import 'package:tugasakhirmobile/viewmodel/auth_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconBuild> iconBuild = [
    IconBuild(
        page: const AbsenPage(),
        name: "Absen",
        iconName: const Icon(Icons.book)),
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
        iconName: const Icon(Icons.people)),
    // IconBuild(
    //     page: const AbsenPage(),
    //     name: "Nilai",
    //     iconName: const Icon(Icons.pending_actions_outlined))
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<AuthViewModel>(context, listen: false).getRefreshToken();
  }

  @override
  Widget build(BuildContext context) {
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
                color: Color(0xff00448B),
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Selamat Malam,\n${authVM.dataJwt.nama}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white)),
                            InkWell(
                              onTap: () {
                                authVM.logout();
                              },
                              child: CircleAvatar(
                                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                    "https://randomuser.me/api/portraits/women/78.jpg"),
                              )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(children: [
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffF1F7B5),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Absen Masuk - Juni"),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("25", style: TextStyle(fontSize: 26)),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ]))),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffFD8A8A),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Total Akumulasi Nilai"),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("B", style: TextStyle(fontSize: 26)),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ])))
                        ])
                      ],
                    )),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                padding: const EdgeInsets.only(left: 20.0),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/slider_dummy.png",
                                fit: BoxFit.fill,
                                height: 150,
                                width: 270,
                              ),
                            ),
                          ),
                      ],
                    )),
              ),
              const SizedBox(height: 30),
              GridView.builder(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: iconBuild.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            borderRadius: BorderRadius.circular(100),
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
                                    fontWeight: FontWeight.bold, fontSize: 16))
                          ],
                        ),
                      ),
                    );
                  })
            ],
          )),
        ),
      );
    });
  }
}
