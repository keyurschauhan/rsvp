import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_project/apis/api_callers.dart';
import 'package:my_project/data_models/login_data_model.dart';
import 'package:my_project/utils/mobile_navigation_manager.dart';
import 'package:my_project/widgets/my_app_progress_bar.dart';
import 'package:overlay_support/overlay_support.dart';
import '../utils/color_const.dart';
import '../utils/my_app_text_style.dart';
import '../utils/sharedprefrence_utils.dart';
import '../widgets/widget_utils.dart';

class LoginProvider extends ChangeNotifier{

  final MyAppColors myAppColors = MyAppColors();
  final MyAppTextStyle myAppTextStyle = MyAppTextStyle();
  final MobileNavigationManager mobileNavigationManager = MobileNavigationManager();

  LoginDataModel? loginDataModel;
  String? itsNumber;
  String? password;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController itsController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    mobileNavigationManager.goToSignUpPage(context);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void startLoading(){
    if(!_isLoading){
      _isLoading = true;
      notifyListeners();
    }
  }

  void stopLoading(){
    if(_isLoading){
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> loginBtnPressed(
      BuildContext context, String itsNumber, String password) async {
    try {
      final dlResult = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MyAppPageRefresherDialog(
          process: () async {
            try {
              final result = await ApiCallers().login(itsNumber, password);


              if (result.statusCode == 200) {
                final response = jsonDecode(result.body);

                if (response['status'] != false) {
                  final loginDataModel = LoginDataModel.fromJson(response);

                  if (loginDataModel.status == true) {
                    SharedPreferenceUtill.setLoginResponse(loginDataModel);
                    WidgetUtil().showToast(context, loginDataModel.message ?? "Login successful",);
                    return true;
                  } else {
                    log("Login Failed :: ${loginDataModel.error}");
                    WidgetUtil().showToastError(context, loginDataModel.error ?? "An error occurred",);
                    return false;
                  }
                } else {
                  WidgetUtil().showToastError(context, response['error'] ?? "Invalid credentials.",);
                  return false;
                }
              } else {
                log("Unexpected Status Code: ${result.statusCode}");
                WidgetUtil().showToastError(context, "Unexpected server error. Please try again.",);
                return false;
              }
            } catch (e) {
              WidgetUtil().showToastError(context, "An error occurred: ${e.toString()}",);
              return false;
            }
          },
        ),
      );

      log("Dialog Result: $dlResult");

      if (dlResult != null && dlResult) {
        log("Navigation to Home Page");
        mobileNavigationManager.goToUserHomePage(context);
      }

      return dlResult ?? false;
    } catch (e) {
      log("Unhandled Error: ${e.toString()}");
      WidgetUtil().showToastError(
        context,
        "An unexpected error occurred. Please try again.",
      );
      return false;
    }
  }



  void showErrorMessage(String message,
      {void Function()? callBack, int? time, List<String>? errorList}) {
    if (errorList != null) {
      for (var data in errorList) {
        message = "$data\n";
      }
    }
    showSimpleNotification(
        Text(
          message,
          style: myAppTextStyle.quickSandMedium(size: 15, color: Colors.white),
        ),
        background: Colors.red,
        duration: Duration(seconds: time ?? 3));
    if (callBack != null) callBack();
  }
}