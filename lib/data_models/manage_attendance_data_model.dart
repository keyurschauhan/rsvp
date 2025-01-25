/// status : true
/// message : "Attendance submited successfully"
/// error : ""

class ManageAttendanceDataModel {
  ManageAttendanceDataModel({
      this.status, 
      this.message, 
      this.error,});

  ManageAttendanceDataModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
  }
  bool? status;
  String? message;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['error'] = error;
    return map;
  }

}