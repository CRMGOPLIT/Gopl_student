import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 320.w,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.PrimaryMainColor,
          textStyle: OtpText(AppColors.PrimaryWhiteColor),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          shadowColor: AppColors.PrimaryGreyColor,
        ),
      ),
    );
  }
}
