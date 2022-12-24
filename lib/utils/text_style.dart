import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/constant.dart';

TextStyle H1TextStyle(Color? color) {
  return TextStyle(
      color: color ?? AppColors.PrimaryBlackColor,
      fontFamily: Constant.font_family_sans,
      fontWeight: FontWeight.w700,
      fontSize: 22.sp);
}

TextStyle H2TextStyle(Color? color) {
  return TextStyle(
      color: color ?? AppColors.PrimaryBlackColor,
      fontFamily: Constant.font_family_sans,
      fontWeight: FontWeight.w600,
      height: 1.1,
      fontSize: 26);
}

TextStyle TextRegular(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: Constant.font_family_sans,
      fontWeight: FontWeight.w400,
      height: 1.1,
      fontSize: 12.sp);
}

TextStyle Text2Regular(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: Constant.font_family_sans,
      fontWeight: FontWeight.w600,
      height: 1.1,
      fontSize: 16.sp);
}

TextStyle OtpText(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: Constant.font_family_sans,
      fontWeight: FontWeight.w600,
      height: 1.1,
      fontSize: 20.sp);
}
