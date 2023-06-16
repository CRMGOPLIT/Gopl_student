import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/loginbloc.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/login/otp_page.dart';
import 'package:global_student/view/widget/button.dart';
import 'package:global_student/view/widget/loader.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../networking/NetworkConstant.dart';

class LginPage extends StatefulWidget {
  const LginPage({super.key});

  @override
  State<LginPage> createState() => _LginPageState();
}

class _LginPageState extends State<LginPage> {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final TextEditingController _mobileNumber = TextEditingController();

  late LoginDataBloc loginDataBloc;

  @override
  void initState() {
    loginDataBloc = LoginDataBloc();
    // callpostlogindata();
    loginDataBloc.postloginStream.listen((event) {
      Navigator.pop(context);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true && event.data['success'] == '1') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Otp send your Mobile Number"),
        ));
        Get.to(const OtpPage(), arguments: _mobileNumber.text);
        // Get.to(OtpPage(), arguments: _mobileNumber.text);
        // Navigator.pushNamedAndRemoveUntil(
        //     context, RoutesName.otp, (routes) => false,
        //     arguments: {_mobileNumber.text});
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
                      Text("Login Faield Register your number",
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

    super.initState();
  }

  void callpostlogindata() {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Map<String, String> data = {
      NetworkConstant.Mobile_Number: _mobileNumber.text,
    };
    loginDataBloc.callPostLogin(data);

    // debugger();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PrimaryWhiteColor,
      // appBar: AppBar(
      //     elevation: 0,
      //     automaticallyImplyLeading: false,
      //     backgroundColor: AppColors.PrimaryWhiteColor,
      //     title: Text(
      //       "Login Account",
      //       style: H1TextStyle(
      //         AppColors.PrimaryBlackColor,
      //       ),
      //     )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15.r, right: 15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                // Text("Hello, Welcome back to our account",
                //     style: Text2Regular(
                //       AppColors.TextRegularkColor,
                //     )),
                Center(
                  child: SizedBox(
                      height: 220.h,
                      width: 350.h,
                      child: Image.asset(
                        "assets/images/loginnew1.png",
                        fit: BoxFit.contain,
                      )),
                ),
                SizedBox(
                  height: 55.h,
                ),
                Text("Login Account",
                    style: H2TextStyle(
                      AppColors.PrimaryBlackColor,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Text("Hello, Welcome back to our account",
                    style: Text2Regular(
                      AppColors.TextRegularkColor,
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Text("Enter Your Phone Number",
                    style: H2TextStyle(
                      AppColors.PrimaryBlackColor,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                IntlPhoneField(
                  controller: _mobileNumber,
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
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                ButtonPrimary(
                  title: "Request OTP",
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    callpostlogindata();

                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, RoutesName.otp, (routes) => false);
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.register);
                    },
                    child: Text(
                      'Register'.toUpperCase(),
                      style: TextRegular(AppColors.PrimaryMainColor),
                    ),
                  ),
                ),
                Text(
                    "You will receive a 4 digit code for phone number verification ",
                    textAlign: TextAlign.center,
                    style: Text2Regular(
                      AppColors.TextRegularkColor,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
