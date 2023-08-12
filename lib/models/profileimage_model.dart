class ProfileImage {
  int? status;
  ProfileImageData? data;
  String? message;

  ProfileImage({this.status, this.data, this.message});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? new ProfileImageData.fromJson(json['data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ProfileImageData {
  String? profilePic;

  ProfileImageData({this.profilePic});

  ProfileImageData.fromJson(Map<String, dynamic> json) {
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_pic'] = this.profilePic;
    return data;
  }
}
