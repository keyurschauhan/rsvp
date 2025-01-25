import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/provider/group_scanning_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GroupScanningScreen extends StatefulWidget {
  const GroupScanningScreen({required this.groupScanningProvider,super.key});

  final GroupScanningProvider groupScanningProvider;

  @override
  State<GroupScanningScreen> createState() => _GroupScanningScreenState();
}

class _GroupScanningScreenState extends State<GroupScanningScreen> {
  @override
  Widget build(BuildContext context) {
    var groupScanningProvider = widget.groupScanningProvider;

    return Scaffold(
      backgroundColor: groupScanningProvider.myAppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Header with Drawer Icon and Title
            Stack(
              children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: groupScanningProvider.myAppColors.white,
                  ),
                ),
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: groupScanningProvider.myAppColors.primaryGolden,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(60),
                    ),),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h,left: 3.w,right: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_rounded,
                                color: Colors.white,size: 4.h,)),
                          Spacer(),
                          Text(
                            "GROUP SCAN",
                            style: groupScanningProvider.myAppTextStyle.quickSandMedium(
                                size: 2.8, color: Colors.white),
                          ),
                          Spacer(),
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
                    color: groupScanningProvider.myAppColors.primaryGolden.withOpacity(1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(60),
                      //topLeft: Radius.circular(40),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 85.h,
                    decoration: BoxDecoration(
                      color: groupScanningProvider.myAppColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        //topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(height: 1.h),
                            _buildInputCard(
                              icon: Icons.search_rounded,
                              sIcon: Icons.arrow_drop_down_outlined,
                              label: "Search...",
                              controller: groupScanningProvider.searchController,
                            ),

                            SizedBox(height: 2.h),
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1,color: groupScanningProvider.myAppColors.primaryGolden)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(1.5.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Group Members",
                                        style: GoogleFonts.poppins(
                                          fontSize: 2.h,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.left, // Align text to the left
                                      ),

                                      Container(
                                        height: 55.h,
                                        child:ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: groupScanningProvider.members.length,
                                          itemBuilder: (context, index) {
                                            final member = groupScanningProvider.members[index];
                                            final isRegistered = member.isSelected;

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
                                                  padding: EdgeInsets.only(top: 1.h, bottom: 1.h, left: 2.w),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      // Profile Picture or Initials
                                                      Container(
                                                        width: 5.h,
                                                        height: 5.h,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                            color: groupScanningProvider.myAppColors.primaryGolden,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        child: CircleAvatar(
                                                          radius: 3.h,
                                                          backgroundColor: groupScanningProvider.myAppColors.primaryGolden.withOpacity(0.3),
                                                          backgroundImage: member.profile != null && member.profile!.isNotEmpty
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

                                                      // Member Information
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            // Member Name
                                                            Text(
                                                              member.name,
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 1.8.h,
                                                                fontWeight: FontWeight.w600,
                                                                color: const Color(0xFF7f6400),
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                            // ITS Number
                                                            Text(
                                                              member.itsNumber,
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 1.5.h,
                                                                color: Colors.grey.shade600,
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                            ),


                                                            SizedBox(height: 0.2.h),

                                                            // Registered/Not Registered Status Text
                                                            Row(
                                                              children: [
                                                                // Icon(
                                                                //   isRegistered ? Icons.check_circle_outline : Icons.cancel_outlined,
                                                                //   color: isRegistered ? Colors.green : Colors.red,
                                                                //   size: 2.h,
                                                                // ),
                                                                // SizedBox(width: 1.w),
                                                                Text(
                                                                  isRegistered ? "Registered" : "Not Registered",
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize: 1.5.h,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: isRegistered ? Colors.green : Colors.red,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      // Registered/Not Registered Status Icon


                                                      // Checkbox
                                                      Checkbox(
                                                        value: member.isSelected,
                                                        activeColor: groupScanningProvider.myAppColors.primaryGolden,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            member.isSelected = value!;
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

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),

                            // Save Button
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: InkWell(
                                onTap: () {
                                  // Save logic
                                },
                                child: Container(
                                  height: 6.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: groupScanningProvider.myAppColors.primaryGolden,
                                    // gradient: LinearGradient(
                                    //   colors: [
                                    //
                                    //    // eventProvider.myAppColors.primaryGolden.withOpacity(0.8),
                                    //   ],
                                    // ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: groupScanningProvider.myAppColors.primaryGolden
                                            .withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "SAVE",
                                      style: groupScanningProvider.myAppTextStyle.quickSandBold(
                                        size: 2.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
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

  Widget _buildInputCard({
    required IconData icon,
    IconData? sIcon,
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
        controller: controller,
        maxLines: maxLines,
        readOnly: readOnly,
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
            color: widget.groupScanningProvider.myAppColors.primaryGolden,
          ),
          suffixIcon:  Icon(
            sIcon,
            color: widget.groupScanningProvider.myAppColors.primaryGolden,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.groupScanningProvider.myAppColors.primaryGolden,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.groupScanningProvider.myAppColors.primaryGolden,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
