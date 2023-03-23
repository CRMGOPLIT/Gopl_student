import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/constant.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Contact Us",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.bottomnav);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: 160,
              //   width: 380,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       image: DecorationImage(
              //           image: AssetImage("assets/images/appbanner1.jpg"))),
              // ),
              Container(
                  height: 240,
                  width: 300,
                  padding: EdgeInsets.all(0.sp),
                  child: Lottie.asset("assets/images/contactus.json")),
              Card(
                elevation: 3,
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 1.sp, top: 10.sp),
                    child: Text(
                      "Visit Our Website",
                      style: FieldTextStyle(AppColors.PrimaryBlackColor),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "https://www.global-opportunities.net",
                          style: TextStyle(
                              color: AppColors.PrimaryMainColor,
                              decoration: TextDecoration.underline,
                              fontFamily: Constant.font_family_poppins,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 1.sp, top: 10.sp),
                    child: Text(
                      "Corporate Office",
                      style: FieldTextStyle(AppColors.PrimaryBlackColor),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "HS-27, Kailash Colony Market, New Delhi - 110048.",
                          style: TextStyle(
                              color: AppColors.PrimaryMainColor,
                              //decoration: TextDecoration.underline,
                              fontFamily: Constant.font_family_poppins,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 1.sp, top: 10.sp),
                    child: Text(
                      "Call US",
                      style: FieldTextStyle(AppColors.PrimaryBlackColor),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " +91 11 47141414, +91 8282828215, 1800111119",
                          style: TextStyle(
                              color: AppColors.PrimaryMainColor,
                              //decoration: TextDecoration.underline,
                              fontFamily: Constant.font_family_poppins,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 1.sp, top: 10.sp),
                    child: Text(
                      "Email  US",
                      style: FieldTextStyle(AppColors.PrimaryBlackColor),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "info@global-opportunities.net",
                          style: TextStyle(
                              color: AppColors.PrimaryMainColor,
                              // decoration: TextDecoration.underline,
                              fontFamily: Constant.font_family_poppins,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     Text(
              //       "Website :-",
              //       style: btntext(AppColors.PrimaryBlackColor),
              //     ),
              //     Container(
              //       width: 250.w,
              //       child: Text(
              //         "https://www.global-opportunities.net",
              //         style: TextStyle(
              //             color: AppColors.PrimaryMainColor,
              //             decoration: TextDecoration.underline,
              //             fontFamily: Constant.font_family_poppins,
              //             fontWeight: FontWeight.w600,
              //             fontSize: 12.sp),
              //       ),
              //     ),
              //   ],
              // ),

              // SizedBox(
              //   height: 20.h,
              // ),
              // Row(
              //   children: [
              //     Text(
              //       "Corporate Office :-",
              //       style: btntext(AppColors.PrimaryBlackColor),
              //     ),
              //     Container(
              //       width: 180.w,
              //       child: Text(
              //         "HS-27, Kailash Colony Market, New Delhi - 110048.",
              //         style: TextStyle(
              //             color: AppColors.PrimaryMainColor,
              //             decoration: TextDecoration.underline,
              //             fontFamily: Constant.font_family_poppins,
              //             fontWeight: FontWeight.w600,
              //             fontSize: 12.sp),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // Row(
              //   children: [
              //     Text(
              //       "Phone no :-",
              //       style: btntext(AppColors.PrimaryBlackColor),
              //     ),
              //     Container(
              //       width: 240.w,
              //       child: Text(
              //         "+91 11 47141414, +91 8282828215, 1800111119",
              //         style: TextStyle(
              //             color: AppColors.PrimaryMainColor,
              //             decoration: TextDecoration.underline,
              //             fontFamily: Constant.font_family_poppins,
              //             fontWeight: FontWeight.w600,
              //             fontSize: 12.sp),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            child: Icon(
              Icons.whatsapp,
              size: 35.sp,
            ),
            backgroundColor: Colors.green,
            onPressed: () {
              whatsapp();
            },
          ),
        ),
      ),
    );
  }

  whatsapp() async {
    var contact = "9155201859";
    var android_url =
        "whatsapp://send?phone=" + contact + "&text= Hi, I need some help";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launch(
          (iosUrl),
        );
      } else {
        await launch(
          (android_url),
        );
      }
    } on Exception {
      print("Whatapps not installed");
      //EasyLoading.showError('WhatsApp is not installed.');
    }
  }
}
