import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/firebase_options.dart';
import 'package:tugasakhirmobile/screens/bottombar/bottombar.dart';
import 'package:tugasakhirmobile/screens/home/home_screen.dart';
import 'package:tugasakhirmobile/viewmodel/absen_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/auth_viewmodel.dart';
import 'package:tugasakhirmobile/screens/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tugasakhirmobile/viewmodel/guru_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugasakhirmobile/viewmodel/nilai_viewmodel.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AbsenViewModel()),
      ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ChangeNotifierProvider(create: (context) => GuruViewModel()),
      ChangeNotifierProvider(create: (context) => NilaiViewModel())
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
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
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())));
    } else {
      _checkTimer = Timer(const Duration(seconds: 1), () {
        Get.offAll(() => const HomeScreen());
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
      backgroundColor: const Color(0xff345FB4),
      body: SafeArea(
        child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Image.asset(
                  "assets/splash.png",
                  width: 250,
                ))),
      ),
    );
  }
}
