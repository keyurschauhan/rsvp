import 'package:flutter/material.dart';

import '../utils/color_const.dart';
import '../utils/mobile_navigation_manager.dart';
import '../utils/my_app_text_style.dart';
import 'family_member_add_provider.dart';
import 'home_provider.dart';

class ReportProvider extends ChangeNotifier{

  final MyAppColors myAppColors = MyAppColors();
  final MyAppTextStyle myAppTextStyle = MyAppTextStyle();
  final MobileNavigationManager mobileNavigationManager = MobileNavigationManager();

  TextEditingController searchController = TextEditingController();
  TextEditingController searchListController = TextEditingController();

  void goToListScreen(BuildContext context,String title,Event event){
    mobileNavigationManager.goToReportsListScreen(context, title,this,event);
  }

  List<Member> members = [
    Member(name: 'Ahmed Ali', isSelected: false, itsNumber: '987654312',profile: ""),
    Member(name: 'Fatima Zahra', isSelected: true, itsNumber: '912345678',profile: ""),
    Member(name: 'Mohammed Hassan', isSelected: false, itsNumber: '876543219',profile: ""),
    Member(name: 'Aisha Siddiqui', isSelected: true, itsNumber: '765432198',profile: ""),
    // Member(name: 'Fatima Zahra', isSelected: true, itsNumber: '987654312',profile: ""),
    // Member(name: 'Mohammed Hassan', isSelected: true, itsNumber: '876543219',profile: ""),
    // Member(name: 'Mohammed Hassan', isSelected: true, itsNumber: '876543219',profile: ""),
  ];

  List<Event> events = [
    Event(
      name: "16mi Raat Jaman",
      description: "A celebratory feast on the 16th night after a significant event..",
      date: "25 Dec 2024",
      location: "Dubai World Trade Center, Dubai",
      registered: 150,
      unregistered: 40,
      present: 130,
      absent: 20
    ),
    Event(
      name: "Shadi Jaman",
      description: "Hussain and Rashida ni shadi ni khushi ni Darees and Jaman no izan araz che.",
      date: "25 Dec 2024",
      location: "Kuwait International, Kuwait City",
        registered: 150,
        unregistered: 40,
        present: 130,
        absent: 20
    ),
    // Event(
    //   name: "Fatiha Jaman",
    //   description: "A meal held after reciting Surah Al-Fatiha to seek blessings.",
    //   date: "27 Dec 2024",
    //   location: "Dubai Expo 2020 Site, Dubai",
    //     registered: 150,
    //     unregistered: 40,
    //     present: 130,
    //     absent: 20
    // ),
    // Event(
    //   name: "Waras Jaman",
    //   description: "A communal feast to celebrate an important family or community event.",
    //   date: "28 Dec 2024",
    //   location: "The Ritz-Carlton, Dubai",
    //     registered: 150,
    //     unregistered: 40,
    //     present: 130,
    //     absent: 20
    // ),
  ];

}