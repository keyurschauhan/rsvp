/// status : true
/// data : {"user":{"id":16,"its_number":"30399869","user_type":"Local","user_name":"30399869","gender":"Male","name":"ABC","profile_img":"https://rsvp.vigoldcrm.com/public/images/user/dummy.png","status":1},"message":"Registration success"}
/// error : ""

class RegisterDataModel {
  RegisterDataModel({
      this.status, 
      this.data, 
      this.error,});

  RegisterDataModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }
  bool? status;
  Data? data;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['error'] = error;
    return map;
  }

}

/// user : {"id":16,"its_number":"30399869","user_type":"Local","user_name":"30399869","gender":"Male","name":"ABC","profile_img":"https://rsvp.vigoldcrm.com/public/images/user/dummy.png","status":1}
/// message : "Registration success"

class Data {
  Data({
      this.user, 
      this.message,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    message = json['message'];
  }
  User? user;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['message'] = message;
    return map;
  }

}

/// id : 16
/// its_number : "30399869"
/// user_type : "Local"
/// user_name : "30399869"
/// gender : "Male"
/// name : "ABC"
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