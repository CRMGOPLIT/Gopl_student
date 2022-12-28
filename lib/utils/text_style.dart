import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/constant.dart';

TextStyle H1TextStyle(Color? color) {
  return TextStyle(
      color: color ?? AppColors.PrimaryBlackColor,
      fontFamily: Constant.font_family_poppins,
      fontWeight: FontWeight.bold,
      fontSize: 26.sp);
}

TextStyle H2TextStyle(Color? color) {
  return TextStyle(
      color: color ?? AppColors.PrimaryBlackColor,
      fontFamily: Constant.font_family_poppins,
      fontWeight: FontWeight.bold,
      fontSize: 16.sp);
}

TextStyle FieldTextStyle(Color? color) {
  return TextStyle(
      color: color ?? AppColors.PrimaryBlackColor,
      fontFamily: Constant.font_family_poppins,
      fontWeight: FontWeight.w600,
      fontSize: 14.sp);
}

// TextStyle H2TextStyle(Color? color) {
//   return TextStyle(
//       color: color ?? AppColors.PrimaryBlackColor,
//       fontFamily: Constant.font_poppins_bold,
//       fontWeight: FontWeight.w600,
//       height: 1.1,
//       fontSize: 26);
// }

TextStyle TextRegular(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: Constant.font_poppins_bold,
      fontWeight: FontWeight.w400,
      height: 1.1,
      fontSize: 12.sp);
}

TextStyle Text2Regular(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: Constant.font_family_poppins,
      fontWeight: FontWeight.w400,
      height: 1.1,
      fontSize: 16.sp);
}

TextStyle OtpText(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: Constant.font_poppins_bold,
      fontWeight: FontWeight.w600,
      height: 1.1,
      fontSize: 20.sp);
}
