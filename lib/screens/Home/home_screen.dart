import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/icon_build.dart';
import 'package:tugasakhirmobile/viewmodel/auth_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconBuild> iconBuild = [
    IconBuild(name: "Absen", iconName: const Icon(Icons.book)),
    IconBuild(
        name: "Mapel", iconName: const Icon(Icons.my_library_books_sharp)),
    IconBuild(name: "Ebook", iconName: const Icon(Icons.book)),
    IconBuild(name: "Guru", iconName: const Icon(Icons.people)),
    IconBuild(
        name: "Nilai", iconName: const Icon(Icons.pending_actions_outlined))
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<AuthRepository>(context, listen: false).getRefreshToken();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRepository>(builder: (context, authVM, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 25),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Halo, ${authVM.dataJwt.nama}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    CircleAvatar(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                          "https://randomuser.me/api/portraits/women/78.jpg"),
                    ))
                  ],
                )),
            const SizedBox(
              height: 100,
            ),
            SingleChildScrollView(
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
                  return Container(
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
                  );
                })
          ],
        )),
      );
    });
  }
}
