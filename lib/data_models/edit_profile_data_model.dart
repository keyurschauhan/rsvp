import 'login_data_model.dart';

/// status : true
/// user_details : {"id":21,"its_number":"30496255","user_type":"Local","user_name":"30496255","gender":"Female","name":"abc","profile_img":"https://rsvp.vigoldcrm.com/public/images/user/dummy.png","status":1}
/// message : "Profile Updated Successfully"
/// error : ""

class EditProfileDataModel {
  EditProfileDataModel({
      this.status, 
      this.userDetails, 
      this.message, 
      this.error,});

  EditProfileDataModel.fromJson(dynamic json) {
    status = json['status'];
    userDetails = json['user_details'] != null ? User.fromJson(json['user_details']) : null;
    message = json['message'];
    error = json['error'];
  }
  bool? status;
  User? userDetails;
  String? message;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (userDetails != null) {
      map['user_details'] = userDetails?.toJson();
    }
    map['message'] = message;
    map['error'] = error;
    return map;
  }

}

/// id : 21
/// its_number : "30496255"
/// user_type : "Local"
/// user_name : "30496255"
/// gender : "Female"
/// name : "abc"
/// profile_img : "https://rsvp.vigoldcrm.com/public/images/user/dummy.png"
/// status : 1

class UserDetails {
  UserDetails({
      this.id, 
      this.itsNumber, 
      this.userType, 
      this.userName, 
      this.gender, 
      this.name, 
      this.profileImg, 
      this.status,});

  UserDetails.fromJson(dynamic json) {
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