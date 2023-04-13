import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tugasakhirmobile/screens/Home/home_screen.dart';

class AuthRepository extends ChangeNotifier {
  void loginUser(BuildContext context, String username, String password) async {
    Map<String, dynamic> data = {"username": username, "password": password};
    var response = await Dio().post("http://localhost:3000/v1/sign-in",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
    print(response.data);
    if (response.statusCode != 200) {
      print("ERROR");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text("Error"),
                content: Text("Username or Password Salah"));
          });
    } else {
      print("SUKSES");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    notifyListeners();
  }
}
