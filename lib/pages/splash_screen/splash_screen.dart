import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_project/utils/mobile_navigation_manager.dart';

import '../../utils/sharedprefrence_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SharedPreferenceUtill.getLoginResponse().then((value) {
      if(value != null){
        Timer(const Duration(seconds: 4), () {
          final mobileNavigationManager = MobileNavigationManager();
          mobileNavigationManager.goToUserHomePage(context);
        });
      }else{
        Timer(const Duration(seconds: 4), () {
          final mobileNavigationManager = MobileNavigationManager();
          mobileNavigationManager.goToLogInPage(context);
        });
      }
    });

    // Navigate to the login page after 3 seconds



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          "assets/images/splash_image.jpg",
          fit: BoxFit.cover, // Changed for a better visual fit
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Text(
                'Image not found',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }
}