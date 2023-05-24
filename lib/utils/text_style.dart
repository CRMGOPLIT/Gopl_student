import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/constant.dart';

TextStyle H1TextStyle(Color? color) {
  return TextStyle(
      color: color ?? AppColors.PrimaryBlackColor,
      fontFamily: Constant.font_family_poppins,
      fontWeight: FontWeight.w500,
      fontSize: 26.sp);
}

TextStyle H2TextStyle(Color? color) {
  return TextStyle(
      color: color ?? AppColors.PrimaryBlackColor,
      fontFamily: Constant.font_family_poppins,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      fontSize: 16.sp);
}

TextStyle FieldTextStyle(Color? color) {
  return TextStyle(
      color: color ?? AppColors.PrimaryBlackColor,
      fontFamily: "Outfit",
      fontWeight: FontWeight.w600,
      fontSize: 12.sp);
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
      fontFamily: "Outfit",
      fontWeight: FontWeight.w800,
      height: 1.1,
      fontSize: 13.sp);
}

TextStyle Text2Regular(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: Constant.font_family_poppins,
      fontWeight: FontWeight.w400,
      letterSpacing: 1,
      height: 1.2,
      fontSize: 14.sp);
}

TextStyle OtpText(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: "Outfit",
      fontWeight: FontWeight.w600,
      height: 1,
      fontSize: 17.sp);
}

TextStyle btntext(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: Constant.font_poppins_bold,
      fontWeight: FontWeight.w500,
      height: 1.1,
      fontSize: 18.sp);
}

TextStyle hometext(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: Constant.font_poppins_bold,
      fontWeight: FontWeight.w500,
      height: 1.1,
      fontSize: 15.sp);
}

TextStyle batchtext1(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: "Outfit",
      fontWeight: FontWeight.w500,
      // height: 1,
      letterSpacing: 0.6,
      fontSize: 12.sp);
}

TextStyle batchtext2(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: "Outfit",
      fontWeight: FontWeight.w600,
      // height: 1.1,
      letterSpacing: 0.6,
      fontSize: 12.sp);
}

TextStyle location(Color? color) {
  return TextStyle(
      color: color ?? AppColors.TextRegularkColor,
      fontFamily: "Outfit",
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
      // height: 1.1,
      letterSpacing: 0.6,
      fontSize: 12.sp);
}

Widget MediumBottonWithoutIcon(
  String title,
  bool isEnable,
  Function onTap,
) {
  return GestureDetector(
    child: Ink(
      decoration: BoxDecoration(
          color: isEnable == false
              ? AppColors.PrimaryGreyColor
              : AppColors.PrimaryMainColor,
          borderRadius: BorderRadius.circular(4)),
      child: InkWell(
        onTap: isEnable == false
            ? () {}
            : () {
                onTap();
              },
        highlightColor:
            isEnable == false ? Colors.transparent : AppColors.PrimaryMainColor,
        borderRadius: BorderRadius.circular(4),
        autofocus: true,
        child: Container(
          height: 48,
          width: 92,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextRegular(AppColors.PrimaryWhiteColor),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
