import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_project/utils/sharedprefrence_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/event_provider.dart';
import '../../widgets/widget_utils.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({required this.eventProvider,super.key});

  final EventProvider eventProvider;

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferenceUtill.getLoginResponse().then((value) {
      if (value != null) {
        setState(() {
          widget.eventProvider.loginDataModel = value;
        });
      }
    }).whenComplete(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.eventProvider.getEventList(context);
      });
    },);
  }

  @override
  Widget build(BuildContext context) {
    var eventProvider = widget.eventProvider;

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
                            "ADD EVENT",
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
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                          // Event Name
                          _buildInputCard(
                          icon: Icons.event,
                          label: "Event Name",
                          controller: eventProvider.eventNameController,
                        ),
                        SizedBox(height: 2.h),

                        // Event Location
                        _buildInputCard(
                          icon: Icons.location_on,
                          label: "Event Location",
                          controller: eventProvider.eventLocationController,
                        ),
                        SizedBox(height: 2.h),

                        // Event Date
                        _buildInputCard(
                          icon: Icons.calendar_today,
                          label: "Event Date",
                          controller: eventProvider.eventDateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: eventProvider.myAppColors.primaryGolden, // Header background color
                                    hintColor: eventProvider.myAppColors.primaryGolden, // Selected date color
                                    colorScheme: ColorScheme.light(
                                      primary: eventProvider.myAppColors.primaryGolden, // Header text and selected date color
                                      onPrimary: Colors.white, // Text color on primary color
                                      onSurface: Colors.black, // Default text color
                                    ),
                                    dialogBackgroundColor: eventProvider.myAppColors.white, // Dialog background color
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: eventProvider.myAppColors.primaryGolden, // Button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (selectedDate != null) {
                              TimeOfDay? selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        secondary: eventProvider.myAppColors.primaryGolden,
                                        primaryContainer: eventProvider.myAppColors.primaryGolden,
                                        primary: eventProvider.myAppColors.primaryGolden, // Header and selected time color
                                        onSurface: Colors.black, // Default text color
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (selectedTime != null) {
                                final DateTime fullDateTime = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );

                                eventProvider.eventDateController.text =
                                "${fullDateTime.toLocal().toString().split(' ')[0]} ${selectedTime.format(context)}";
                                setState(() {});
                              }
                            }
                          },
                        ),
                        SizedBox(height: 2.h),

                            // Event Last Date
                            _buildInputCard(
                              icon: Icons.calendar_today,
                              label: "Event Last Editable Date",
                              controller: eventProvider.eventLastEditableDateController,
                              readOnly: true,
                              filledColor: eventProvider.eventDateController.text.isNotEmpty ? Colors.white : Colors.grey.shade300,
                              onTap: eventProvider.eventDateController.text.isNotEmpty ? () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: eventProvider.eventDateController.text.isNotEmpty
                                      ? DateFormat("yyyy-MM-dd HH:mm").parse(eventProvider.eventDateController.text)
                                      : DateTime(2100),
                                  builder: (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        primaryColor: eventProvider.myAppColors.primaryGolden, // Header background color
                                        hintColor: eventProvider.myAppColors.primaryGolden, // Selected date color
                                        colorScheme: ColorScheme.light(
                                          primary: eventProvider.myAppColors.primaryGolden, // Header text and selected date color
                                          onPrimary: Colors.white, // Text color on primary color
                                          onSurface: Colors.black, // Default text color
                                        ),
                                        dialogBackgroundColor: eventProvider.myAppColors.white, // Dialog background color
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: eventProvider.myAppColors.primaryGolden, // Button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (selectedDate != null) {
                                  TimeOfDay? selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            secondary: eventProvider.myAppColors.primaryGolden,
                                            primaryContainer: eventProvider.myAppColors.primaryGolden,
                                            primary: eventProvider.myAppColors.primaryGolden, // Header and selected time color
                                            onSurface: Colors.black, // Default text color
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );

                                  if (selectedTime != null) {
                                    final DateTime fullDateTime = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                    );

                                    eventProvider.eventLastEditableDateController.text =
                                    "${fullDateTime.toLocal().toString().split(' ')[0]} ${selectedTime.format(context)}";
                                  }
                                }
                              } : null,
                            ),
                            SizedBox(height: 2.h),

                        // Event Description
                        _buildInputCard(
                          icon: Icons.description,
                          label: "Event Description",
                          controller: eventProvider.eventDescriptionController,
                          maxLines: 3,
                        ),
                        const Spacer(),

                        // Save Button
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: InkWell(
                            onTap: () {
                              String? errorMessage;

                              // Validate ITS Number
                              if (eventProvider.eventNameController.text.isEmpty) {
                                errorMessage = "Please Enter Event Name";
                              }
                              // Validate Name
                              else if (eventProvider.eventLocationController.text.isEmpty) {
                                errorMessage = "Please Enter Event Location";
                              }
                              // Validate Password
                              else if (eventProvider.eventDateController.text.isEmpty) {
                                errorMessage = "Please Select Event Date";
                              }

                              // Validate Password
                              else if (eventProvider.eventLastEditableDateController.text.isEmpty) {
                                errorMessage = "Please Select Last Editable Event Date";
                              }

                              if(eventProvider.eventDateController.text.isNotEmpty && eventProvider.eventLastEditableDateController.text.isNotEmpty){

                                DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm a');

                                DateTime selectedDate = inputFormat.parse(eventProvider.eventDateController.text);
                                DateTime selectedLastDate = inputFormat.parse(eventProvider.eventLastEditableDateController.text);

                                 eventProvider.formattedDate = inputFormat.format(selectedDate);
                                 eventProvider.formattedLastDate = inputFormat.format(selectedLastDate);
                              }

                              if (errorMessage != null) {
                                WidgetUtil().showToastError(context, errorMessage);
                              } else {
                                setState(() {
                                  eventProvider.addEventBtn(context);
                                });
                              }
                              // Save logic
                            },
                            child: Container(
                              height: 6.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: eventProvider.myAppColors.primaryGolden,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: eventProvider.myAppColors.primaryGolden
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
                                  style: eventProvider.myAppTextStyle.quickSandBold(
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
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    Color? filledColor,
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
          fillColor: filledColor ?? Colors.white,
          prefixIcon: Icon(
            icon,
            color: widget.eventProvider.myAppColors.primaryGolden,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.eventProvider.myAppColors.primaryGolden,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.eventProvider.myAppColors.primaryGolden,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

}
