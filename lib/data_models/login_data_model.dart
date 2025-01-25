/// status : true
/// data : {"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYTZjYmM5NDQzNjQ5NDg5ODEwY2JkYmVmYzQ1Yjg5MzhhMjNjOGI1YWQzZmM0MTkyNzhhYmJmMWQ0MWU4ZDEzNTI3NDNhYzM4OTMzNjdiOTIiLCJpYXQiOjE3MzcwOTAwNTEuMTIwMzYxMDg5NzA2NDIwODk4NDM3NSwibmJmIjoxNzM3MDkwMDUxLjEyMDM2ODk1NzUxOTUzMTI1LCJleHAiOjE3Njg2MjYwNTEuMTA2OTMwMDE3NDcxMzEzNDc2NTYyNSwic3ViIjoiMTMiLCJzY29wZXMiOltdfQ.OAtmOTNCNIGJizQzC7DX0kyspHXk8wG-C9Pnohkw8b1XL01mHzhVNLw5hxaNtr92M3-E5Jd2EZCMKefEtV1eco8xmI6RRQG06M0JkMqOu7nOOx17KrHiBuYg3Ejp2XwrC5N9-FMBanMz709-iI6fyQR9sT4Gpkl09-V4eUUMe3_VAdin0JLZsdSoTAtCKqL4u1ZIQZkxvKaiMt1QApezEBbr3i4Zfd1lnNNxEfTfQbSzXvbAM1uxKQTAnh7_wXlN1I4YWvJxP7auwe4TNDUPbvTCCZ0Msj6yeYxqrsVTMIQhvyzOxKhIvvttx5ElOr1Md4_uLc8APAbSGX0Hcz_QWCM0_VpYHEsUJ2go5CZDft86_OUjtM-YfwNBFkxkwsFaTrZs0r5ncJdx2MjSnhhuTF54IDlcLY-FpBNGX1AATkSVRsGGzb7hFIEfKVz4SL7PUDWqcfRjggk2enYVDsfu5A0kH8G8c-bWDdjY3ItZXu05EFF9yrA3PCUEu4Fb_kGNDQySk-Ot97yeJoA5naUhSlb2Ra0RnzHWaQiqA6PGxhfMcD02Djd9S3CX-NbIhyaSXqhBzp4ADSHXHCm953n3fEb69V1OlsRcwR4VGVCkdaUZruHK_5IFLehBlsh6flHgaJ17P4l-o7UNcGHgYg0nkq70K4z4orY15UEUrbq97ew","user":{"id":13,"its_number":"20314528","user_type":"Local","user_name":"20314528","gender":"Male","name":"Quraish bhai Saleh bhai Khargonewala","profile_img":"https://rsvp.vigoldcrm.com/public/images/user/dummy.png","status":1},"permission":{"event_view":"No","event_add":"No","event_edit":"No","event_delete":"No","group_view":"No","group_add":"No","group_edit":"No","group_delete":"No","report":"No"}}
/// message : "Login successful"
/// error : ""

class LoginDataModel {
  LoginDataModel({
      this.status, 
      this.data, 
      this.message, 
      this.error,});

  LoginDataModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'];
  }
  bool? status;
  Data? data;
  String? message;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    map['error'] = error;
    return map;
  }

}

/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYTZjYmM5NDQzNjQ5NDg5ODEwY2JkYmVmYzQ1Yjg5MzhhMjNjOGI1YWQzZmM0MTkyNzhhYmJmMWQ0MWU4ZDEzNTI3NDNhYzM4OTMzNjdiOTIiLCJpYXQiOjE3MzcwOTAwNTEuMTIwMzYxMDg5NzA2NDIwODk4NDM3NSwibmJmIjoxNzM3MDkwMDUxLjEyMDM2ODk1NzUxOTUzMTI1LCJleHAiOjE3Njg2MjYwNTEuMTA2OTMwMDE3NDcxMzEzNDc2NTYyNSwic3ViIjoiMTMiLCJzY29wZXMiOltdfQ.OAtmOTNCNIGJizQzC7DX0kyspHXk8wG-C9Pnohkw8b1XL01mHzhVNLw5hxaNtr92M3-E5Jd2EZCMKefEtV1eco8xmI6RRQG06M0JkMqOu7nOOx17KrHiBuYg3Ejp2XwrC5N9-FMBanMz709-iI6fyQR9sT4Gpkl09-V4eUUMe3_VAdin0JLZsdSoTAtCKqL4u1ZIQZkxvKaiMt1QApezEBbr3i4Zfd1lnNNxEfTfQbSzXvbAM1uxKQTAnh7_wXlN1I4YWvJxP7auwe4TNDUPbvTCCZ0Msj6yeYxqrsVTMIQhvyzOxKhIvvttx5ElOr1Md4_uLc8APAbSGX0Hcz_QWCM0_VpYHEsUJ2go5CZDft86_OUjtM-YfwNBFkxkwsFaTrZs0r5ncJdx2MjSnhhuTF54IDlcLY-FpBNGX1AATkSVRsGGzb7hFIEfKVz4SL7PUDWqcfRjggk2enYVDsfu5A0kH8G8c-bWDdjY3ItZXu05EFF9yrA3PCUEu4Fb_kGNDQySk-Ot97yeJoA5naUhSlb2Ra0RnzHWaQiqA6PGxhfMcD02Djd9S3CX-NbIhyaSXqhBzp4ADSHXHCm953n3fEb69V1OlsRcwR4VGVCkdaUZruHK_5IFLehBlsh6flHgaJ17P4l-o7UNcGHgYg0nkq70K4z4orY15UEUrbq97ew"
/// user : {"id":13,"its_number":"20314528","user_type":"Local","user_name":"20314528","gender":"Male","name":"Quraish bhai Saleh bhai Khargonewala","profile_img":"https://rsvp.vigoldcrm.com/public/images/user/dummy.png","status":1}
/// permission : {"event_view":"No","event_add":"No","event_edit":"No","event_delete":"No","group_view":"No","group_add":"No","group_edit":"No","group_delete":"No","report":"No"}

class Data {
  Data({
    this.isAdmin,
      this.token, 
      this.user, 
      this.permission,});

  Data.fromJson(dynamic json) {
    token = json['token'];
    isAdmin = json['is_admin'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    permission = json['permission'] != null ? Permission.fromJson(json['permission']) : null;
  }
  num? isAdmin;
  String? token;
  User? user;
  Permission? permission;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['is_admin'] = isAdmin;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (permission != null) {
      map['permission'] = permission?.toJson();
    }
    return map;
  }

}

/// event_view : "No"
/// event_add : "No"
/// event_edit : "No"
/// event_delete : "No"
/// group_view : "No"
/// group_add : "No"
/// group_edit : "No"
/// group_delete : "No"
/// report : "No"

class Permission {
  Permission({
      this.eventView, 
      this.eventAdd, 
      this.eventEdit, 
      this.eventDelete, 
      this.groupView, 
      this.groupAdd, 
      this.groupEdit, 
      this.groupDelete, 
      this.report,});

  Permission.fromJson(dynamic json) {
    eventView = json['event_view'];
    eventAdd = json['event_add'];
    eventEdit = json['event_edit'];
    eventDelete = json['event_delete'];
    groupView = json['group_view'];
    groupAdd = json['group_add'];
    groupEdit = json['group_edit'];
    groupDelete = json['group_delete'];
    report = json['report'];
  }
  String? eventView;
  String? eventAdd;
  String? eventEdit;
  String? eventDelete;
  String? groupView;
  String? groupAdd;
  String? groupEdit;
  String? groupDelete;
  String? report;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_view'] = eventView;
    map['event_add'] = eventAdd;
    map['event_edit'] = eventEdit;
    map['event_delete'] = eventDelete;
    map['group_view'] = groupView;
    map['group_add'] = groupAdd;
    map['group_edit'] = groupEdit;
    map['group_delete'] = groupDelete;
    map['report'] = report;
    return map;
  }

}

/// id : 13
/// its_number : "20314528"
/// user_type : "Local"
/// user_name : "20314528"
/// gender : "Male"
/// name : "Quraish bhai Saleh bhai Khargonewala"
/// profile_img : "https://rsvp.vigoldcrm.com/public/images/user/dummy.png"
/// status : 1

class User {
  User({
      this.id, 
      this.itsNumber, 
      this.userType, 
      this.userName, 
      this.gender, 
      this.name, 
      this.profileImg, 
      this.status,});

  User.fromJson(dynamic json) {
    id = json['id'];
    itsNumber = json['its_number'];
    userType = json['user_type'];
    userName = json['user_name'];
    gender = json['gender'];
    name = json['name'];
    profileImg = json['profile_img'];
    status = json['status'];
  }
  num? id;
  String? itsNumber;
  String? userType;
  String? userName;
  String? gender;
  String? name;
  String? profileImg;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['its_number'] = itsNumber;
    map['user_type'] = userType;
    map['user_name'] = userName;
    map['gender'] = gender;
    map['name'] = name;
    map['profile_img'] = profileImg;
    map['status'] = status;
    return map;
  }

}