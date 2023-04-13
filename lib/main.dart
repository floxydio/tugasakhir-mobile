import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/repovm/auth_repository.dart';
import 'package:tugasakhirmobile/screens/Login/login_screen.dart';

void main() async {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => AuthRepository())],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
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
    _checkTimer = Timer(
        const Duration(seconds: 1),
        () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()))
            });
    super.initState();
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
