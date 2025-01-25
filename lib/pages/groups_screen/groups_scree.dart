import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/provider/event_provider.dart';
import 'package:my_project/provider/groups_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({required this.groupsProvider,super.key});

  final GroupsProvider groupsProvider;

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    var groupProvider = widget.groupsProvider;

    return Scaffold(
      backgroundColor: groupProvider.myAppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Header with Drawer Icon and Title
            Stack(
              children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: groupProvider.myAppColors.white,
                  ),
                ),
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: groupProvider.myAppColors.primaryGolden,
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
                            "GROUPS",
                            style: groupProvider.myAppTextStyle.quickSandMedium(
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
                    color: groupProvider.myAppColors.primaryGolden.withOpacity(1),
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
                      color: groupProvider.myAppColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        //topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.5.w, right: 3.5.w, top: 2.h),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align heading to the start
                          children: [
                            // Heading
                            Padding(
                              padding: EdgeInsets.only(top: 1.h,left: 3.w,right: 1.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Groups",
                                    style: GoogleFonts.poppins(
                                      fontSize: 3.h,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.left, // Align text to the left
                                  ),
                                  FloatingActionButton(
                                    backgroundColor: groupProvider.myAppColors.primaryGolden,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50), // Ensures the button is circular
                                    ),
                                    onPressed: (){
                                      groupProvider.addGroupTap(context);
                                    },
                                    child: Icon(Icons.add,color: Colors.white,weight: 10,size: 3.5.h,),)
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: groupProvider.searchController,
                                maxLines: 1, // Search fields are single-line
                                onFieldSubmitted: (value) {
                                  //widget.groupsProvider.searchGroups(value); // Example: Search groups using the provider
                                },
                                style: const TextStyle(color: Colors.black),
                                textInputAction: TextInputAction.search, // Set to 'search' for search-specific behavior
                                decoration: InputDecoration(
                                  labelText: "Search...",
                                  labelStyle: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 2.h,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.search, // Default to a search icon
                                    color: widget.groupsProvider.myAppColors.primaryGolden,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down_outlined,
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
                            ),
                            SizedBox(height: 2.h),

                            // GridView.builder
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                                itemCount: groupProvider.groups.length,
                                itemBuilder: (context, index) {
                                  groupProvider.group = groupProvider.groups[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 1.h), // Add spacing between cards
                                    child: _buildGroupCard(groupProvider.group!, groupProvider),
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

  Widget _buildGroupCard(Group group, GroupsProvider groupsProvider) {
    return InkWell(
      onTap: () {
        groupsProvider.showEventDetails(context, group);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(0.5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.grey.shade300),
            color: Colors.white, // Remove background image and use a plain background
          ),
          child: Row(
            children: [
              // Left Section: Icon or Image
              Container(
                width: 15.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // Placeholder background color
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/meeting.png',
                  height: 5.h,)
                ),
              ),
              SizedBox(width: 3.w),
              // Right Section: Group Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Group Name
                    Text(
                      group.name,
                      style: GoogleFonts.poppins(
                        fontSize: 2.h,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "GT01 (Gents)",
                      style: GoogleFonts.poppins(
                        fontSize: 1.6.h,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 2,
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
  }

}
