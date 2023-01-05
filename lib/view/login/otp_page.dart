import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/button.dart';
import 'package:global_student/view/widget/otp_widget.dart';

import '../../utils/routes/routes_name.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.PrimaryMainColor,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: AppColors.PrimaryWhiteColor,
          size: 30.sp,
        ),
        centerTitle: true,
        title: Text(
          "OTP",
          style: H1TextStyle(AppColors.PrimaryWhiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15.r, right: 15.r),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/otpimg.png",
                  fit: BoxFit.cover,
                  height: 250.h,
                  width: 250.w,
                ),
              ),
              Text("Verification code",
                  style: H1TextStyle(AppColors.PrimaryBlackColor)),
              SizedBox(
                height: 10.h,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'We have send the code verification to\n ',
                  style: TextRegular(AppColors.TextRegularkColor),
                  children: [
                    TextSpan(
                        text: 'Your  Mobile Number !',
                        style: TextRegular(AppColors.TextRegularkColor)),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text("+91 00000 00000",
                  style: Text2Regular(AppColors.PrimaryBlackColor)),
              SizedBox(
                height: 30.h,
              ),
              const PinInput(),
              SizedBox(
                height: 30.h,
              ),
              ButtonPrimary(
                title: "Submit",
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.home);
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.login);
                  },
                  child: Text(
                    'Resend Otp'.toUpperCase(),
                    style: TextRegular(AppColors.PrimaryMainColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
