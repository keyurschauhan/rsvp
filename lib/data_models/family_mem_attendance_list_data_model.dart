/// status : true
/// family_members : [{"user_id":1,"name":"Admin","its_number":"Husain123","profile_image":"/home/vigoldcrm/public_html/rsvp.vigoldcrm.com/public/images/user//167766271839.jpeg","attendance_status":false},{"user_id":3,"name":"Hatim bhai Hunaid bhai Nanamota Hamita","its_number":"30368448","profile_image":"/home/vigoldcrm/public_html/rsvp.vigoldcrm.com/public/images/user//173675606145.jpg","attendance_status":true},{"user_id":4,"name":"Hatim bhai Yusuf bhai Ezzy","its_number":"30490410","profile_image":"","attendance_status":false},{"user_id":5,"name":"Abbas bhai Muslim bhai Dalal","its_number":"30496488","profile_image":"","attendance_status":false},{"user_id":15,"name":"Ruqaiyah bai Quraish bhai Khargonewala","its_number":"20387199","profile_image":"","attendance_status":false},{"user_id":16,"name":"abc","its_number":"30399869","profile_image":"/home/vigoldcrm/public_html/rsvp.vigoldcrm.com/public/images/user//null","attendance_status":false},{"user_id":17,"name":"XYZ","its_number":"30496242","profile_image":"","attendance_status":false},{"user_id":21,"name":"ABCD","its_number":"30496255","profile_image":"","attendance_status":false},{"user_id":18,"name":"mnb","its_number":"30496256","profile_image":"","attendance_status":false},{"user_id":19,"name":"plm","its_number":"30496302","profile_image":"","attendance_status":false},{"user_id":20,"name":"ojn","its_number":"20438831","profile_image":"","attendance_status":false}]
/// message : "List of all family members"
/// error : ""

class FamilyMemAttendanceListDataModel {
  FamilyMemAttendanceListDataModel({
      this.status, 
      this.familyMembersAttendance,
      this.message, 
      this.error,});

  FamilyMemAttendanceListDataModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['family_members'] != null) {
      familyMembersAttendance = [];
      json['family_members'].forEach((v) {
        familyMembersAttendance?.add(FamilyMembersAttendance.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
  }
  bool? status;
  List<FamilyMembersAttendance>? familyMembersAttendance;
  String? message;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (familyMembersAttendance != null) {
      map['family_members'] = familyMembersAttendance?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['error'] = error;
    return map;
  }

}

/// user_id : 1
/// name : "Admin"
/// its_number : "Husain123"
/// profile_image : "/home/vigoldcrm/public_html/rsvp.vigoldcrm.com/public/images/user//167766271839.jpeg"
/// attendance_status : false

class FamilyMembersAttendance {
  FamilyMembersAttendance({
      this.userId, 
      this.name, 
      this.itsNumber, 
      this.profileImage, 
      this.attendanceStatus,});

  FamilyMembersAttendance.fromJson(dynamic json) {
    userId = json['user_id'];
    name = json['name'];
    itsNumber = json['its_number'];
    profileImage = json['profile_image'];
    attendanceStatus = json['attendance_status'];
  }
  num? userId;
  String? name;
  String? itsNumber;
  String? profileImage;
  bool? attendanceStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['name'] = name;
    map['its_number'] = itsNumber;
    map['profile_image'] = profileImage;
    map['attendance_status'] = attendanceStatus;
    return map;
  }

}