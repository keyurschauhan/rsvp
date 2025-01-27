import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../data_models/user_event_list_data_model.dart';
import '../../provider/home_provider.dart';
import '../../utils/sharedprefrence_utils.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var eventProvider = Provider.of<EventProvider>(context,listen: false);

    SharedPreferenceUtill.getLoginResponse().then((value) {
      if (value != null) {
        setState(() {
          eventProvider.loginDataModel = value;
        });
      }
    }).whenComplete(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        eventProvider.getEventList(context);
      });
    },);
  }

  @override
  Widget build(BuildContext context) {
    var eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      backgroundColor: eventProvider.myAppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Header with Drawer Icon and Title
            Stack(
              children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: eventProvider.myAppColors.white,
                  ),
                ),
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: eventProvider.myAppColors.primaryGolden,
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
                            "EVENTS",
                            style: eventProvider.myAppTextStyle.quickSandMedium(
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
                    color: eventProvider.myAppColors.primaryGolden.withOpacity(1),
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
                      color: eventProvider.myAppColors.white,
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
                          crossAxisAlignment: CrossAxisAlignment.start, // Align heading to the start
                          children: [
                            // Heading
                            Padding(
                              padding: EdgeInsets.only(top: 0.h,left: 2.w,right: 1.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Events",
                                    style: GoogleFonts.poppins(
                                      fontSize: 3.h,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.left, // Align text to the left
                                  ),
                                  if(eventProvider.loginDataModel?.data!.permission!.eventAdd == "Yes")
                                  FloatingActionButton(
                                    backgroundColor: eventProvider.myAppColors.primaryGolden,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50), // Ensures the button is circular
                                    ),
                                    onPressed: (){
                                      eventProvider.addEventTap(context);
                                    },
                                    child: Icon(Icons.add,color: Colors.white,weight: 10,size: 3.5.h,),)
                                ],
                              ),
                            ),
                            // GridView.builder
                            Expanded(
                              child: GridView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 2.h),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of cards per row
                                  crossAxisSpacing: 3.w, // Spacing between columns
                                  mainAxisSpacing: 2.h, // Spacing between rows
                                  childAspectRatio: 1.3, // Aspect ratio of the card
                                ),
                                itemCount: eventProvider.eventList.length,
                                itemBuilder: (context, index) {
                                  //eventProvider.event = eventProvider.eventList[index];
                                  return _buildEventCard(eventProvider.eventList[index], eventProvider);
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

  Widget _buildEventCard(Events event,EventProvider eventProvider) {
    return InkWell(
      onTap: () {
        //log("LIST :: ${event.toJson()}");
        //homeProvider.onCardTap(context);
        eventProvider.showEventDetails(context, event);
      },
      child:Card(
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
                            fontSize: 1.8.h, // Adjust font size for smaller cards
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


}
