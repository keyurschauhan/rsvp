/// status : true
/// family_members : [{"name":"Admin","its_number":"Husain123","gender":"Male","profile_image":"/home/vigoldcrm/public_html/rsvp.vigoldcrm.com/public/images/user//167766271839.jpeg"},{"name":"Hatim bhai Hunaid bhai Nanamota Hamita","its_number":"30368448","gender":"Male","profile_image":"/home/vigoldcrm/public_html/rsvp.vigoldcrm.com/public/images/user//173675606145.jpg"},{"name":"Hatim bhai Yusuf bhai Ezzy","its_number":"30490410","gender":"Male","profile_image":""},{"name":"Abbas bhai Muslim bhai Dalal","its_number":"30496488","gender":"Male","profile_image":""},{"name":"Ruqaiyah bai Quraish bhai Khargonewala","its_number":"20387199","gender":"Male","profile_image":""},{"name":"ABC","its_number":"30399869","gender":"Male","profile_image":""},{"name":"XYZ","its_number":"30496242","gender":"Female","profile_image":""},{"name":"mnb","its_number":"30496256","gender":"Male","profile_image":""},{"name":"plm","its_number":"30496302","gender":"Female","profile_image":""},{"name":"ojn","its_number":"20438831","gender":"Male","profile_image":""}]
/// message : "List of all family members"
/// error : ""

class FamilyMemListDataModel {
  FamilyMemListDataModel({
      this.status, 
      this.familyMembers, 
      this.message, 
      this.error,});

  FamilyMemListDataModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['family_members'] != null) {
      familyMembers = [];
      json['family_members'].forEach((v) {
        familyMembers?.add(FamilyMembers.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
  }
  bool? status;
  List<FamilyMembers>? familyMembers;
  String? message;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (familyMembers != null) {
      map['family_members'] = familyMembers?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['error'] = error;
    return map;
  }

}

/// name : "Admin"
/// its_number : "Husain123"
/// gender : "Male"
/// profile_image : "/home/vigoldcrm/public_html/rsvp.vigoldcrm.com/public/images/user//167766271839.jpeg"

class FamilyMembers {
  FamilyMembers({
      this.name, 
      this.itsNumber, 
      this.gender, 
      this.profileImage,});

  FamilyMembers.fromJson(dynamic json) {
    name = json['name'];
    itsNumber = json['its_number'];
    gender = json['gender'];
    profileImage = json['profile_image'];
  }
  String? name;
  String? itsNumber;
  String? gender;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['its_number'] = itsNumber;
    map['gender'] = gender;
    map['profile_image'] = profileImage;
    return map;
  }

}