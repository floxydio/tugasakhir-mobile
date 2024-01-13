import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/firebase_options.dart';
import 'package:tugasakhirmobile/screens/home/home_screen.dart';
import 'package:tugasakhirmobile/viewmodel/absen_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/auth_viewmodel.dart';
import 'package:tugasakhirmobile/screens/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tugasakhirmobile/viewmodel/guru_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugasakhirmobile/viewmodel/nilai_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/settings_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/ujian_nilai_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/ujian_soal_viewmodel.dart';
import 'package:tugasakhirmobile/viewmodel/ujian_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (final context) => UjianSoalViewModel()),
      ChangeNotifierProvider(create: (final context) => AbsenViewModel()),
      ChangeNotifierProvider(create: (final context) => AuthViewModel()),
      ChangeNotifierProvider(create: (final context) => GuruViewModel()),
      ChangeNotifierProvider(create: (final context) => NilaiViewModel()),
      ChangeNotifierProvider(create: (final context) => UjianViewModel()),
      ChangeNotifierProvider(create: (final context) => SettingsViewModel()),
      ChangeNotifierProvider(create: (final context) => UjianNilaiViewModel())
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      builder: EasyLoading.init(),
    ),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _checkTimer;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    final token = await SharedPrefs().getAccessToken();
    if (token.isEmpty) {
      _checkTimer = Timer(const Duration(seconds: 1),
          () => Get.offAll(() => const LoginScreen()));
    } else {
      _checkTimer = Timer(const Duration(seconds: 1), () {
        Get.offAll(() => const HomeScreen());
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _checkTimer?.cancel();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff345FB4),
      body: SafeArea(
        child: Center(
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Image.asset(
                  "assets/splash.png",
                  width: 250,
                ))),
      ),
    );
  }
}
