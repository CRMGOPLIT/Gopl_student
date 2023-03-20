// import 'package:flutter/material.dart';
// import 'package:global_student/utils/color.dart';


// class ToastHelper {
//   /**
//    * This function will return you a toast message.
//    * [message] pass message which you want to show on toast.
//    * [textColor] pass text color.
//    * [toastLength] pass toast length.
//    * [backgroundColor] pass toast backgroud color.
//    * [gravity] pass Toast gravity.
//    * [timeInSecForIosWeb] pass time in sescond for IOs and Web app.
//    */
//   void showErrorToast(
//       {required String message,
//       Color? textColor,
//       double? fontSize,
//       Toast? toastLength,
//       Color? backgroundColor,
//       ToastGravity? gravity,
//       dynamic timeInSecForIosWeb}) {
//     Fluttertoast.showToast(
//         msg: 'X   ' + message,
//         toastLength: toastLength ?? Toast.LENGTH_SHORT,
//         gravity: gravity ?? ToastGravity.SNACKBAR,
//         timeInSecForIosWeb: timeInSecForIosWeb ?? 1,
//         backgroundColor: backgroundColor ?? Colors.red,
//         textColor: textColor ?? Colors.white,
//         fontSize: fontSize ?? 14.0);
//   }

//   /**
//    * This function will return you a toast message.
//    * [message] pass message which you want to show on toast.
//    * [textColor] pass text color.
//    * [toastLength] pass toast length.
//    * [backgroundColor] pass toast backgroud color.
//    * [gravity] pass Toast gravity.
//    * [timeInSecForIosWeb] pass time in sescond for IOs and Web app.
//    */
//   void showToast(
//       {required String message,
//       Color? textColor,
//       double? fontSize,
//       Toast? toastLength,
//       Color? backgroundColor,
//       ToastGravity? gravity,
//       dynamic timeInSecForIosWeb}) {
//     Fluttertoast.showToast(
//         msg: message,
//         toastLength: toastLength ?? Toast.LENGTH_SHORT,
//         gravity: gravity ?? ToastGravity.SNACKBAR,
//         timeInSecForIosWeb: timeInSecForIosWeb ?? 1,
//         backgroundColor:
//             AppColors.PrimaryMainColor, // ?? AppColors.PrimaryColor,
//         textColor: textColor ?? Colors.white,
//         fontSize: fontSize ?? 14.0);
//   }
// }
