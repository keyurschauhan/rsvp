import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_project/data_models/login_data_model.dart';
import 'package:my_project/utils/const_util.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../apis/api_callers.dart';
import '../data_models/user_event_list_data_model.dart';
import '../utils/color_const.dart';
import '../utils/mobile_navigation_manager.dart';
import '../utils/my_app_text_style.dart';
import '../widgets/my_app_progress_bar.dart';
import '../widgets/widget_utils.dart';

class HomeProvider extends ChangeNotifier {
  final MyAppColors myAppColors = MyAppColors();
  final MyAppTextStyle myAppTextStyle = MyAppTextStyle();
  final MobileNavigationManager mobileNavigationManager =
      MobileNavigationManager();

  LoginDataModel? loginDataModel;
  List<Events> eventList = [];
  Events? events;

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

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
         currentLocation = "Permission denied";
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        currentLocation =
        "Permission permanently denied";
        notifyListeners();
        return;
      }

      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, // Set the desired accuracy
        distanceFilter:
        10, // Minimum distance between location updates (optional)
      );

      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      log("LATITUDE :: ${position.latitude}");
      log("LONGITUDE :: ${position.longitude}");

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        currentLocation =
        "${place.locality}, ${place.administrativeArea}, ${place.country}";
       notifyListeners();
      } else {
       currentLocation = "Location not found";
        notifyListeners();
      }
    } catch (e) {
      currentLocation = "Error: $e";
      notifyListeners();
    }
  }


  Future<void> getEventListForUser(BuildContext context) async {

    final isConnected = await ConstUtil().checkConnection();

    if (!isConnected) {
      WidgetUtil().showToast(context,"No internet connection.",);
      return;
    }

    try {
      startLoading();
      final response = await ApiCallers().getEventListForUser(
        loginDataModel!.data!.token.toString(),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final eventListData = UserEventListDataModel.fromJson(jsonResponse);

        if (eventListData.status == true && eventListData.events != null) {
          eventList.addAll(eventListData.events!);
          stopLoading();
        } else {
          stopLoading();
          WidgetUtil().showToast(context, eventListData.message ?? "No events found.",);
        }
      } else {
        stopLoading();
        WidgetUtil().showToast(context, "Failed to fetch events.",);
      }
    } catch (error) {
      stopLoading();
      WidgetUtil().showToast(context,"An error occurred: $error",);
    }
  }


  void onCardTap(Events event, BuildContext context) {
    mobileNavigationManager.goToFamilyAddScreen(event, context);
  }

  void editProfileTap(BuildContext context) {
    mobileNavigationManager.goToEditProfileScreen(context);
  }

  void familyTap(BuildContext context) {
    mobileNavigationManager.goToFamilyListScreen(context);
  }

  void eventGridTap(BuildContext context) {
    mobileNavigationManager.goToEventScreen(context);
  }

  void groupsGridTap(BuildContext context) {
    mobileNavigationManager.goToGroupsScreen(context);
  }

  void individualScanGridTap(BuildContext context) {
    mobileNavigationManager.goToIndividualScanningScreen(context);
  }

  void groupScanGridTap(BuildContext context) {
    mobileNavigationManager.goToGroupScanningScreen(context);
  }

  void reportGridTap(BuildContext context) {
    mobileNavigationManager.goToReportScreen(context);
  }

  int getDayOfMonth() {
    DateTime now = DateTime.now();
    return now.day;
  }

  String getMonthAndYear() {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('MMM yyyy'); // Format like 'Dec 2024'
    return dateFormat.format(now);
  }

  String getDayOfWeek() {
    // Get the current date
    DateTime now = DateTime.now();

    // Use DateFormat to format the day as a full weekday name (e.g., "Monday")
    String dayOfWeek = DateFormat('EEEE').format(now);

    return dayOfWeek;
  }

  String currentLocation = "Fetching location...";

  Future<void> showEventDetails(BuildContext context, Events event) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Indicator
                Container(
                  width: 15.w,
                  height: 0.5.h,
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Would You Attend ?',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontSize: 2.5.h,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 1.h),
                Card(
                  shadowColor: Colors.black,
                  color: Colors.white,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(1.5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Name
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/groups.png",
                              height: 3.h,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              event.eventName ?? "-",
                              style: GoogleFonts.poppins(
                                fontSize: 2.h,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF7f6400),
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Color(0xFF7f6400)),
                        SizedBox(height: 1.h),

                        // Event Description
                        Text(
                          event.eventDescription ?? "-",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 1.5.h,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // Event Date
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                color: Color(0xFF7f6400), size: 20),
                            SizedBox(width: 1.h),
                            Text(
                              event.eventDate ?? "-",
                              style: GoogleFonts.poppins(
                                fontSize: 1.5.h,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),

                        // Event Location
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Color(0xFF7f6400), size: 20),
                            SizedBox(width: 1.h),
                            Expanded(
                              child: Text(
                                event.eventLocation ?? "-",
                                style: GoogleFonts.poppins(
                                  fontSize: 1.5.h,
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),

                // Close Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        child: Text(
                          'No',
                          style: GoogleFonts.poppins(
                            fontSize: 1.5.h,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    ElevatedButton(
                      onPressed: () => onCardTap(event, context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7f6400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        child: Text(
                          'Yes',
                          style: GoogleFonts.poppins(
                            fontSize: 1.5.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Event {
  final String name;
  final String description;
  final String date; // Ensure the date is in a format suitable for display
  final String location;
  final num registered;
  final num unregistered;
  final num present;
  final num absent;

  Event({
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    this.registered = 0,
    this.unregistered = 0,
    this.present = 0,
    this.absent = 0,
  });

  // Factory constructor for JSON parsing
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      location: json['location'] ?? '',
      registered: json['registered'] ?? 0,
      unregistered: json['unregistered'] ?? 0,
      present: json['present'] ?? 0,
      absent: json['absent'] ?? 0,
    );
  }

  // Method to convert Event to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date,
      'location': location,
      'registered': registered,
      'unregistered': unregistered,
      'present': present,
      'absent': absent,
    };
  }
}
