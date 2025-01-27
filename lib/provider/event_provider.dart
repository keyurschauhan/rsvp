import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/data_models/login_data_model.dart';
import 'package:my_project/utils/color_const.dart';
import 'package:my_project/utils/mobile_navigation_manager.dart';
import 'package:my_project/utils/my_app_text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../apis/api_callers.dart';
import '../data_models/user_event_list_data_model.dart';
import '../utils/const_util.dart';
import '../widgets/my_app_progress_bar.dart';
import '../widgets/widget_utils.dart';
import 'home_provider.dart';

class EventProvider extends ChangeNotifier {
  final MyAppColors myAppColors = MyAppColors();
  final MyAppTextStyle myAppTextStyle = MyAppTextStyle();
  final MobileNavigationManager mobileNavigationManager =
      MobileNavigationManager();

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventLastEditableDateController = TextEditingController();

  Events? event;
  List<Events> eventList = [];

  LoginDataModel? loginDataModel;

  Future<void> getEventList(BuildContext context) async {

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => MyAppPageRefresherDialog(
        process: () async {
          final isConnected = await ConstUtil().checkConnection();

          if (!isConnected) {
            WidgetUtil().showToast(context,"No internet connection.",);
            notifyListeners();
            return;
          }

          try {
            final response = await ApiCallers().getEventList(
              loginDataModel!.data!.token.toString(),
            );
            if (response.statusCode == 200) {
              final jsonResponse = jsonDecode(response.body);
              final eventListData = UserEventListDataModel.fromJson(jsonResponse);

              if (eventListData.status == true && eventListData.events != null) {
                eventList.clear();
                eventList.addAll(eventListData.events!);
                notifyListeners();
                Navigator.pop(context);

              } else {
                WidgetUtil().showToast(context, eventListData.message ?? "No events found.",);
                notifyListeners();
                Navigator.pop(context);

              }
            } else {
              WidgetUtil().showToast(context, "Failed to fetch events.",);
              notifyListeners();
              Navigator.pop(context);


            }
          } catch (error) {
            WidgetUtil().showToast(context,"An error occurred: $error",);
            notifyListeners();
            Navigator.pop(context);


          }

        },
      ),
    );
  }

  Future<void> getEventListWithoutLoader() async {
    // Check for internet connectivity
    final isConnected = await ConstUtil().checkConnection();
    if (!isConnected) {
      return; // Exit early if no internet connection
    }

    try {
      // Call the API to fetch the event list
      final response = await ApiCallers().getEventList(
        loginDataModel!.data!.token.toString(),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final eventListData = UserEventListDataModel.fromJson(jsonResponse);

        if (eventListData.status == true && eventListData.events != null) {
          eventList
            ..clear()
            ..addAll(eventListData.events!); // Update the event list
        } else {
          eventList.clear(); // Clear the list if no events are found
        }
      } else {
        log("Failed to fetch events. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      log("An error occurred while fetching the event list: $error");
    } finally {
      notifyListeners(); // Notify listeners regardless of the result
    }
  }


  void addEventTap(BuildContext context){
    mobileNavigationManager.goToAddEventScreen(context,this);
  }

  String? formattedDate;
  String? formattedLastDate;

  Future<bool> addEventBtn(BuildContext context) async {
    try {
      // Show a dialog with the processing function
      final dialogResult = await showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
        builder: (context) => MyAppPageRefresherDialog(
          process: () async {
            try {
              // Make the API call
              final result = await ApiCallers().addEvent(
                loginDataModel!.data!.token.toString(),
                eventNameController.text,
                eventLocationController.text,
                formattedDate!,
                formattedLastDate!,
                eventDescriptionController.text,
              );

              // Check for a successful response
              if (result.statusCode == 200) {
                final response = jsonDecode(result.body);

                if (response['status'] == true) {
                  // Success: Show a toast message
                  WidgetUtil().showToast(context, "Event Added Successfully");
                  return true;
                } else {
                  // Handle errors in the response
                  final itsError = response['error']['its_number'];
                  if (itsError is List && itsError.isNotEmpty) {
                    WidgetUtil().showToastError(
                      context,
                      itsError[0] ?? "Invalid credentials.",
                    );
                  }
                  return false;
                }
              } else {
                // Handle unexpected status codes
                log("Unexpected Status Code: ${result.statusCode}");
                WidgetUtil().showToastError(
                  context,
                  "Unexpected server error. Please try again.",
                );
                return false;
              }
            } catch (e) {
              // Handle API call errors
              log("API Error: $e");
              WidgetUtil().showToastError(
                context,
                "An error occurred while adding the event. Please try again.",
              );
              return false;
            }
          },
        ),
      );

      log("Dialog Result: $dialogResult");

      return dialogResult ?? false; // Return the dialog result or false if null
    } catch (e) {
      // Handle unexpected errors
      log("Unexpected Error: $e");
      WidgetUtil().showToastError(
        context,
        "An unexpected error occurred. Please try again.",
      );
      return false;
    }
  }

  Future<void> deleteEvent(BuildContext context, int eventId) async {
    try {
      // Show a dialog with the processing function
      final dialogResult = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MyAppPageRefresherDialog(
          process: () async {
            // Check for internet connectivity
            final isConnected = await ConstUtil().checkConnection();
            if (!isConnected) {
              WidgetUtil().showToast(context, "No internet connection.");
              return false;
            }

            try {
              // Call the API to delete the event
              final response = await ApiCallers().deleteEvent(
                loginDataModel!.data!.token.toString(),
                eventId,
              );

              log("API Response: ${response.body}");

              if (response.statusCode == 200) {
                final jsonResponse = jsonDecode(response.body);

                // Check if the response indicates success
                if (jsonResponse['status'] == true) {
                  WidgetUtil().showToast(context, jsonResponse['message'] ?? "Event deleted successfully.");
                  notifyListeners();
                  await getEventListWithoutLoader();
                  Navigator.pop(context);
                  return true;
                } else {
                  WidgetUtil().showToast(context, jsonResponse['message'] ?? "Failed to delete the event.");
                  return false;
                }
              } else {
                // Handle non-200 status codes
                WidgetUtil().showToastError(context, "Failed to delete the event. Status Code: ${response.statusCode}");
                return false;
              }
            } catch (e) {
              // Handle any exceptions during the API call
              log("Error deleting event: $e");
              WidgetUtil().showToastError(context, "An error occurred: ${e.toString()}");
              return false;
            }
          },
        ),
      );

      if (dialogResult == true) {
        log("Event successfully deleted.");
      }
    } catch (e) {
      // Handle unexpected errors
      log("Unexpected error: $e");
      WidgetUtil().showToastError(context, "An unexpected error occurred. Please try again.");
    }
  }


  List<Event> events = [
    Event(
        name: "16mi Raat Jaman",
        description:
            "A celebratory feast on the 16th night after a significant event..",
        date: "25 Dec 2024",
        location: "Dubai World Trade Center, Dubai",
    ),
    Event(
        name: "Shadi Jaman",
        description:
            "Hussain and Rashida ni shadi ni khushi ni Darees and Jaman no izan araz che.",
        date: "26 Dec 2024",
        location: "Kuwait International, Kuwait City",
        ),
    Event(
        name: "Fatiha Jaman",
        description:
            "A meal held after reciting Surah Al-Fatiha to seek blessings.",
        date: "27 Dec 2024",
        location: "Dubai Expo 2020 Site, Dubai",
        ),
    Event(
        name: "Waras Jaman",
        description:
            "A communal feast to celebrate an important family or community event.",
        date: "28 Dec 2024",
        location: "The Ritz-Carlton, Dubai",
        ),
  ];

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(loginDataModel!.data!.permission!.eventEdit == "Yes")
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min, // Keeps the button compact
                          children: [
                            Icon(Icons.edit,
                                size: 2.h, color: Colors.white), // Edit icon
                            SizedBox(width: 1.w), // Space between icon and text
                            Text(
                              'Edit  ',
                              style: GoogleFonts.poppins(
                                fontSize: 2.h,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    if(loginDataModel!.data!.permission!.eventDelete == "Yes")
                    ElevatedButton(
                      onPressed: () {
                        deleteEvent(context, int.parse(event.eventId.toString()));

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min, // Keeps the button compact
                          children: [
                            Icon(Icons.delete,
                                size: 2.h, color: Colors.white), // Delete icon
                            SizedBox(width: 1.w), // Space between icon and text
                            Text(
                              'Delete',
                              style: GoogleFonts.poppins(
                                fontSize: 2.h,
                                color: Colors.white,
                              ),
                            ),
                          ],
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
