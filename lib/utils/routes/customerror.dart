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
    return WillPopScope(
      onWillPop: () => _onbackbuttondoubleClick(context),
      child: Scaffold(
        body: Center(
          child: SizedBox(
              height: 280.h,
              // width: 280.w,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    height: 150.h,
                    width: 150.w,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Oops! Something's Not Right.",
                    style: batchtext2(AppColors.PrimaryMainColor),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    width: 150.w,
                    child: ButtonPrimary(
                        title: "Try Again",
                        onPressed: () {
                          Future.delayed(const Duration(seconds: 0), () {
                            Navigator.pushNamed(context, RoutesName.splash);
                          });
                        }),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Future<bool> _onbackbuttondoubleClick(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.bottomnav,
      (routes) => false,
    );
    return false;
  }
}
