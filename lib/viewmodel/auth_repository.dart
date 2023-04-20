import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/jwt_model.dart';
import 'package:tugasakhirmobile/screens/home/home_screen.dart';
import 'package:tugasakhirmobile/screens/login/login_screen.dart';

class AuthRepository extends ChangeNotifier {
  String urlLink = "http://localhost:3000";
  DataJwt dataJwt = DataJwt();
  void getRefreshToken() async {
    EasyLoading.show(status: 'Loading...');
    var response = await Dio().get("$urlLink/v1/refresh-token",
        options: Options(
          headers: {
            "x-access-token": await SharedPrefs().getAccessToken(),
          },
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    try {
      if (response.statusCode == 200) {
        dataJwt = JWTModel.fromJson(response.data).data!;
        SharedPrefs().setKelasId(dataJwt.kelasId ?? 0);
      } else {
        Get.dialog(const AlertDialog(
            title: Text("Error"), content: Text("Token invalid")));
        SharedPrefs().clearAccessToken();
        Get.off(const LoginScreen());
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.connectionError) {
        EasyLoading.dismiss();
        Get.dialog(const AlertDialog(
            title: Text("Error"), content: Text("Connection Timeout")));
      }
    }
    notifyListeners();
    EasyLoading.dismiss();
  }

  void loginUser(BuildContext context, String username, String password) async {
    Map<String, dynamic> data = {"username": username, "password": password};
    var response = await Dio().post("$urlLink/v1/sign-in",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
    if (response.statusCode != 200) {
      Get.dialog(const AlertDialog(
          title: Text("Error"), content: Text("Username or Password Salah")));
    } else {
      await SharedPrefs().setAccessToken(response.data["accessToken"]);
      Get.off(const HomeScreen());
    }
    notifyListeners();
  }
}
