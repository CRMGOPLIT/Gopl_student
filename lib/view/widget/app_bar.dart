import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

// ignore: must_be_immutable
class AppBarCustom extends StatelessWidget {
  String? title;
  Function? onpress;
  AppBarCustom({Key? key, this.title, this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.PrimaryMainColor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      leading: GestureDetector(
        onTap: () {
          onpress!();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.PrimaryWhiteColor,
          size: 20.sp,
        ),
      ),
      centerTitle: true,
      title: Text(
        title!,
        style: btntext(AppColors.PrimaryWhiteColor),
      ),
    );
  }
}
