import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/widgets/widget_utils.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/login_provider.dart';
import '../../provider/signin_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    var signInProvider = Provider.of<SignInProvider>(context);
    return Scaffold(
      backgroundColor: signInProvider.myAppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header Section
            Stack(
              children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: signInProvider.myAppColors.white,
                  ),
                ),
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                      color: signInProvider.myAppColors.primaryGolden,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(60),
                      ),),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h,/*right: 50.w*/),
                      child: Text(
                        "REGISTER",
                        style: signInProvider.myAppTextStyle.quickSandMedium(
                            size: 3, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Bottom Section
            Stack(
              children: [
                Container(
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: signInProvider.myAppColors.primaryGolden.withOpacity(1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(60),
                      //topLeft: Radius.circular(40),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 85.h,
                    decoration: BoxDecoration(
                      color: signInProvider.myAppColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        //topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
                      child: Form(
                        child: Column(
                          children: [
                  
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        // Set state or handle tab selection logic for "Local"
                                        signInProvider.isTab = true;
                                        signInProvider.toggleTab(signInProvider.isTab);// Example for toggling logic
                                        // Example for toggling logic
                                        if (context.mounted) setState(() {});
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: signInProvider.isTab
                                              ? signInProvider.myAppColors.primaryGolden
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color:
                                            signInProvider.myAppColors.primaryGolden,
                  
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              !signInProvider.isTab ? Icons.check_circle_outline : Icons.check_circle ,
                                              color: !signInProvider.isTab ? Colors.black54 : Colors.white,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Local',
                                              style: signInProvider.myAppTextStyle.quickSandMedium(
                                                size: 2,
                                                color: signInProvider.isTab
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8), // Space between tabs
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        // Set state or handle tab selection logic for "NRI"
                                        signInProvider.isTab = false;
                                        signInProvider.toggleTab(signInProvider.isTab);// Example for toggling logic
                                        if (context.mounted) setState(() {});
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: !signInProvider.isTab
                                              ? signInProvider.myAppColors.primaryGolden
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: signInProvider.myAppColors.primaryGolden,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              signInProvider.isTab ? Icons.check_circle_outline : Icons.check_circle ,
                                              color: signInProvider.isTab ? Colors.black54 : Colors.white,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'NRI',
                                              style: signInProvider.myAppTextStyle.quickSandMedium(
                                                size: 2,
                                                color: !signInProvider.isTab
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                  
                            Card(
                              elevation: 5, // Add elevation for shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                              ),
                              child: TextFormField(
                                controller: signInProvider.itsController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "ITS Number",
                                  labelStyle: signInProvider.myAppTextStyle.quickSandRegular(color: Colors.grey,size: 0.2.h),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: signInProvider.myAppColors.primaryGolden,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: signInProvider.myAppColors.primaryGolden,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: signInProvider.myAppColors.primaryGolden),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                  
                            // Name Field
                            Card(
                              elevation: 5, // Add elevation for shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                              ),
                              child: TextFormField(
                                controller: signInProvider.nameController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  labelStyle: signInProvider.myAppTextStyle.quickSandRegular(color: Colors.grey,size: 0.2.h),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: signInProvider.myAppColors.primaryGolden,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: signInProvider.myAppColors.primaryGolden,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: signInProvider.myAppColors.primaryGolden),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                  
                            // Username Field
                            Card(
                              elevation: 5, // Add elevation for shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                              ),
                              child: TextFormField(
                                readOnly: true,
                                controller: signInProvider.itsController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  labelStyle: signInProvider.myAppTextStyle.quickSandRegular(color: Colors.grey,size: 0.2.h),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: signInProvider.myAppColors.primaryGolden,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: signInProvider.myAppColors.primaryGolden,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: signInProvider.myAppColors.primaryGolden),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                  
                            // Password Field
                            Card(
                              elevation: 5, // Add elevation for shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                              ),
                              child: TextFormField(
                                controller: signInProvider.passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: signInProvider.myAppTextStyle.quickSandRegular(color: Colors.grey,size: 0.2.h),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: signInProvider.myAppColors.primaryGolden,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: signInProvider.myAppColors.primaryGolden,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: signInProvider.myAppColors.primaryGolden),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            // Confirm Password Field
                            Card(
                              elevation: 5, // Add elevation for shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                              ),
                              child: TextFormField(
                                controller: signInProvider.confirmPasswordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  labelStyle: signInProvider.myAppTextStyle.quickSandRegular(color: Colors.grey,size: 0.2.h),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: signInProvider.myAppColors.primaryGolden,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: signInProvider.myAppColors.primaryGolden,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: signInProvider.myAppColors.primaryGolden),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            if (signInProvider.showDocumentField) ...[
                              SizedBox(height: 1.h),
                              InkWell(
                                onTap: () async {
                                  await signInProvider.pickImage();
                                },
                                child: Card(
                                  elevation: 5, // Add elevation for shadow
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                                  ),
                                  child: Container(
                                    padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 1.6.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: signInProvider.myAppColors.primaryGolden, width: 1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.upload_file, color: signInProvider.myAppColors.primaryGolden),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                signInProvider.selectedImageName ?? "Upload ITS Image",
                                                style: signInProvider.myAppTextStyle.quickSandRegular(
                                                  size: 0.2.h,
                                                  color: signInProvider.selectedImageName != null
                                                      ? Colors.black87
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                  
                            SizedBox(height: 4.h),
                  
                            // Sign Up Button
                            InkWell(
                              onTap: signInProvider.isLoading
                                  ? null
                                  : () {
                                // Check validation
                                String? errorMessage;

                                // Validate ITS Number
                                if (signInProvider.itsController.text.isEmpty) {
                                  errorMessage = "Please enter ITS Number";
                                }
                                // Validate Name
                                else if (signInProvider.nameController.text.isEmpty) {
                                  errorMessage = "Please enter your name";
                                }
                                // Validate Password
                                else if (signInProvider.passwordController.text.isEmpty) {
                                  errorMessage = "Please enter your password";
                                }
                                // Validate Confirm Password
                                else if (signInProvider.confirmPasswordController.text.isEmpty) {
                                  errorMessage = "Please confirm your password";
                                }
                                // Check if passwords match
                                else if (signInProvider.passwordController.text !=
                                    signInProvider.confirmPasswordController.text) {
                                  errorMessage = "Passwords do not match";
                                }
                                else if(signInProvider.showDocumentField && signInProvider.selectedImageName == null){
                                  errorMessage = "Please Upload Document";
                                }

                                if (errorMessage != null) {
                                  WidgetUtil().showToastError(context, errorMessage);
                                } else {
                                  // If validation passes, proceed with sign-up
                                  setState(() {
                                    signInProvider.registerBtnPressed(context);
                                  });
                                }
                              },
                              child: Card(
                                elevation: 5, // Add elevation for shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Rounded corners for the card
                                ),
                                child: Container(
                                  height: 6.h,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: signInProvider.myAppColors.primaryGolden.withOpacity(0.3), // Shadow color
                                          spreadRadius: 3,
                                          blurRadius: 8,
                                          offset: const Offset(0, 3), // Shadow position
                                        ),
                                      ],
                                      color: signInProvider.myAppColors.primaryGolden,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: signInProvider.isLoading
                                        ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                        : Text(
                                      "Register",
                                      style:  signInProvider.myAppTextStyle.quickSandMedium(
                                        size: 2.5, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: signInProvider.myAppTextStyle.quickSandBold(
                                  size: 1.8,
                                  color: Colors.blueGrey[900],
                                ),
                                children: [
                                  TextSpan(
                                    text: "Login",
                                    style: signInProvider.myAppTextStyle.quickSandBold(
                                      size: 2,
                                      color: signInProvider.myAppColors.primaryGolden, // Highlighted color
                                      //decoration: TextDecoration.underline, // Optional underline for emphasis
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle Login tap action
                                        Navigator.pop(context); // Replace with your login route
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }




}
