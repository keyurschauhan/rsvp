import 'package:flutter/cupertino.dart';

import '../utils/color_const.dart';
import '../utils/mobile_navigation_manager.dart';
import '../utils/my_app_text_style.dart';
import 'family_member_add_provider.dart';

class IndividualScanningProvider extends ChangeNotifier{

  final MyAppColors myAppColors = MyAppColors();
  final MyAppTextStyle myAppTextStyle = MyAppTextStyle();
  final MobileNavigationManager mobileNavigationManager = MobileNavigationManager();

  final TextEditingController searchController = TextEditingController();
  List<Member> members = [
    Member(name: 'Ahmed Ali', isSelected: false, itsNumber: '987654312',profile: ""),
    Member(name: 'Fatima Zahra', isSelected: true, itsNumber: '912345678',profile: ""),
    Member(name: 'Mohammed Hassan', isSelected: false, itsNumber: '876543219',profile: ""),
    Member(name: 'Aisha Siddiqui', isSelected: true, itsNumber: '765432198',profile: ""),
    // Member(name: 'Fatima Zahra', isSelected: true, itsNumber: '987654312',profile: ""),
    // Member(name: 'Mohammed Hassan', isSelected: true, itsNumber: '876543219',profile: ""),
    // Member(name: 'Mohammed Hassan', isSelected: true, itsNumber: '876543219',profile: ""),
  ];
}