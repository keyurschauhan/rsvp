import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/provider/report_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/home_provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({required this.reportProvider,super.key});

  final ReportProvider reportProvider;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    var reportProvider = widget.reportProvider;

    return Scaffold(
      backgroundColor: reportProvider.myAppColors.white,
      body: Column(
        children: [
          // Custom Header with Drawer Icon and Title
          Stack(
            children: [
              Container(
                height: 15.h,
                decoration: BoxDecoration(
                  color: reportProvider.myAppColors.white,
                ),
              ),
              Container(
                height: 15.h,
                decoration: BoxDecoration(
                  color: reportProvider.myAppColors.primaryGolden,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(60),
                  ),),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 5.h, left: 3.w, right: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_rounded,
                              color: Colors.white, size: 4.h,)),
                        const Spacer(),
                        Text(
                          "REPORTS",
                          style: reportProvider.myAppTextStyle
                              .quickSandMedium(
                              size: 2.8, color: Colors.white),
                        ),
                        const Spacer(),
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
                  color: reportProvider.myAppColors.primaryGolden.withOpacity(
                      1),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(60),
                    //topLeft: Radius.circular(40),
                  ),
                ),
              ),
              Container(
                height: 85.h,
                decoration: BoxDecoration(
                  color: reportProvider.myAppColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    //topLeft: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Align heading to the start
                      children: [
                        //SizedBox(height: 2.h,),
                        _buildInputCard(
                          icon: Icons.calendar_today,
                          label: "Event Date",
                          controller: reportProvider.searchController,
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              builder: (BuildContext context,
                                  Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: reportProvider
                                        .myAppColors.primaryGolden,
                                    // Header background color
                                    hintColor: reportProvider.myAppColors
                                        .primaryGolden,
                                    // Selected date color
                                    colorScheme: ColorScheme.light(
                                      primary: reportProvider.myAppColors
                                          .primaryGolden,
                                      // Header text and selected date color
                                      onPrimary: Colors.white,
                                      // Text color on primary color
                                      onSurface: Colors
                                          .black, // Default text color
                                    ),
                                    dialogBackgroundColor: reportProvider
                                        .myAppColors.white,
                                    // Dialog background color
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: reportProvider
                                            .myAppColors
                                            .primaryGolden, // Button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (selectedDate != null) {
                              // Format and set the selected date to the controller
                              reportProvider.searchController.text = selectedDate.toLocal().toString().split(' ')[0];
                            }


                          },
                        ),
                        SizedBox(height: 1.h),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: reportProvider.events.length,
                            itemBuilder: (context, index) {
                              var event = reportProvider.events[index];
                              return Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(
                                    vertical: 1.5.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadowColor: Colors.grey.withOpacity(0.4),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1,
                                        color: reportProvider.myAppColors
                                            .primaryGolden),
                                    borderRadius: BorderRadius.circular(
                                        12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.h, vertical: 1.5.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        // Event Header
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset("assets/images/groups.png",height: 4.h,),
                                                SizedBox(width: 2.w),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      event.name,
                                                      style: GoogleFonts
                                                          .poppins(
                                                        fontSize: 2.h,
                                                        fontWeight: FontWeight
                                                            .w600,
                                                        color: const Color(0xFF7f6400),
                                                      ),
                                                    ),
                                                    Text(
                                                      event.date,
                                                      style: GoogleFonts
                                                          .poppins(
                                                        fontSize: 1.6.h,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),

                                        // Divider
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.5.h),
                                          child: Divider(
                                            color: reportProvider
                                                .myAppColors.primaryGolden
                                                .withOpacity(0.6),
                                            thickness: 0.8,
                                          ),
                                        ),

                                        // Event Statistics
                                        GridView.count(
                                          padding: EdgeInsets.zero,
                                          crossAxisCount: 2,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          childAspectRatio: 2.5,
                                          crossAxisSpacing: 2.w,
                                          mainAxisSpacing: 2.h,
                                          children: [
                                            buildStatTile(
                                              event,
                                              reportProvider,
                                              "Registered",
                                              event.registered,
                                              Colors.green,
                                              Icons.how_to_reg,
                                            ),
                                            buildStatTile(
                                              event,
                                              reportProvider,
                                              "Not-Registered",
                                              event.unregistered,
                                              Colors.orange,
                                              Icons.cancel,
                                            ),
                                            buildStatTile(
                                              event,
                                              reportProvider,
                                              "Present",
                                              event.present,
                                              Colors.blue,
                                              Icons.check_circle,
                                            ),
                                            buildStatTile(
                                              event,
                                              reportProvider,
                                              "Absent",
                                              event.absent,
                                              Colors.red,
                                              Icons.remove_circle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        //initialValue: DateTime.now().toIso8601String(),
        controller: controller,
        onTap: onTap,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 2.h,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            icon,
            color: widget.reportProvider.myAppColors.primaryGolden,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.reportProvider.myAppColors.primaryGolden,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.reportProvider.myAppColors.primaryGolden,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget buildStatTile(Event event,ReportProvider reportProvider,String title, num count, Color color, IconData icon) {
    return InkWell(
      onTap: (){
        log("YES ::${title}");
        reportProvider.goToListScreen(context,title,event);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        child: Row(
          children: [
            Container(
              height: 3.5.h,
              width: 3.5.h,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 2.5.h),
            ),
            SizedBox(width: 1.5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 1.6.h,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  count.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 1.8.h,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

