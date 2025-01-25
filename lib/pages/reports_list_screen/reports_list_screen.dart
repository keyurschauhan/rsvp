import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/provider/home_provider.dart';
import 'package:my_project/provider/report_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReportsListScreen extends StatefulWidget {
  const ReportsListScreen({required this.title, required this.event, required this.reportProvider, super.key});

  final String title;
  final ReportProvider reportProvider;
  final Event event;

  @override
  State<ReportsListScreen> createState() => _ReportsListScreenState();
}

class _ReportsListScreenState extends State<ReportsListScreen> {
  @override
  Widget build(BuildContext context) {
    var reportProvider = widget.reportProvider;

    return Scaffold(
      backgroundColor: reportProvider.myAppColors.white,
      body: SingleChildScrollView(
        child: Column(
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
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5.h, left: 3.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 4.h,
                            ),
                          ),

                          Text(
                            widget.title,
                            style: reportProvider.myAppTextStyle
                                .quickSandMedium(
                              size: 2.8,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.file_download_outlined,
                              color: Colors.white,
                              size: 4.h,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Event Details Section


            // Remaining UI Elements
            Stack(
              children: [
                Container(
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: reportProvider.myAppColors.primaryGolden.withOpacity(
                        1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(60),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 85.h,
                    decoration: BoxDecoration(
                      color: reportProvider.myAppColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 3.5.w, right: 3.5.w, top: 2.h),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.h),
                              child: Row(
                                children: [
                                  // Event Icon
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: reportProvider.myAppColors.primaryGolden
                                          .withOpacity(0.2),
                                    ),
                                    padding: EdgeInsets.all(1.h),
                                    child: Image.asset(
                                      "assets/images/groups.png",
                                      height: 3.h,
                                      width: 3.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  // Event Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Event Name
                                        Text(
                                          widget.event.name,
                                          style: GoogleFonts.poppins(
                                            fontSize: 2.h,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF7f6400),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        SizedBox(height: 0.2.h),

                                        // Event Date
                                        Text(
                                          widget.event.date,
                                          style: GoogleFonts.poppins(
                                            fontSize: 1.4.h,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 1.h,),
                             Divider(color: reportProvider.myAppColors.primaryGolden,),
                            SizedBox(height: 1.h,),

                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: reportProvider
                                    .searchListController,
                                maxLines: 1,
                                onFieldSubmitted: (value) {
                                  // Handle search functionality here
                                },
                                style: const TextStyle(
                                    color: Colors.black),
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  labelText: "Search...",
                                  labelStyle: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 16, // Use a standard font size
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: widget.reportProvider
                                        .myAppColors.primaryGolden,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: widget.reportProvider
                                        .myAppColors.primaryGolden,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: widget.reportProvider
                                          .myAppColors.primaryGolden,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: widget.reportProvider
                                          .myAppColors.primaryGolden,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        12),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 1.h,),

                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: reportProvider.members.length,
                                itemBuilder: (context, index) {
                                  final member = reportProvider.members[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.6.h),
                                    child: Card(
                                      elevation: 4,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      shadowColor: Colors.grey,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 1.h, bottom: 1.h, left: 2.w),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Count Display
                                            SizedBox(width: 2.w),
                                            Text(
                                              "${index + 1}.", // Replace `count` with the current index + 1
                                              style: GoogleFonts.poppins(
                                                fontSize: 2.h,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            // Avatar
                                            Container(
                                              width: 5.h,
                                              height: 5.h,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: reportProvider.myAppColors.primaryGolden,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                radius: 3.h,
                                                backgroundColor: reportProvider.myAppColors.primaryGolden
                                                    .withOpacity(0.3),
                                                backgroundImage: member.profile != null &&
                                                    member.profile!.isNotEmpty
                                                    ? NetworkImage(member.profile!)
                                                    : null,
                                                child: member.profile == null || member.profile!.isEmpty
                                                    ? Text(
                                                  member.name[0].toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 2.h,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(0xFF7f6400),
                                                  ),
                                                )
                                                    : null,
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            // Member Details
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    member.name,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 1.8.h,
                                                      fontWeight: FontWeight.w600,
                                                      color: const Color(0xFF7f6400),
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    member.itsNumber,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 1.5.h,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void exportList() {
    // Implement the logic for exporting the list
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Exporting list...",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: widget.reportProvider.myAppColors.primaryGolden,
      ),
    );
  }
}
