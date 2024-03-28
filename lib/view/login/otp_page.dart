
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
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final TextEditingController _otpController = TextEditingController();

  late LoginDataBloc loginDataBloc;
  var data2 = Get.arguments;
  bool resendotp = true;

  @override
  void initState() {
    loginDataBloc = LoginDataBloc();

    loginDataBloc.postOtpStream.listen((event) async {
     
      Navigator.pop(context);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);
      if (response == true && event.data['success'] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Welcome to Global Opportunities",
            style: batchtext1(AppColors.PrimaryWhiteColor),
          ),
        ));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('stringValue', event.data['Token'].toString());
        // ignore: use_build_context_synchronously
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
            height: 80,
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
                      Text("Wrong Otp",
                          style: batchtext1(
                            AppColors.PrimaryWhiteColor,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    });

    super.initState();
  }

  void callOtpdata() {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Map<String, String> data = {
      NetworkConstant.OTP_CODE: _otpController.text,
      NetworkConstant.Mobile_Number: data2,
    };
    loginDataBloc.callPostOtp(data);
  }

  void callResendOtp() {
    Map<String, String> data = {
      NetworkConstant.Mobile_Number: data2,
    };
    loginDataBloc.callPostLogin(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: Padding(
            padding: EdgeInsets.only(left: 15.r, right: 15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/otpnew1.png",
                    fit: BoxFit.contain,
                    height: 220.h,
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Text("Verification code",
                    style: H2TextStyle(AppColors.PrimaryBlackColor)),
                SizedBox(
                  height: 10.h,
                ),
                RichText(
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
                resendotp == true
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              resendotp = false;
                            });

                            callResendOtp();
                          },
                          child: Text(
                            'Resend',
                            textAlign: TextAlign.center,
                            style: TextRegular(AppColors.PrimaryMainColor),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Otp Send',
                            textAlign: TextAlign.center,
                            style: TextRegular(AppColors.PrimaryMainColor),
                          ),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 150.h,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
