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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: AppColors.PrimaryBlackColor,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/otpnew1.png",
                  fit: BoxFit.cover,
                  height: 220.h,
                  //width: 350.h,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text("Verification code",
                  style: H2TextStyle(AppColors.PrimaryBlackColor)),
              SizedBox(
                height: 10.h,
              ),
              RichText(
                // textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'We have send the code verification to\n',
                  style: Text2Regular(AppColors.TextRegularkColor),
                  children: [
                    TextSpan(
                        text: 'Your  Mobile Number !',
                        style: Text2Regular(AppColors.TextRegularkColor)),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Text("Enter the 4-digit code",
                  style: H2TextStyle(AppColors.PrimaryBlackColor)),
              SizedBox(
                height: 10.h,
              ),
              const PinInput(),
              SizedBox(
                height: 20.h,
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
                    'Resend',
                    textAlign: TextAlign.center,
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
