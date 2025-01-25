import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/utils/color_const.dart';
import 'package:my_project/utils/mobile_navigation_manager.dart';
import 'package:my_project/utils/my_app_text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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

  Event? event;

  void addEventTap(BuildContext context) {
    mobileNavigationManager.goToAddEventScreen(context);
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

  Future<void> showEventDetails(BuildContext context, Event event) async {
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
                              event.name,
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
                          event.description,
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
                              event.date,
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
                                event.location,
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
                    ElevatedButton(
                      onPressed: () {},
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
