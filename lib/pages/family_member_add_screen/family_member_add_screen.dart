import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/data_models/user_event_list_data_model.dart';
import 'package:my_project/provider/family_member_add_provider.dart';
import 'package:my_project/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/sharedprefrence_utils.dart';

class FamilyMemberAddScreen extends StatefulWidget {
  const FamilyMemberAddScreen({required this.event,super.key});

  final Events event;

  @override
  State<FamilyMemberAddScreen> createState() => _FamilyMemberAddScreenState();
}

class _FamilyMemberAddScreenState extends State<FamilyMemberAddScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var familyAddProvider = Provider.of<FamilyMemberAddProvider>(context,listen: false);

    SharedPreferenceUtill.getLoginResponse().then((value) {
      if (value != null) {
        setState(() {
          familyAddProvider.loginDataModel = value;
        });
      }
    }).whenComplete(
          () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          familyAddProvider.getFamilyMemberAttendanceList(context,widget.event.eventId!.toInt());
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //final LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);

    var familyAddProvider = Provider.of<FamilyMemberAddProvider>(context);

    return Scaffold(
      backgroundColor: familyAddProvider.myAppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section
            Stack(
              children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: familyAddProvider.myAppColors.white,
                  ),
                ),
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: familyAddProvider.myAppColors.primaryGolden,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h,left: 3.w,right: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);}, icon: Icon(Icons.arrow_back_rounded,
                            color: Colors.white,size: 4.h,)),
                          Spacer(),
                          Text(
                            "MANAGE ATTENDANCE",
                            style: familyAddProvider.myAppTextStyle.quickSandMedium(
                                size: 2.8, color: Colors.white),
                          ),

                        ],
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
                    color: familyAddProvider.myAppColors.primaryGolden.withOpacity(1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(60),
                      //topLeft: Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: familyAddProvider.myAppColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      //topLeft: Radius.circular(40),
                    ),
                  ),
                  child:  Padding(
                    padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          shadowColor: Colors.black,
                          color: Colors.white,
                          borderOnForeground: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)) ),
                          elevation: 5,
                          child: SizedBox(
                            height: 20.h, // Fixed height for the card
                            child: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Event Name
                                  Row(
                                    children: [
                                      Image.asset("assets/images/groups.png",height: 3.h,),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        widget.event.eventName ?? "-",
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
                                    widget.event.eventDescription ?? "-",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 1.5.h,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 1.5.h),

                                  // Event Date
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today, color: Color(0xFF7f6400), size: 20),
                                      SizedBox(width: 1.h),
                                      Text(
                                        widget.event.eventDate ?? "-",
                                        style: GoogleFonts.poppins(
                                          fontSize: 1.5.h,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 0.5.h),

                                  // Event Location
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, color: Color(0xFF7f6400), size: 20),
                                      SizedBox(width: 1.h),
                                      Expanded(
                                        child: Text(
                                          widget.event.eventLocation ?? "-",
                                          style: GoogleFonts.poppins(
                                            fontSize: 1.5.h,
                                            color: Colors.black54,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 1.5.h, right: 5.w),
                          child: Text(
                            "Select Members",
                            style: GoogleFonts.poppins(
                              fontSize: 2.5.h,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left, // Align text to the left
                          ),
                        ),

                        SizedBox(
                          height: 0.h,
                        ),

                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true, // Prevent scrolling conflicts with the parent

                            itemCount: familyAddProvider.familyMemberList.length,
                            itemBuilder: (context, index) {
                              final member = familyAddProvider.familyMemberList[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.6.h),
                                child: Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadowColor: Colors.grey,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 1.h,bottom: 1.h,right: 1.w,left: 4.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Checkbox

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Member Name
                                            SizedBox(
                                              width: 70.w,
                                              child: Text(
                                                member.name ?? "-",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 1.8.h,
                                                  fontWeight: FontWeight.w600,
                                                  color:const Color(0xFF7f6400),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              member.itsNumber ?? "-",
                                              style: GoogleFonts.poppins(
                                                fontSize: 1.5.h,
                                                color: Colors.grey.shade600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Checkbox(
                                          value: member.attendanceStatus,
                                          //checkColor: familyAddProvider.myAppColors.primaryGolden,
                                          activeColor: familyAddProvider.myAppColors.primaryGolden,
                                          onChanged: (value) {
                                            setState(() {
                                              member.attendanceStatus = value!;
                                              if (value) {
                                                // Add ID to the list if checked
                                                if (!familyAddProvider.selectedIds.contains(member.userId)) {
                                                  familyAddProvider.selectedIds.add(member.userId!.toInt());
                                                }
                                              } else {
                                                // Remove ID from the list if unchecked
                                                familyAddProvider.selectedIds.remove(member.userId);
                                              }
                                              log("BOOL :: ${familyAddProvider.selectedIds}");
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h,top: 2.h),
                          child: InkWell(
                            onTap:() {
                              setState(() {
                                log("IDS :: ${familyAddProvider.selectedIds}");
                                if(familyAddProvider.selectedIds.isNotEmpty){
                                  familyAddProvider.manageAttendance(context,widget.event.eventId!.toInt());
                                }
                                // Login logic
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
                                  color: familyAddProvider.myAppColors.primaryGolden,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: familyAddProvider.myAppColors.primaryGolden.withOpacity(0.3), // Shadow color
                                      spreadRadius: 3,
                                      blurRadius: 8,
                                      offset: const Offset(0, 3), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: familyAddProvider.myAppTextStyle.quickSandMedium(
                                      size: 2.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  )


                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
