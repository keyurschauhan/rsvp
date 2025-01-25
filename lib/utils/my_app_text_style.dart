// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// class MyAppTextStyle {
//
//   TextStyle quickSandMedium({double? size, Color? color}) {
//     return GoogleFonts.quicksand(
//         fontSize: size?.h ?? 10,
//         fontWeight: FontWeight.w500,
//         color: color ?? Colors.white);
//   }
//
//   TextStyle quickSandBold({double? size, Color? color}) {
//     return GoogleFonts.quicksand(
//       color: color,
//       fontWeight: FontWeight.bold,
//       fontSize: size?.h ?? 10,
//     );
//   }
//
//   TextStyle quickSandRegular({double? size, Color? color}) {
//     return GoogleFonts.quicksand(
//       color: color,
//       fontWeight: FontWeight.w400,
//       fontSize:size?.h ?? 10,
//     );
//   }
//
//   TextStyle quickSandLight({double? size, Color? color}) {
//     return GoogleFonts.quicksand(
//       color: color,
//       fontWeight: FontWeight.w300,
//       fontSize: size?.h ?? 10,
//     );
//   }
//
//   TextStyle ubuntuMedium({double? size, Color? color}) {
//     return GoogleFonts.ubuntu(
//       color: color,
//       fontSize: size?.h ?? 10,
//       fontWeight: FontWeight.w500,
//     );
//   }
//
//   TextStyle ubuntuBold({double? size, Color? color}) {
//     return GoogleFonts.ubuntu(
//       color: color,
//       fontSize: size?.h ?? 10,
//       fontWeight: FontWeight.bold,
//     );
//   }
//
//   TextStyle ubuntuRegular({double? size, Color? color}) {
//     return GoogleFonts.ubuntu(
//       color: color,
//       fontWeight: FontWeight.w400,
//       fontSize: size?.h ?? 10,
//     );
//   }
//
//   TextStyle ubuntuLight({double? size, Color? color}) {
//     return GoogleFonts.ubuntu(
//       color: color,
//       fontWeight: FontWeight.w300,
//       fontSize: size?.h ?? 10,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyAppTextStyle {
  TextStyle quickSandMedium({double? size, Color? color}) {
    return TextStyle(
      fontSize: size?.h ?? 10,
      fontWeight: FontWeight.w500,
      color: color ?? Colors.white,
      fontFamily: 'Poppins',
    );
  }

  TextStyle quickSandBold({double? size, Color? color}) {
    return TextStyle(
      fontSize: size?.h ?? 10,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
      fontFamily: 'Poppins',
    );
  }

  TextStyle quickSandRegular({double? size, Color? color}) {
    return TextStyle(
      fontSize: size?.h ?? 10,
      fontWeight: FontWeight.w400,
      color: color ?? Colors.white,
      fontFamily: 'Poppins',
    );
  }

  TextStyle quickSandLight({double? size, Color? color}) {
    return TextStyle(
      fontSize: size?.h ?? 10,
      fontWeight: FontWeight.w300,
      color: color ?? Colors.white,
      fontFamily: 'Poppins',
    );
  }
}