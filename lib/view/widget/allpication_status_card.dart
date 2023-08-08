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
    return Column(
      children: [
        Text(
          "$title",
          textAlign: TextAlign.center,
          style: batchtext2(AppColors.PrimaryBlackColor),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          "$subtitle",
          textAlign: TextAlign.center,
          maxLines: 4,
          style: batchtext1(AppColors.PrimaryBlackColor),
        )
      ],
    );
  }
}
