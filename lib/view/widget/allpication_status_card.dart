import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

class ApplicationStatusCard extends StatelessWidget {
  String? title;
  String? subtitle;

  ApplicationStatusCard({Key? key, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.backgroungcolor,
          boxShadow: const [
            BoxShadow(
                offset: Offset(
                  5,
                  10,
                ),
                color: Colors.black26,
                blurRadius: 2.0,
                spreadRadius: 2.0),
            // BoxShadow(
            //     offset: Offset(
            //       -2,
            //       -5,
            //     ),
            //     color: Colors.black12,
            //     blurRadius: 2.0,
            //     spreadRadius: 2.0),
          ],
          borderRadius: BorderRadius.circular(10.sp)),
      child: Column(
        children: [
          Container(
            width: 80.w,
            child: Text(
              "$title",
              textAlign: TextAlign.center,
              style: FieldTextStyle(AppColors.PrimaryBlackColor),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 1.h,
            width: 70.w,
            color: AppColors.PrimaryBlackColor,
          ),
          Container(
            width: 80.w,
            child: Text(
              "$subtitle",
              textAlign: TextAlign.center,
              style: TextRegular(AppColors.PrimaryBlackColor),
            ),
          ),
        ],
      ),
    );
  }
}
