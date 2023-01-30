import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/constant.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';

class BranchLocation extends StatefulWidget {
  const BranchLocation({super.key});

  @override
  State<BranchLocation> createState() => _BranchLocationState();
}

class _BranchLocationState extends State<BranchLocation> {
  
  List loc = [
    'https://flutter.dev',
    'https://maps.app.goo.gl/TsrBfPciHARX7nRo6',
    "https://www.youtube.com/",
    'https://www.google.com/maps/d/viewer?mid=1T1ZLcwz23FD9CGb7GnBTTtiXfxw&hl=en_US&ll=28.684263000000033%2C77.18702299999997&z=17',
    'https://www.google.com/maps/d/viewer?mid=1T1ZLcwz23FD9CGb7GnBTTtiXfxw&hl=en_US&ll=28.684263000000033%2C77.18702299999997&z=17',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h), // here the desired height
        child: AppBarCustom(
          title: "Branch Location",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.home);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Container(
                      // height: 350.h,
                      // width: 390.w,
                      decoration: BoxDecoration(
                        color: AppColors.PrimaryWhiteColor,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(
                                4,
                                10,
                              ),
                              color: Colors.black26,
                              blurRadius: 1.0,
                              spreadRadius: 1.0),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 80.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.PrimaryMainColor,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                "assets/images/evh.png",
                                              ))),
                                    ),
                                    Positioned(
                                      top: 70,
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          maxHeight: double.infinity,
                                        ),
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.PrimaryMainColor,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.r),
                                          child: Text(
                                            "Delhi",
                                            textAlign: TextAlign.center,
                                            style: TextRegular(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 25.sp,
                                            color: AppColors.PrimaryMainColor,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              const url =
                                                  'https://www.google.com/maps/d/viewer?mid=1T1ZLcwz23FD9CGb7GnBTTtiXfxw&hl=en_US&ll=28.684263000000033%2C77.18702299999997&z=17';
                                              if (await canLaunch(loc[index])) {
                                                await launch(loc[index]);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
                                            child: SizedBox(
                                              width: 160.w,
                                              child: Text(
                                                "Cts 215, Andheri - Kurla Rd, Andheri East,Mumbai 400059",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .PrimaryMainColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontFamily: Constant
                                                        .font_family_poppins,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 20.sp,
                                            color: AppColors.PrimaryBlackColor,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          SizedBox(
                                            width: 160.w,
                                            child: Text(
                                              "9898989898",
                                              style: FieldTextStyle(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
