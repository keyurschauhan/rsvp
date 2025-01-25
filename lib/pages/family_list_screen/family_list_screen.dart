import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../data_models/family_mem_list_data_model.dart';
import '../../provider/family_list_provider.dart';
import '../../utils/sharedprefrence_utils.dart';

class FamilyListScreen extends StatefulWidget {
  const FamilyListScreen({super.key});

  @override
  State<FamilyListScreen> createState() => _FamilyListScreenState();
}

class _FamilyListScreenState extends State<FamilyListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var familyListProvider = Provider.of<FamilyListProvider>(context,listen: false);

    SharedPreferenceUtill.getLoginResponse().then((value) {
      if (value != null) {
        setState(() {
          familyListProvider.loginDataModel = value;
        });
      }
    }).whenComplete(
          () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          familyListProvider.getFamilyMemberList(context);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    var familyListProvider = Provider.of<FamilyListProvider>(context);

    return Scaffold(
      backgroundColor: familyListProvider.myAppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section
            Stack(
              children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: familyListProvider.myAppColors.white,
                  ),
                ),
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: familyListProvider.myAppColors.primaryGolden,
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
                          IconButton(
                              onPressed: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                            },
                              icon: Icon(Icons.arrow_back_rounded,
                            color: Colors.white,size: 4.h,)),
                          Spacer(),
                          Text(
                            "FAMILY",
                            style: familyListProvider.myAppTextStyle.quickSandMedium(
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
                    color: familyListProvider.myAppColors.primaryGolden.withOpacity(1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(60),
                      //topLeft: Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                    height: 85.h,
                    decoration: BoxDecoration(
                      color: familyListProvider.myAppColors.white,
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
                          Padding(
                            padding: EdgeInsets.only(top: 1.5.h),
                            child: Text(
                              "Family Members",
                              style: GoogleFonts.poppins(
                                fontSize: 2.5.h,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left, // Align text to the left
                            ),
                          ),

                          SizedBox(
                            height: 1.h,
                          ),

                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true, // Prevent scrolling conflicts with the parent
                              itemCount: familyListProvider.familyMemberList.length,
                              itemBuilder: (context, index) {
                                FamilyMembers member = familyListProvider.familyMemberList[index];
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
                                      padding: EdgeInsets.only(top: 1.h, bottom: 1.h, right: 4.w,left: 2.w),
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Profile Picture or Initials
                                          Container(
                                            width: 6.h,
                                            height: 6.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: familyListProvider.myAppColors.primaryGolden, // Border color
                                                width: 2.0, // Border width
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius: 3.h,
                                              backgroundColor: familyListProvider.myAppColors.primaryGolden.withOpacity(0.3),
                                              backgroundImage: member.profileImage != null && member.profileImage!.isNotEmpty
                                                  ? NetworkImage(member.profileImage!)
                                                  : null,
                                              child: member.profileImage == null || member.profileImage!.isEmpty
                                                  ? Text(
                                                member.name![0].toUpperCase(),
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
                                          // Member Details
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Member Name
                                                Text(
                                                  member.name ?? "-",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 1.8.h,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(0xFF7f6400),
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
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
