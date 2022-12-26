import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LginPage extends StatefulWidget {
  const LginPage({super.key});

  @override
  State<LginPage> createState() => _LginPageState();
}

class _LginPageState extends State<LginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PrimaryWhiteColor,
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.PrimaryWhiteColor,
          title: Text(
            "Login Account",
            style: H1TextStyle(
              AppColors.PrimaryBlackColor,
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15.r, right: 15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text("Hello, Welcome back to our account",
                  style: Text2Regular(
                    AppColors.TextRegularkColor,
                  )),
              Center(
                child: SizedBox(
                    height: 250.h,
                    width: 250.h,
                    child: Image.asset(
                      "assets/images/login.png",
                    )),
              ),
              Text("Enter your phone number",
                  style: H2TextStyle(
                    AppColors.PrimaryBlackColor,
                  )),
              SizedBox(
                height: 10.h,
              ),
              Text(
                  "You will receive a 4 digit code for phone number verification.",
                  style: Text2Regular(
                    AppColors.TextRegularkColor,
                  )),
              SizedBox(
                height: 30.h,
              ),
              IntlPhoneField(
                flagsButtonMargin: EdgeInsets.all(10.r),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  // labelText: 'Phone Number',

                  hintText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  if (phone.completeNumber.length >= 13) {
                    FocusScope.of(context).unfocus();
                    print(phone.completeNumber);
                  }
                },
              ),
              SizedBox(
                height: 30.h,
              ),
              ButtonPrimary(
                title: "Request OTP",
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.otp, (routes) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
