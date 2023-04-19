import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/screens/Home/home_screen.dart';
import 'package:tugasakhirmobile/viewmodel/auth_repository.dart';
import 'package:tugasakhirmobile/screens/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => AuthRepository())],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    ),
  ));
}

// Stateful untuk membuat state yang dapat berubah / refresh variabel
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _checkTimer; // Untuk Kondisi

  @override
  // InitState adalah fungsi yang pertama kali dijalankan ketika class dibuat
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    var token = await SharedPrefs().getAccessToken();
    if (token.isEmpty) {
      _checkTimer = Timer(
          const Duration(seconds: 1),
          () => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()))
              });
    } else {
      _checkTimer = Timer(
          const Duration(seconds: 1),
          () => {
                Get.offAll(() => const HomeScreen()),
              });
    }
  }

  // Dispose adalah fungsi yang dijalankan ketika class di dispose
  @override
  void dispose() {
    super.dispose();
    _checkTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset("assets/logo.png")),
    );
  }
}
