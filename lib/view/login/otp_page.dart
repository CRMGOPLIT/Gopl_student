import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/loginbloc.dart';
import 'package:global_student/networking/NetworkConstant.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/widget/button.dart';
import 'package:global_student/view/widget/loader.dart';
import 'package:global_student/view/widget/otp_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/routes/routes_name.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _otpController = new TextEditingController();

  late LoginDataBloc loginDataBloc;
  var data2 = Get.arguments;

  @override
  void initState() {
    loginDataBloc = LoginDataBloc();
    // callpostlogindata();
    loginDataBloc.postloginStream.listen((event) async {
      Navigator.pop(context);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Otp Verify Successfully"),
        ));
        // print(event.data['Token'].toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('stringValue', event.data['Token'].toString());
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.bottomnav,
          (routes) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(milliseconds: 1000),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oops Error!',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text("Login Faield",
                          style: batchtext1(
                            AppColors.PrimaryWhiteColor,
                          )),
                      //         TextStyle(fontSize: 15.sp, color: Colors.white),
                      //     maxLines: 2,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    });
    // TODO: implement initState
    super.initState();
  }

  void callOtpdata() {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Map<String, String> data = {
      NetworkConstant.OTP_CODE: _otpController.text,
      NetworkConstant.Mobile_Number: data2,
    };
    loginDataBloc.callPostOtp(data);

    // debugger();
    print(data);
  }

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
                  fit: BoxFit.contain,
                  height: 220.h,
                  //width: 350.h,
                ),
              ),
              Text('$data2'),
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
                height: 40.h,
              ),
              Text("Enter the 4-digit code",
                  style: H2TextStyle(AppColors.PrimaryBlackColor)),
              SizedBox(
                height: 5.h,
              ),
              PinInput(
                controller: _otpController,
              ),
              SizedBox(
                height: 15.h,
              ),
              ButtonPrimary(
                title: "Submit",
                onPressed: () {
                  callOtpdata();
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

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', "abc");
  }
}
