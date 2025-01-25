import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_project/utils/mobile_navigation_manager.dart';
import '../apis/api_callers.dart';
import '../data_models/family_mem_attendance_list_data_model.dart';
import '../data_models/login_data_model.dart';
import '../data_models/manage_attendance_data_model.dart';
import '../utils/color_const.dart';
import '../utils/const_util.dart';
import '../utils/my_app_text_style.dart';
import '../utils/sliding.dart';
import '../widgets/my_app_progress_bar.dart';
import '../widgets/widget_utils.dart';

class FamilyMemberAddProvider extends ChangeNotifier{

  final MyAppColors myAppColors = MyAppColors();
  final MyAppTextStyle myAppTextStyle = MyAppTextStyle();
  final MobileNavigationManager mobileNavigationManager = MobileNavigationManager();

  LoginDataModel? loginDataModel;

  List<FamilyMembersAttendance> familyMemberList = [];

  List<int> selectedIds = [];

  Future<void> getFamilyMemberAttendanceList(BuildContext context,int eventId) async {

    final dlResult = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => MyAppPageRefresherDialog(
        process: () async {

          final isConnected = await ConstUtil().checkConnection();

          if (!isConnected) {
            WidgetUtil().showToast(context,"No internet connection.",);
            notifyListeners();
            return false;
          }
          log("YES");

          try {
            final response = await ApiCallers().getFamilyMemberAttendanceList(
              loginDataModel!.data!.token.toString(),eventId);
            log("RES :: ${response.body}");
            if (response.statusCode == 200) {
              final jsonResponse = jsonDecode(response.body);
              final familyMemberDataList = FamilyMemAttendanceListDataModel.fromJson(jsonResponse);

              if (familyMemberDataList.status == true && familyMemberDataList.familyMembersAttendance!.isNotEmpty) {
                familyMemberList.addAll(familyMemberDataList.familyMembersAttendance!);
                for (var member in familyMemberList) {
                  if (member.attendanceStatus == true && !selectedIds.contains(member.userId)) {
                    selectedIds.add(member.userId!.toInt());
                  }
                }
                notifyListeners();
                Navigator.pop(context);
              } else {
                WidgetUtil().showToast(context, familyMemberDataList.message ?? "No events found.",);
                notifyListeners();
                Navigator.pop(context);

              }
            } else {
              WidgetUtil().showToast(context, "Failed to fetch events.",);
              notifyListeners();

            }
          } catch (e) {
            WidgetUtil().showToastError(context, "An error occurred: ${e.toString()}",);
            notifyListeners();

            return false;
          }
        },
      ),
    );
  }

  Future<void> manageAttendance(BuildContext context,int eventId) async {

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => MyAppPageRefresherDialog(
        process: () async {

          final isConnected = await ConstUtil().checkConnection();

          if (!isConnected) {
            WidgetUtil().showToast(context,"No internet connection.",);
            notifyListeners();
            return false;
          }
          log("YES");
          try {
            final response = await ApiCallers().manageAttendance(
                loginDataModel!.data!.token.toString(),eventId,selectedIds);
            log("RES :: ${response.body}");
            if (response.statusCode == 200) {
              final jsonResponse = jsonDecode(response.body);
              final manageAttendanceDataModel = ManageAttendanceDataModel.fromJson(jsonResponse);

              if (manageAttendanceDataModel.status == true && manageAttendanceDataModel.message!.isNotEmpty) {
                WidgetUtil().showToast(context, manageAttendanceDataModel.message ?? "Attendance submitted successfully.",);
                notifyListeners();
                Navigator.pop(context);
              } else {
                WidgetUtil().showToast(context, manageAttendanceDataModel.message ?? "No events found.",);
                notifyListeners();

              }
            } else {
              WidgetUtil().showToast(context, "Failed to fetch events.",);
              notifyListeners();

            }
          } catch (e) {
            WidgetUtil().showToastError(context, "An error occurred: ${e.toString()}",);
            notifyListeners();

            return false;
          }
        },
      ),
    );
  }

}

class Member {
  final String name;
  final String itsNumber;
  bool isSelected = false;
  String? profile;

  Member({
    required this.name,
    required this.isSelected,
    required this.itsNumber,
    this.profile
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['Name'],
      isSelected: json['IsSelected'],
      itsNumber: json['ITSNumber'],
      profile: json['Profile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'IsSelected': isSelected,
      'ITSNumber': itsNumber,
      'Profile': profile,
    };
  }
}
