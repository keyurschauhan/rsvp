import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../data_models/user_event_list_data_model.dart';
import '../../provider/home_provider.dart';
import '../../utils/sharedprefrence_utils.dart';
import '../../widgets/home_page_details_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userHomeProvider = Provider.of<HomeProvider>(context,listen: false);
    userHomeProvider.getCurrentLocation();

    SharedPreferenceUtill.getLoginResponse().then((value) {
      if (value != null) {
        setState(() {
          userHomeProvider.loginDataModel = value;
        });
      }
    }).whenComplete(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          userHomeProvider.getEventListForUser(context);
        });
      },
    );
  }



  @override
  Widget build(BuildContext context) {

    var userHomeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: userHomeProvider.myAppColors.white,
      drawer: _buildCustomDrawer(userHomeProvider),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Header with Drawer Icon and Title
            Stack(
              children: [
                Container(
                  height: 15.h,
                  decoration: const BoxDecoration(
                    //color: Color(0xFFFAE7B5),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFAE7B5), // Start color
                        Color(0xFFF3D89A),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                ),
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: userHomeProvider.myAppColors.primaryGolden,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.menu,
                                color: Colors.white, size: 7.w),
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                          ),
                          Spacer(), // Adds space between IconButton and Text
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Text(
                              "HOME",
                              style: userHomeProvider.myAppTextStyle
                                  .quickSandMedium(
                                      size: 3, color: Colors.white),
                            ),
                          ),
                          Spacer(), // Adds space after Text to keep it centered
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
                    color: userHomeProvider.myAppColors.primaryGolden,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(60),
                    ),
                  ),
                ),
                Container(
                  height: 85.h,
                  decoration: const BoxDecoration(
                    // color: Color(0xFFFAE7B5),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFAE7B5), // Start color
                        Color(0xFFF3D89A),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 4.w, top: 0.h, right: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              userHomeProvider.getDayOfWeek(),
                              style: userHomeProvider.myAppTextStyle
                                  .quickSandMedium(
                                      size: 2.5, color: Colors.black54),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${userHomeProvider.getDayOfMonth()}",
                                  style: userHomeProvider.myAppTextStyle
                                      .quickSandMedium(
                                    size: 5,
                                    color: const Color(0xFF7f6400),
                                  ),
                                ),
                                Text(
                                  userHomeProvider.getMonthAndYear(),
                                  style: userHomeProvider.myAppTextStyle
                                      .quickSandMedium(
                                          size: 2, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 1.h,),

                      const Divider(
                        color: Color(0xFF7f6400),
                        // color: userHomeProvider.myAppColors.primaryGolden,
                      ),
                      Container(
                        height: 4.h,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFAE7B5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 0.6.h),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Color(0xFF7f6400), size: 5.w),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  SizedBox(
                                    width: 80.w,
                                    child: Text(
                                      userHomeProvider.currentLocation,
                                      overflow: TextOverflow.ellipsis,
                                      style: userHomeProvider.myAppTextStyle
                                          .quickSandMedium(
                                              size: 1.8, color: Colors.black54),
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(Icons.refresh,
                                      color: const Color(0xFF7f6400),
                                      size: 7.w),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (userHomeProvider.loginDataModel?.data?.isAdmin ==
                          0) ...[
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align heading to the start
                              children: [
                                // Heading
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 1.5.h, left: 5.w, right: 5.w),
                                  child: Text(
                                    "Events",
                                    style: GoogleFonts.poppins(
                                      fontSize: 2.5.h,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign
                                        .left, // Align text to the left
                                  ),
                                ),
                                // GridView.builder
                                userHomeProvider.isLoading
                                    ?  Expanded(
                                      child: Center(
                                          child: CircularProgressIndicator(color: userHomeProvider.myAppColors.primaryGolden,)),
                                    )
                                    : Expanded(
                                        child: GridView.builder(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w, vertical: 1.h),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2, // Number of cards per row
                                            crossAxisSpacing: 3.w, // Spacing between columns
                                            mainAxisSpacing: 2.h, // Spacing between rows
                                            childAspectRatio: 1.3, // Aspect ratio of the card
                                          ),
                                          itemCount: userHomeProvider.eventList.length,
                                          itemBuilder: (context, index) {
                                            userHomeProvider.events = userHomeProvider.eventList[index];
                                            return _buildEventCard(userHomeProvider.events!, userHomeProvider);
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: Container(
                            width: double.maxFinite,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 3.h, left: 2.w, right: 2.w),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 2.5.w),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.start,
                                    runSpacing: 20,
                                    spacing: 15,
                                    children: [
                                      //if(userHomeProvider.loginDataModel.data.permission.eventAdd)
                                      HomePageDetailsWidget(
                                          value: "Events",
                                          image: "assets/images/groups.png",
                                          isActive: true,
                                          onTap: () {
                                            userHomeProvider
                                                .eventGridTap(context);
                                          }),
                                      HomePageDetailsWidget(
                                        value: "Groups",
                                        isActive: true,
                                        image: "assets/images/meeting.png",
                                        onTap: () {
                                          userHomeProvider
                                              .groupsGridTap(context);
                                        },
                                      ),
                                      // HomePageDetailsWidget(
                                      //   value: "Family",
                                      //   image: "assets/images/family.png",
                                      //   isActive: true,
                                      //   onTap: () {
                                      //
                                      //   },
                                      // ),

                                      HomePageDetailsWidget(
                                        value: "Individual Scanning",
                                        image: "assets/images/face-scan.png",
                                        isActive: true,
                                        onTap: () {
                                          userHomeProvider
                                              .individualScanGridTap(context);
                                        },
                                      ),

                                      HomePageDetailsWidget(
                                        value: "Group \nScanning",
                                        isActive: true,
                                        image: "assets/images/qr-code.png",
                                        onTap: () {
                                          userHomeProvider
                                              .groupScanGridTap(context);
                                        },
                                      ),

                                      HomePageDetailsWidget(
                                        value: "Reports",
                                        image: "assets/images/reports.png",
                                        isActive: true,
                                        onTap: () {
                                          userHomeProvider
                                              .reportGridTap(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(Events event, HomeProvider homeProvider) {
    return InkWell(
      onTap: () {
        //log("LIST :: ${event.toJson()}");
        //homeProvider.onCardTap(context);
        homeProvider.showEventDetails(context, event);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/card_bgg.png"),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.grey.shade300),
          ),
          child: Stack(
            children: [
              // Positioned Column for Name and Date
              Positioned(
                bottom: 1.h,
                right: 1.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 1.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Event Name
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Image.asset(
                          "assets/images/groups.png",
                          height: 10.h,
                          width: 10.w,
                          //color: const Color(0xFF6b9e3a),
                        ),
                      ),
                      Container(
                        width: 35.w,
                        //color: Colors.black54,
                        child: Text(
                          event.eventName ?? "-",
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize:
                                1.8.h, // Adjust font size for smaller cards
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF7f6400),
                          ),
                        ),
                      ),
                      //SizedBox(height: 0.3.h),
                      // Event Date with Icon
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 1.5.h,
                            color: const Color(0xFF7f6400),
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            event.eventDate ?? "-",
                            style: GoogleFonts.poppins(
                              fontSize: 1.2.h,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerRow({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required Color color,
    Color textColor = Colors.black,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 1.8.h,
                  color: textColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomDrawer(HomeProvider homeProvider) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drawer Header remains the same
          Container(
            height: 17.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  homeProvider.myAppColors.primaryGolden.withOpacity(0.7),
                  homeProvider.myAppColors.primaryGolden,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 5.h, left: 4.w, right: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: homeProvider.loginDataModel?.data?.user?.profileImg != null
                                ? homeProvider.myAppColors.primaryGolden.withOpacity(0.5)
                                : Colors.grey.shade300,
                            child: ClipOval(
                              child: homeProvider.loginDataModel?.data?.user?.profileImg != null
                                  ? Image.network(
                                homeProvider.loginDataModel!.data!.user!.profileImg!,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child; // Image loaded successfully
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                            (loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                        color: homeProvider.myAppColors.white,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "assets/images/pro.jpg",
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                  );
                                },
                              )
                                  : Image.asset(
                                "assets/images/pro.jpg",
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                          if (homeProvider.loginDataModel?.data?.user?.profileImg == null)
                            Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: homeProvider.myAppColors.primaryGolden,
                            ),
                        ],
                      ),
                      SizedBox(width: 1.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            homeProvider.loginDataModel!.data!.user!.name!,
                            style: GoogleFonts.poppins(
                                fontSize: 2.h,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            homeProvider.loginDataModel!.data!.user!.itsNumber!,
                            style: GoogleFonts.poppins(
                                fontSize: 1.5.h,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(color: homeProvider.myAppColors.primaryGolden, height: 2.h),

          // Replacing ListTile with Rows
          _buildDrawerRow(
            icon: Icons.group,
            text: "Edit Profile",
            onTap: () {
              homeProvider.editProfileTap(context);
              // Navigate to Calendar screen
            },
            color: homeProvider.myAppColors.primaryGolden,
          ),
          _buildDrawerRow(
            icon: Icons.family_restroom,
            text: "Family",
            onTap: () {
              homeProvider.familyTap(context);
              // Navigate to Communication screen
            },
            color: homeProvider.myAppColors.primaryGolden,
          ),
          Divider(
            color: homeProvider.myAppColors.primaryGolden,
          ),
          _buildDrawerRow(
            icon: Icons.logout,
            text: "Logout",
            onTap: () {
              SharedPreferenceUtill().clearLogin().whenComplete(() {
                homeProvider.mobileNavigationManager.goToLogInPage(context);
              });
            },
            color: homeProvider.myAppColors.primaryGolden,
          ),
          // _buildDrawerRow(
          //   icon: Icons.group,
          //   text: "Groups",
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Navigate to Calendar screen
          //   },
          //   color: homeProvider.myAppColors.primaryGolden,
          // ),
          // _buildDrawerRow(
          //   icon: Icons.event_available,
          //   text: "Events",
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Navigate to Mumineen Opportunities screen
          //   },
          //   color: homeProvider.myAppColors.primaryGolden,
          // ),
          // _buildDrawerRow(
          //   icon: Icons.adf_scanner,
          //   text: "Group Scanning",
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Navigate to Mumineen Opportunities screen
          //   },
          //   color: homeProvider.myAppColors.primaryGolden,
          // ),
          // _buildDrawerRow(
          //   icon: Icons.document_scanner,
          //   text: "Individual Scanning",
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Navigate to Mumineen Opportunities screen
          //   },
          //   color: homeProvider.myAppColors.primaryGolden,
          // ),
          // _buildDrawerRow(
          //   icon: Icons.report,
          //   text: "Reports",
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Navigate to Reports screen
          //   },
          //   color: homeProvider.myAppColors.primaryGolden,
          // ),

          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 3.h),
            child: Column(
              children: [
                Text(
                  "Powered by",
                  style: GoogleFonts.robotoMono(
                    fontSize: 1.5.h,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "Versatile International",
                  style: GoogleFonts.robotoMono(
                    fontSize: 1.6.h,
                    fontWeight: FontWeight.w800,
                    color: homeProvider.myAppColors.primaryGolden,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
