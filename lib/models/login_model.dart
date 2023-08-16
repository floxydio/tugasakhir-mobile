class LoginModel {
  int? status;
  String? token;
  String? message;

  LoginModel({this.status, this.token, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}
