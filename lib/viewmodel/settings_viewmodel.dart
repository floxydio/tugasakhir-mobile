import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SettingsViewModel extends ChangeNotifier {
  String? getUrlImage;

  void loadEnvUrl() {
    if (dotenv.env["SERVER_TYPE"] == "dev") {
      getUrlImage = dotenv.env["BASE_IP"];
    } else if (dotenv.env["SERVER_TYPE"] == "prod") {
      getUrlImage = dotenv.env["BASE_IP_PROD"];
    }
    notifyListeners();
  }
}
