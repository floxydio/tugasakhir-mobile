class LoginModel {
  int? status;
  int? userId;
  String? token;
  String? message;
  int? role;

  LoginModel({this.status, this.token, this.message});

  LoginModel.fromJson(final Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
    token = json['token'];
    message = json['message'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['user_id'] = userId;
    data['token'] = token;
    data['message'] = message;
    data['role'] = role;
    return data;
  }
}
