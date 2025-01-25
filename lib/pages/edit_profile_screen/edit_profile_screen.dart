import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/provider/edit_profile_provider.dart';
import 'package:my_project/widgets/widget_utils.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    var editProfileProvider = Provider.of<EditProfileProvider>(context,listen: false);
    super.initState();
    editProfileProvider.getFromSharedPreference();
    editProfileProvider.itsNumber = editProfileProvider.loginDataModel!.data!.user!.itsNumber;
    editProfileProvider.userName = editProfileProvider.loginDataModel!.data!.user!.userName;
  }

  @override
  Widget build(BuildContext context) {
    var editProfileProvider = Provider.of<EditProfileProvider>(context);
    return Scaffold(
      backgroundColor: editProfileProvider.myAppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header Section
            Stack(
              children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: editProfileProvider.myAppColors.white,
                  ),
                ),
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: editProfileProvider.myAppColors.primaryGolden,
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
                            "EDIT PROFILE",
                            style: editProfileProvider.myAppTextStyle.quickSandMedium(
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
                    color: editProfileProvider.myAppColors.primaryGolden
                        .withOpacity(1),
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
                      color: editProfileProvider.myAppColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        //topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 15.h),
                      child: Form(
                        child: Column(

                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                editProfileProvider.showAnimatedDialog(
                                  context,
                                  AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    backgroundColor: editProfileProvider.myAppColors.white,
                                    contentPadding: EdgeInsets.zero,
                                    content: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              //Icon(Icons.photo_camera_back, color: const Color(0xFF7f6400), size: 3.h),
                                              Text(
                                                "Select Picture",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 2.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.close, color: Colors.black54, size: 3.h),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                         // SizedBox(height: 1.h),
                                          Divider(thickness: 1, color: editProfileProvider.myAppColors.primaryGolden),
                                         SizedBox(height: 1.5.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  await editProfileProvider.selectImageFromCamera();
                                                },
                                                child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 4.h,
                                                      backgroundColor: Colors.grey.withOpacity(0.1),
                                                      child: Icon(Icons.camera_alt, color: const Color(0xFF7f6400), size: 3.h),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Text(
                                                      "Camera",
                                                      style: GoogleFonts.poppins(fontSize: 2.h, color: Colors.black87),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  await editProfileProvider.selectImageFromGallery();
                                                },
                                                child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 4.h,
                                                      backgroundColor: Colors.grey.withOpacity(0.1),
                                                      child: Icon(Icons.photo_library, color: const Color(0xFF7f6400), size: 3.h),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Text(
                                                      "Gallery",
                                                      style: GoogleFonts.poppins(fontSize: 2.h, color: Colors.black87),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundColor: editProfileProvider.selectedImageFile != null ||
                                            editProfileProvider.loginDataModel?.data?.user?.profileImg != null
                                            ? editProfileProvider.myAppColors.primaryGolden.withOpacity(0.5)
                                            : Colors.grey.shade300,
                                        child: ClipOval(
                                          child: editProfileProvider.selectedImageFile != null
                                              ? Image.file(
                                            editProfileProvider.selectedImageFile!,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          )
                                              : (editProfileProvider.loginDataModel?.data?.user?.profileImg != null
                                              ? Image.network(
                                            editProfileProvider.loginDataModel!.data!.user!.profileImg!,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  color: editProfileProvider.myAppColors.white,
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                      loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 50,
                                              );
                                            },
                                          )
                                              : Image.asset(
                                            "assets/images/pro.jpg",
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          )),
                                        ),
                                      ),
                                      if (editProfileProvider.loginDataModel?.data?.user?.profileImg == null &&
                                          editProfileProvider.selectedImageFile == null)
                                        Icon(
                                          Icons.camera_alt,
                                          size: 30,
                                          color: editProfileProvider.myAppColors.primaryGolden,
                                        ),
                                    ],
                                  ),

                                  SizedBox(height: 2.h),
                                  Text(
                                    "Tap to change profile picture",
                                    style: editProfileProvider.myAppTextStyle.quickSandRegular(
                                      size: 1.8,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),

                            Card(
                              elevation: 5, // Add elevation for shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                              ),
                              child: TextFormField(
                                readOnly: true, // Make the field read-only
                                initialValue: editProfileProvider.itsNumber,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "ITS Number",
                                  labelStyle: editProfileProvider.myAppTextStyle.quickSandRegular(
                                    color: Colors.grey,
                                    size: 0.2.h,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: editProfileProvider.myAppColors.primaryGolden,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: editProfileProvider.myAppColors.primaryGolden,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: editProfileProvider.myAppColors.primaryGolden,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),

                            // User Name Field
                            Card(
                              elevation: 5, // Add elevation for shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                              ),
                              child: TextFormField(
                                readOnly: true, // Make the field read-only
                                initialValue: editProfileProvider.userName ?? "-",
                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "User Name",
                                  labelStyle: editProfileProvider.myAppTextStyle.quickSandRegular(
                                    color: Colors.grey,
                                    size: 0.2.h,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: editProfileProvider.myAppColors.primaryGolden,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: editProfileProvider.myAppColors.primaryGolden,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: editProfileProvider.myAppColors.primaryGolden,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),

                            Card(
                              elevation: 5, // Add elevation for shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners for the card
                              ),
                              child: TextFormField(
                                controller: editProfileProvider.nameController,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  labelStyle: editProfileProvider.myAppTextStyle
                                      .quickSandRegular(
                                      color: Colors.grey, size: 0.2.h),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: editProfileProvider
                                        .myAppColors.primaryGolden,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: editProfileProvider
                                            .myAppColors.primaryGolden,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: editProfileProvider
                                            .myAppColors.primaryGolden),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),

                            Spacer(),

                            // Sign Up Button
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: InkWell(
                                onTap: () {
                                  if(editProfileProvider.nameController.text.isEmpty){
                                    WidgetUtil().showToastError(context, "Please Enter Name");
                                    return;
                                  }
                                  editProfileProvider.registerBtnPressed(context);
                                  },
                                child: Card(
                                  elevation: 5, // Add elevation for shadow
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        15), // Rounded corners for the card
                                  ),
                                  child: Container(
                                    height: 6.h,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: editProfileProvider
                                                .myAppColors.primaryGolden
                                                .withOpacity(0.3), // Shadow color
                                            spreadRadius: 3,
                                            blurRadius: 8,
                                            offset: const Offset(
                                                0, 3), // Shadow position
                                          ),
                                        ],
                                        color: editProfileProvider
                                            .myAppColors.primaryGolden,
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Center(
                                      child: editProfileProvider.isLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              "Update",
                                              style: editProfileProvider
                                                  .myAppTextStyle
                                                  .quickSandMedium(
                                                      size: 2.5,
                                                      color: Colors.white),
                                            ),
                                    ),
                                  ),
                                ),
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
}
