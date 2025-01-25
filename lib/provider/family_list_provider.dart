import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/data_models/family_mem_list_data_model.dart';
import 'package:my_project/utils/color_const.dart';
import 'package:my_project/utils/mobile_navigation_manager.dart';
import 'package:my_project/utils/my_app_text_style.dart';

import '../apis/api_callers.dart';
import '../data_models/login_data_model.dart';
import '../utils/const_util.dart';
import '../widgets/my_app_progress_bar.dart';
import '../widgets/widget_utils.dart';
import 'family_member_add_provider.dart';

class FamilyListProvider extends ChangeNotifier{

  final MyAppColors myAppColors = MyAppColors();
  final MyAppTextStyle myAppTextStyle = MyAppTextStyle();
  final MobileNavigationManager mobileNavigationManager = MobileNavigationManager();

  LoginDataModel? loginDataModel;

  List<FamilyMembers> familyMemberList = [];

  Future<void> getFamilyMemberList(BuildContext context) async {

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

            try {
              final response = await ApiCallers().getFamilyMemberList(
                loginDataModel!.data!.token.toString(),
              );
              if (response.statusCode == 200) {
                final jsonResponse = jsonDecode(response.body);
                final familyMemberDataList = FamilyMemListDataModel.fromJson(jsonResponse);

                if (familyMemberDataList.status == true && familyMemberDataList.familyMembers!.isNotEmpty) {
                  familyMemberList.addAll(familyMemberDataList.familyMembers!);
                  notifyListeners();
                  Navigator.pop(context);
                } else {
                  WidgetUtil().showToast(context, familyMemberDataList.message ?? "No events found.",);
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
