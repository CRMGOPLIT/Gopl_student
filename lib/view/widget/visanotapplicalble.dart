import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';

import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';
import 'app_bar.dart';

class VisaNotApplicable extends StatefulWidget {
  const VisaNotApplicable({super.key});

  @override
  State<VisaNotApplicable> createState() => _VisaNotApplicableState();
}

class _VisaNotApplicableState extends State<VisaNotApplicable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Upload Visa Document",
          onpress: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.bottomnav,
              (routes) => false,
            );
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          Center(
            child: Image.asset(
              "assets/images/visastatus.png",
              height: 230.h,
              width: 250.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text("You have not yet Reached Visa Stage.",
              style: H2TextStyle(AppColors.PrimaryMainColor)),
        ],
      ),
    );
  }
}
