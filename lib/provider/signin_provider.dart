import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/data_models/register_data_model.dart';
import '../apis/api_callers.dart';
import '../utils/color_const.dart';
import '../utils/mobile_navigation_manager.dart';
import '../utils/my_app_text_style.dart';
import '../widgets/my_app_progress_bar.dart';
import '../widgets/widget_utils.dart';

class SignInProvider extends ChangeNotifier{

  bool isLoading = false;

  String userType = "Local";

  final MyAppColors myAppColors = MyAppColors();
  final MyAppTextStyle myAppTextStyle = MyAppTextStyle();
  final MobileNavigationManager mobileNavigationManager = MobileNavigationManager();


  String selectedCategory = 'Local';
  bool isTab = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController itsController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool showDocumentField = false;
  String? selectedImageName;
  XFile? img;

  final ImagePicker _picker = ImagePicker();

  // Toggle the tab and update `showDocumentField`
  void toggleTab(bool isLocal) {
    isTab = isLocal;
    showDocumentField = !isLocal; // Show document field for NRI
    notifyListeners();
  }

  // Pick an image and store the file name
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      img = image;
      selectedImageName = image.name; // Get file name
      log("FILE :: $selectedImageName");
      notifyListeners();
    }
  }

  void signUp(BuildContext context){
    mobileNavigationManager.goToUserHomePage(context);
    //Navigator.push(context, MaterialPageRoute(builder: (builder)=> const UserHomeScreen()));
  }

  Future<bool> registerBtnPressed(
      BuildContext context) async {

      final dlResult = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MyAppPageRefresherDialog(
          process: () async {
              final result = await ApiCallers().signUp(itsController.text.trim(), passwordController.text, selectedCategory,nameController.text.trim(),confirmPasswordController.text,img);

              if (result.statusCode == 200) {
                final response = jsonDecode(result.body);
                log("111");

                if (response['status'] != false) {
                  final registerDataModel = RegisterDataModel.fromJson(response);

                  if (registerDataModel.status == true) {
                    WidgetUtil().showToast(context, registerDataModel.data?.message ?? "Register successful",);
                    return true;
                  } else {
                    log("Register Failed :: ${registerDataModel.error}");
                    WidgetUtil().showToastError(context, registerDataModel.error ?? "An error occurred",);
                    return false;
                  }
                } else {
                  final itsError = response['error']['its_number'];
                  if(itsError is List && itsError.isNotEmpty) {
                    WidgetUtil().showToastError(context, itsError[0] ?? "Invalid credentials.",);
                  }
                  return false;
                }
              } else {
                log("Unexpected Status Code: ${result.statusCode}");
                WidgetUtil().showToastError(context, "Unexpected server error. Please try again.",);
                return false;
              }
          },
        ),
      );

      log("Dialog Result: $dlResult");

      if (dlResult != null && dlResult) {
        log("Navigation to Home Page");
        mobileNavigationManager.goToLogInPage(context);
      }

      return dlResult ?? false;
  }

}