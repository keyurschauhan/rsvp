import 'package:flutter/material.dart';
import 'package:my_project/pages/add_group_screen/add_group_screen.dart';
import 'package:my_project/pages/events_screen/event_screen.dart';
import 'package:my_project/pages/groups_screen/groups_scree.dart';
import 'package:my_project/pages/report_screen/report_screen.dart';
import 'package:my_project/pages/reports_list_screen/reports_list_screen.dart';
import 'package:my_project/provider/event_provider.dart';
import 'package:my_project/provider/group_scanning_screen.dart';
import 'package:my_project/provider/home_provider.dart';
import 'package:my_project/provider/individual_scanning_screen.dart';
import 'package:my_project/provider/report_provider.dart';
import 'package:my_project/utils/sliding.dart';
import 'package:provider/provider.dart';

import '../data_models/user_event_list_data_model.dart';
import '../pages/add_event_screen/add_event_screen.dart';
import '../pages/edit_profile_screen/edit_profile_screen.dart';
import '../pages/family_list_screen/family_list_screen.dart';
import '../pages/family_member_add_screen/family_member_add_screen.dart';
import '../pages/group_scanning_screen/group_scanning_screen.dart';
import '../pages/home_screen/home_screen.dart';
import '../pages/individual_scanning_screen/individual_scanning_screen.dart';
import '../pages/login_screen/login_screen.dart';
import '../pages/signin_screen/signin_screen.dart';
import '../provider/edit_profile_provider.dart';
import '../provider/family_list_provider.dart';
import '../provider/family_member_add_provider.dart';
import '../provider/groups_provider.dart';
import '../provider/login_provider.dart';
import '../provider/signin_provider.dart';

class MobileNavigationManager{

  void goToSignUpPage(BuildContext context){
    final SignInProvider signInProvider = SignInProvider();

    Navigator.push(
          context,
          SlideRoute(page: ChangeNotifierProvider.value(
              value: signInProvider,
              child: const SignInScreen())), // Slide to SignInScreen
        );
  }

  Future<void> goToUserHomePage(BuildContext context) async {
    final HomeProvider userHomeProvider = HomeProvider();

      Navigator.pushReplacement(
        context,
        SlideRoute(page: ChangeNotifierProvider.value(
            value: userHomeProvider,
            child: const HomeScreen())), // Slide to SignInScreen
      );

  }

  void goToFamilyAddScreen(Events event,BuildContext context){
    final FamilyMemberAddProvider familyAddProvider = FamilyMemberAddProvider();

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: familyAddProvider,
          child: FamilyMemberAddScreen(event: event,))), // Slide to SignInScreen
    );
  }

  void goToEditProfileScreen(BuildContext context){
    final EditProfileProvider editProfileProvider = EditProfileProvider();

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: editProfileProvider,
          child: const EditProfileScreen())), // Slide to SignInScreen
    );
  }

  void goToFamilyListScreen(BuildContext context){
    final FamilyListProvider familyListProvider = FamilyListProvider();

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: familyListProvider,
          child: const FamilyListScreen())), // Slide to SignInScreen
    );
  }

  void goToAddEventScreen(BuildContext context,EventProvider eventProvider){

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: eventProvider,
          child: AddEventScreen(eventProvider: eventProvider,))), // Slide to SignInScreen
    );
  }

  void goToAddGroupScreen(BuildContext context){
    final GroupsProvider groupsProvider = GroupsProvider();

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: groupsProvider,
          child: AddGroupScreen(groupsProvider: groupsProvider,))), // Slide to SignInScreen
    );
  }

  void goToEventScreen(BuildContext context){
    final EventProvider eventProvider = EventProvider();

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: eventProvider,
          child: const EventScreen())), // Slide to SignInScreen
    );
  }

  void goToGroupsScreen(BuildContext context){
    final GroupsProvider groupsProvider = GroupsProvider();

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: groupsProvider,
          child: GroupsScreen(groupsProvider: groupsProvider))), // Slide to SignInScreen
    );
  }

  void goToIndividualScanningScreen(BuildContext context){
    final IndividualScanningProvider individualScanningProvider = IndividualScanningProvider();

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: individualScanningProvider,
          child: IndividualScanningScreen(individualScanningProvider: individualScanningProvider))), // Slide to SignInScreen
    );
  }

  void goToReportsListScreen(BuildContext context,String title,ReportProvider reportProvider,Event event){

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: reportProvider,
          child: ReportsListScreen(reportProvider: reportProvider,title: title,event: event,))), // Slide to SignInScreen
    );
  }

  void goToGroupScanningScreen(BuildContext context){
    final GroupScanningProvider groupScanningProvider = GroupScanningProvider();

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: groupScanningProvider,
          child: GroupScanningScreen(groupScanningProvider: groupScanningProvider))), // Slide to SignInScreen
    );
  }

  void goToReportScreen(BuildContext context){
    final ReportProvider reportProvider = ReportProvider();

    Navigator.push(
      context,
      SlideRoute(page: ChangeNotifierProvider.value(
          value: reportProvider,
          child: ReportScreen(reportProvider: reportProvider))), // Slide to SignInScreen
    );
  }


  Future<void> goToLogInPage(BuildContext context) async {
    final LoginProvider loginProvider = LoginProvider();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => ChangeNotifierProvider.value(
        value: loginProvider,
          child: const LoginScreen())),
    );

    // Navigator.of(context).pushReplacement(
    //   context,
    //   SlideRoute(page: ChangeNotifierProvider.value(
    //       value: loginProvider,
    //       child: LoginScreen(loginProvider: loginProvider))), // Slide to SignInScreen
    // );
  }
}