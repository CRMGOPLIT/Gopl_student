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
    return Container(
      height: 50.h,
      width: 360.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff143C79),
              Color(0xff2A67C5),
            ],
          )),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            textStyle: OtpText(AppColors.PrimaryWhiteColor),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30.r)),
            shadowColor: Colors.transparent,
            elevation: 10),
        child: Text(title.toUpperCase(),
            style: btntext(
              AppColors.PrimaryWhiteColor,
            )),
      ),
    );
  }
}

class ButtonPrimary2 extends StatelessWidget {
  const ButtonPrimary2({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 360.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff143C79),
              Color(0xff2A67C5),
            ],
          )),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            textStyle: OtpText(AppColors.PrimaryWhiteColor),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30.r)),
            shadowColor: Colors.transparent,
            elevation: 10),
        child: Text(title,
            style: batchtext2(
              AppColors.PrimaryWhiteColor,
            )),
      ),
    );
  }
}

  // Container(
              //   height: 60.h,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10.sp),
              //       gradient: const LinearGradient(
              //         begin: Alignment.centerLeft,
              //         end: Alignment.centerRight,
              //         colors: [
              //           Color(0xff143C79),
              //           Color(0xff2A67C5),
              //         ],
              //       )),
              //   child: const Center(
              //     child: Text(
              //       'Next',
              //       style: TextStyle(
              //         fontSize: 28.0,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),