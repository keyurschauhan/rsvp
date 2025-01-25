import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/data_models/edit_profile_data_model.dart';
import 'package:my_project/data_models/login_data_model.dart';

import '../apis/api_callers.dart';
import '../utils/color_const.dart';
import '../utils/mobile_navigation_manager.dart';
import '../utils/my_app_text_style.dart';
import '../utils/sharedprefrence_utils.dart';
import '../widgets/my_app_progress_bar.dart';
import '../widgets/widget_utils.dart';

class EditProfileProvider extends ChangeNotifier{

  final MyAppColors myAppColors = MyAppColors();
  final MyAppTextStyle myAppTextStyle = MyAppTextStyle();
  final MobileNavigationManager mobileNavigationManager = MobileNavigationManager();
  LoginDataModel? loginDataModel;

  bool isLoading = false;

  String? userName;
  String? itsNumber;

  final TextEditingController nameController = TextEditingController();


  void getFromSharedPreference(){
    SharedPreferenceUtill.getLoginResponse().then((value) {
      if (value != null) {
          loginDataModel = value;
          notifyListeners();
      }
      log("FILE:: ${loginDataModel?.data?.user?.toJson()}");
      //if(loginDataModel != null){
      //   selectedImageFile = File(loginDataModel!.data!.user!.profileImg!);
      nameController.text = loginDataModel!.data!.user!.name!;

      //}
      // if (loginDataModel?.data?.user?.profileImg != null) {
      //   selectedImageFile = File.fromUri(Uri.parse(loginDataModel!.data!.user!.profileImg!));
      //   log("FILE:: ${selectedImageFile?.path}");
      // }

    });
  }

  Future<bool> registerBtnPressed(
      BuildContext context) async {

    final dlResult = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => MyAppPageRefresherDialog(
        process: () async {
          final result = await ApiCallers().editProfile(loginDataModel!.data!.token.toString(),nameController.text.trim(), selectedImageFile);

          if (result.statusCode == 200) {
            final response = jsonDecode(result.body);
            log("111");

            if (response['status'] != false) {
              final editProfileDataModel = EditProfileDataModel.fromJson(response);


              if (editProfileDataModel.status == true) {
                loginDataModel?.data?.user = editProfileDataModel.userDetails;
                SharedPreferenceUtill.setLoginResponse(loginDataModel!);
                getFromSharedPreference();
                WidgetUtil().showToast(context, editProfileDataModel.message ?? "Profile Updated Successfully",);
               notifyListeners();
                return true;
              } else {
                log("Register Failed :: ${editProfileDataModel.error}");
                WidgetUtil().showToastError(context, editProfileDataModel.error ?? "An error occurred",);
                notifyListeners();

                return false;
              }
            } else {
              WidgetUtil().showToastError(context, response['error'] ?? "Invalid credentials.",);
              notifyListeners();
              return false;
            }
          } else {
            log("Unexpected Status Code: ${result.statusCode}");
            WidgetUtil().showToastError(context, "Unexpected server error. Please try again.",);
            notifyListeners();
            return false;
          }
        },
      ),
    );

    log("Dialog Result: $dlResult");

    // if (dlResult != null && dlResult) {
    //   log("Navigation to Home Page");
    //   mobileNavigationManager.goToLogInPage(context);
    // }

    return dlResult ?? false;
  }

  File? selectedImageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future<void> selectImageFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> selectImageFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  void showAnimatedDialog(BuildContext context, Widget child) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54, // Background dim color
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Center(child: child);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: Opacity(
            opacity: anim1.value,
            child: child,
          ),
        );
      },
    );
  }
}

