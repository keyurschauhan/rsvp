import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/utils/color_const.dart';
import 'package:my_project/utils/mobile_navigation_manager.dart';
import 'package:my_project/utils/my_app_text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'family_member_add_provider.dart';

class GroupsProvider extends ChangeNotifier{
  final MyAppColors myAppColors = MyAppColors();
  final MyAppTextStyle myAppTextStyle = MyAppTextStyle();
  final MobileNavigationManager mobileNavigationManager = MobileNavigationManager();

  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController groupDescriptionController = TextEditingController();

  void addGroupTap(BuildContext context){
    mobileNavigationManager.goToAddGroupScreen(context);
  }

  Group? group;

  List<Group> groups = [
    Group(
      name: "Group 1",
      description: "A group celebrating cultural events and heritage gatherings in Dubai.",
      member: 5

    ),
    Group(
      name: "Group 2",
      description: "An association for hosting celebratory gatherings and events in Kuwait City.",
      member: 6
    ),
    Group(
      name: "Group 3",
      description: "A group dedicated to spiritual gatherings and blessings ceremonies.",
      member: 3
    ),
    Group(
      name: "Group 4",
      description: "A close-knit group for celebrating family milestones and community events.",
      member: 8
    ),
    Group(
        name: "Group 5",
        description: "A group celebrating cultural events and heritage gatherings in Dubai.",
        member: 5
    ),
    Group(
        name: "Group 6",
        description: "An association for hosting celebratory gatherings and events in Kuwait City.",
        member: 6
    ),
    Group(
        name: "Group 7",
        description: "A group dedicated to spiritual gatherings and blessings ceremonies.",
        member: 3
    ),
    Group(
        name: "Group 8",
        description: "A close-knit group for celebrating family milestones and community events.",
        member: 8
    ),
    Group(
        name: "Group 9",
        description: "A group celebrating cultural events and heritage gatherings in Dubai.",
        member: 5

    ),
    Group(
        name: "Group 10",
        description: "An association for hosting celebratory gatherings and events in Kuwait City.",
        member: 6
    ),
    Group(
        name: "Group 11",
        description: "A group dedicated to spiritual gatherings and blessings ceremonies.",
        member: 3
    ),
    Group(
        name: "Group 12",
        description: "A close-knit group for celebrating family milestones and community events.",
        member: 8
    ),
  ];

  List<Member> members = [
    Member(name: 'Ahmed Ali', isSelected: false, itsNumber: '987654312',profile: ""),
    Member(name: 'Fatima Zahra', isSelected: true, itsNumber: '912345678',profile: ""),
    Member(name: 'Mohammed Hassan', isSelected: false, itsNumber: '876543219',profile: ""),
    Member(name: 'Aisha Siddiqui', isSelected: true, itsNumber: '765432198',profile: ""),
    Member(name: 'Fatima Zahra', isSelected: true, itsNumber: '987654312',profile: ""),
    Member(name: 'Mohammed Hassan', isSelected: true, itsNumber: '876543219',profile: ""),
  ];

  Future<void> showEventDetails(BuildContext context, Group group) async {
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
                    padding:  EdgeInsets.all(1.5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Name
                        Row(
                          children: [
                            Image.asset("assets/images/meeting.png",height: 3.h,),
                            SizedBox(width: 3.w,),
                            Text(
                              group.name,
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
                          group.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 1.5.h,
                            color: Colors.black87,
                          ),
                        ),

                        SizedBox(height: 2.h),

                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person, color: Color(0xFF7f6400), size: 20),
                                SizedBox(width: 1.h),
                                Text(
                                  "Group Members : ",
                                  style: GoogleFonts.poppins(
                                    fontSize: 2.h,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              group.member.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 2.5.h,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
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
                        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Keeps the button compact
                          children: [
                            Icon(Icons.edit, size: 2.h, color: Colors.white), // Edit icon
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
                        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Keeps the button compact
                          children: [
                            Icon(Icons.delete, size: 2.h, color: Colors.white), // Delete icon
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

class Group {
  final String name;
  final String description;
  final int member;


  Group({
    required this.name,
    required this.description,
    required this.member,

  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json['name'],
      description: json['description'],
      member: json['Member'],

    );
  }

  // Optional: Add a method to convert the Event to JSON.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'Member': member,

    };
  }
}