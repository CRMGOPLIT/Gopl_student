import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

// ignore: must_be_immutable
class ApplicationStatusCard extends StatelessWidget {
  String? title;
  String? subtitle;

  ApplicationStatusCard({Key? key, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 25.r, right: 25.r, top: 20.r, bottom: 20.r),
      margin: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          color: AppColors.backgroungcolor,
          boxShadow: const [
            BoxShadow(
                offset: Offset(
                  2,
                  2,
                ),
                color: Colors.black12,
                blurRadius: 1.0,
                spreadRadius: 0.0),
          ],
          borderRadius: BorderRadius.circular(10.sp)),
      child: Column(
        children: [
          SizedBox(
            width: 85.w,
            child: Text(
              "$title",
              textAlign: TextAlign.center,
              style: batchtext2(AppColors.PrimaryBlackColor),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.r),
            height: 1.h,
            width: 70.w,
            color: AppColors.PrimaryBlackColor,
          ),
          subtitle.toString().length <= 25
              ? SizedBox(
                  width: 80.w,
                  child: Text(
                    //overflow: TextOverflow.ellipsis,
                    "$subtitle",
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    style: batchtext1(AppColors.PrimaryBlackColor),
                  ),
                )
              : SizedBox(
                  width: 80.w,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    "$subtitle",
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: batchtext1(AppColors.PrimaryBlackColor),
                  ),
                )
        ],
      ),
    );
  }
}
