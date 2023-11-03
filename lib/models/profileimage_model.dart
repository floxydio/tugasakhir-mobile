class ProfileImage {
  int? status;
  ProfileImageData? data;
  String? message;

  ProfileImage({this.status, this.data, this.message});

  ProfileImage.fromJson(final Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? ProfileImageData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class ProfileImageData {
  String? profilePic;

  ProfileImageData({this.profilePic});

  ProfileImageData.fromJson(final Map<String, dynamic> json) {
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_pic'] = profilePic;
    return data;
  }
}
