import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project/pages/splash_screen/splash_screen.dart';
import 'package:my_project/provider/home_provider.dart';
import 'package:my_project/provider/login_provider.dart';
import 'package:my_project/provider/signin_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),

        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set the status bar color
      statusBarIconBrightness: Brightness.light,
      // Set the status bar icon color (light or dark)
    ));
    return ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        });
  }
}

