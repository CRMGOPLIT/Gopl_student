import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';
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
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.bottomnav,
              (routes) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 40.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/bannerlogo.png"))),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesName.branchLocation,
                    (routes) => false,
                  );
                },
                child: Center(
                  child: SizedBox(
                      height: 200,
                      width: 250,
                      child: Image.asset("assets/images/mapbranch.png",
                          fit: BoxFit.fill)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: _launchUrl,
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(bottom: 1.sp, top: 10.sp),
                      child: Text(
                        "Visit Our Website",
                        style: batchtext2(AppColors.PrimaryBlackColor),
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "https://www.global-opportunities.net",
                            style: location(AppColors.PrimaryMainColor),
                          ),
                        ],
                      ),
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
                      style: batchtext2(AppColors.PrimaryBlackColor),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "HS-27, Kailash Colony Market, New Delhi - 110048.",
                            style: batchtext1(AppColors.PrimaryBlackColor)),
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
                      style: batchtext2(AppColors.PrimaryBlackColor),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" +91 11 47141414, +91 8282828215,   1800111119",
                            style: batchtext1(AppColors.PrimaryBlackColor)),
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
                      style: batchtext2(AppColors.PrimaryBlackColor),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("info@global-opportunities.net",
                            style: batchtext1(AppColors.PrimaryBlackColor)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.transparent,
          highlightElevation: 0.0,
          elevation: 0.0,
          onPressed: () {
            whatsapp();
          },
          label: Column(
            children: [
              Image.asset(
                "assets/images/whatsapp.png",
                height: 50.h,
                width: 50.w,
              ),
              Text(
                "Chat with us",
                style: batchtext1(AppColors.PrimaryMainColor),
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          )),
    );
  }

  whatsapp() async {
    var contact = "+919205689041";
    final androidUrl =
        "whatsapp://send?phone=$contact&text= Hi, I need some help";
    final iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help regarding Abroad Education.')}";

    try {
      if (Platform.isIOS) {
        // ignore: deprecated_member_use
        await launch(
          (iosUrl),
        );
      } else {
        // ignore: deprecated_member_use
        await launch(
          (androidUrl),
        );
      }
    } on Exception {
      //EasyLoading.showError('WhatsApp is not installed.');
    }
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://www.global-opportunities.net');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
