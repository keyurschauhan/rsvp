import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/login_provider.dart';
import '../../widgets/widget_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    //final LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);

    var loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: loginProvider.myAppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section
            Stack(
              children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: loginProvider.myAppColors.white,
                  ),
                ),
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: loginProvider.myAppColors.primaryGolden,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h,/*right: 50.w*/),
                      child: Text(
                        "LOGIN",
                        style: loginProvider.myAppTextStyle.quickSandMedium(
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
                    color: loginProvider.myAppColors.primaryGolden.withOpacity(1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(60),
                      //topLeft: Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: loginProvider.myAppColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      //topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                    child: Form(
                      key: loginProvider.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Title
                          Text(
                            "Welcome to RSVP",
                            style: GoogleFonts.palanquin(
                              fontWeight: FontWeight.w600,
                              fontSize: 3.h, // Adjust the size as per your design
                              color: loginProvider.myAppColors.primaryGolden,
                            ),
                          ),
                          SizedBox(height: 2.h), // Space below the title
                          // ITS Number Field
                          Card(
                            elevation: 5, // Add elevation for shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                            ),
                            child: TextFormField(
                              controller: loginProvider.itsController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "ITS Number",
                                labelStyle: loginProvider.myAppTextStyle.quickSandRegular(color: Colors.grey,size: 0.2.h),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color:
                                      loginProvider.myAppColors.primaryGolden,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          loginProvider.myAppColors.primaryGolden,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          loginProvider.myAppColors.primaryGolden),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          // Password Field
                          Card(
                            elevation: 5, // Add elevation for shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                            ),
                            child: TextFormField(
                              controller: loginProvider.passwordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle:loginProvider.myAppTextStyle.quickSandRegular(color: Colors.grey,size: 0.2.h),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: loginProvider.myAppColors.primaryGolden,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: loginProvider.myAppColors.primaryGolden,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: loginProvider.myAppColors.primaryGolden),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 4.h),
                          // Login Button
                          InkWell(
                            onTap: () async {
                              setState(() {
                                String? errorMessage;
                                if (loginProvider.itsController.text.isEmpty) {
                                  errorMessage = "Please enter ITS Number";
                                }
                                // Validate Password
                                else if (loginProvider.passwordController.text.isEmpty) {
                                  errorMessage = "Please enter your password";
                                }
                                if (errorMessage != null) {
                                  // Show error message in snackbar
                                  WidgetUtil().showToastError(context, errorMessage);

                                } else {
                                  // If validation passes, proceed with sign-up
                                  setState(() {
                                    loginProvider.loginBtnPressed(context,loginProvider.itsController.text.trim(), loginProvider.passwordController.text);
                                  });
                                }

                              });
                            },
                            child: Card(
                              elevation: 5, // Add elevation for shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                              ),
                              child: Container(
                                height: 6.h,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: loginProvider.myAppColors.primaryGolden,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: loginProvider.myAppColors.primaryGolden.withOpacity(0.3), // Shadow color
                                      spreadRadius: 3,
                                      blurRadius: 8,
                                      offset: const Offset(0, 3), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: loginProvider.myAppTextStyle.quickSandMedium(
                                      size: 2.5,
                                      color: Colors.white,
                                    ),
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
                              text: "You don't have an account? ",
                              style: loginProvider.myAppTextStyle.quickSandBold(
                                size: 1.5,
                                color: Colors.blueGrey[900],
                              ),
                              children: [
                                TextSpan(
                                  text: "Register",
                                  style: loginProvider.myAppTextStyle.quickSandBold(
                                    size: 2,
                                    color: loginProvider.myAppColors.primaryGolden, // Highlighted color
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle Register tap action
                                      loginProvider.login(context); // Replace with your register route
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
