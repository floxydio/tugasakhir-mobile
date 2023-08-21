import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/jwt_model.dart';
import 'package:tugasakhirmobile/repository/auth.repo.dart';
import 'package:tugasakhirmobile/screens/home/home_screen.dart';
import 'package:tugasakhirmobile/screens/login/login_screen.dart';

class AuthViewModel extends ChangeNotifier {
  DataJwt? dataJwt;
  void getRefreshToken() async {
    EasyLoading.show(status: 'Loading...');
    var tokenRepository = await AuthRepository().getRefreshToken();
    tokenRepository.fold((l) {
      EasyLoading.showError(l.message!);
    }, (r) async {
      dataJwt = r;
      await SharedPrefs().setKelasId(r.kelasId!);
    });
    EasyLoading.dismiss();
    notifyListeners();
  }

  void logout() {
    SharedPrefs().clearAll();
    Get.offAll(const LoginScreen());
  }

  void signInUser(String username, String password) async {
    EasyLoading.show(status: 'Loading...');
    var authRepository = await AuthRepository().signIn(username, password);

    authRepository.fold((l) {
      EasyLoading.showError(l.message!);
    }, (r) async {
      await SharedPrefs().setAccessToken(r.token!);
      Get.off(const HomeScreen());
    });
    EasyLoading.dismiss();

    notifyListeners();
  }

  // void daftarUser(BuildContext context, String nama, String username,
  //     String password) async {
  //   Map<String, dynamic> data = {
  //     "nama": nama,
  //     "username": username,
  //     "password": password,
  //     "userAgent": "BC"
  //   };
  //   var response = await Dio().post("$urlLink/v2/sign-up",
  //       data: data,
  //       options: Options(
  //         contentType: Headers.formUrlEncodedContentType,
  //         followRedirects: false,
  //         validateStatus: (status) {
  //           return status! < 500;
  //         },
  //       ));
  //   if (response.statusCode != 200) {
  //     Get.dialog(const AlertDialog(
  //         title: Text("Error"), content: Text("Gagal Registrasi")));
  //   } else {
  //     Get.off(const LoginScreen());
  //   }
  //   notifyListeners();
  // }

  String? imageData;

  void profileImage() async {
    EasyLoading.show(status: 'Loading...');
    var authRepo = await AuthRepository().imageProfile();

    authRepo.fold((l) {
      EasyLoading.showError(l.message!);
      if (l.message == "User Unauthorized") {
        logout();
      }
    }, (r) => {imageData = r.data?.profilePic});

    EasyLoading.dismiss();
    notifyListeners();
  }
}
