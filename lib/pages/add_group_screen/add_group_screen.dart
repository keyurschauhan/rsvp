import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/provider/groups_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({required this.groupsProvider,super.key});

  final GroupsProvider groupsProvider;

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  @override
  Widget build(BuildContext context) {
    var groupsProvider = widget.groupsProvider;

    return Scaffold(
      backgroundColor: groupsProvider.myAppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Header with Drawer Icon and Title
            Stack(
              children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: groupsProvider.myAppColors.white,
                  ),
                ),
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: groupsProvider.myAppColors.primaryGolden,
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
                            "ADD GROUP",
                            style: groupsProvider.myAppTextStyle.quickSandMedium(
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
                    color: groupsProvider.myAppColors.primaryGolden.withOpacity(1),
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
                      color: groupsProvider.myAppColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        //topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                      child: Column(
                        children: [
                          _buildInputCard(
                            icon: Icons.group,
                            label: "Group Code",
                            controller: groupsProvider.groupNameController,
                          ),
                          SizedBox(height: 1.h),
                          // Event Name
                          _buildInputCard(
                            icon: Icons.event,
                            label: "Group Name",
                            controller: groupsProvider.groupNameController,
                          ),
                          // SizedBox(height: 1.h),
                          //
                          // // Event Description
                          // _buildInputCard(
                          //   icon: Icons.description,
                          //   label: "Group Description",
                          //   controller: groupsProvider.groupDescriptionController,
                          //   maxLines: 2,
                          // ),

                          SizedBox(height: 1.h),
                          _buildInputCard(
                            icon: Icons.search,
                            sIcon: Icons.arrow_drop_down_outlined,
                            label: "Search ITS No/Name",
                            controller: groupsProvider.searchController,
                          ),

                          SizedBox(height: 1.5.h),
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
                                border: Border.all(width: 1,color: groupsProvider.myAppColors.primaryGolden)
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
                                    SizedBox(height: 0.5.h),

                                    Container(
                                      height: 40.h,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true, // Prevent scrolling conflicts with the parent
                                        itemCount: groupsProvider.members.length,
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final member = groupsProvider.members[index];
                                          return Padding(
                                            padding: EdgeInsets.symmetric(vertical: 0.5.h),
                                            child: Card(
                                              elevation: 4,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              shadowColor: Colors.grey,
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 0.7.h, bottom: 0.7.h, right: 1.w,left: 2.w),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // Profile Picture or Initials
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 5.h,
                                                          height: 5.h,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            border: Border.all(
                                                              color: groupsProvider.myAppColors.primaryGolden, // Border color
                                                              width: 2.0, // Border width
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            radius: 3.h,
                                                            backgroundColor: groupsProvider.myAppColors.primaryGolden.withOpacity(0.3),
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
                                                        SizedBox(width: 4.w),
                                                        Column(
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
                                                      ],
                                                    ),

                                                    IconButton(onPressed: (){},
                                                        icon:const Icon(
                                                          Icons.delete_forever_rounded,
                                                          color: Colors.red,
                                                        )
                                                    )

                                                    // Member Details

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
                                  color: groupsProvider.myAppColors.primaryGolden,
                                  // gradient: LinearGradient(
                                  //   colors: [
                                  //
                                  //    // eventProvider.myAppColors.primaryGolden.withOpacity(0.8),
                                  //   ],
                                  // ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: groupsProvider.myAppColors.primaryGolden
                                          .withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    "CREATE",
                                    style: groupsProvider.myAppTextStyle.quickSandBold(
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
            color: widget.groupsProvider.myAppColors.primaryGolden,
          ),
          suffixIcon:  Icon(
            sIcon,
            color: widget.groupsProvider.myAppColors.primaryGolden,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.groupsProvider.myAppColors.primaryGolden,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.groupsProvider.myAppColors.primaryGolden,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
