import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';

import '../../view/widget/button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Error'),
      // ),
      body: Center(
        child: Container(
            height: 330.h,
            width: 250.w,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/net.png',
                  fit: BoxFit.cover,
                ),
                Text(
                  "Oops! Something went wrong.",
                  style: batchtext2(AppColors.PrimaryMainColor),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 150.w,
                  child: ButtonPrimary(
                      title: "Retry",
                      onPressed: () {
                        Future.delayed(const Duration(seconds: 0), () {
                          Navigator.pushNamed(context, RoutesName.splash);
                        });
                      }),
                )
              ],
            )),
      ),
    );
  }
}
