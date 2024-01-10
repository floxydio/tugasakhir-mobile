class CheckExamModel {
  String? message;
  bool? status;

  CheckExamModel({this.message, this.status});

  CheckExamModel.fromJson(final Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
