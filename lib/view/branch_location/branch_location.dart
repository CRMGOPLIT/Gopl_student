import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/branchDetailsModels.dart';
import 'package:global_student/utils/color.dart';
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

  bool loanding = true;
  late DashBoardBloc dashBoardBloc;
  List<BranchDetailsModel> data = [];
  List branchData = [];

  List image = [
    "assets/images/branch1.jpg",
    "assets/images/branch2.jpg",
    "assets/images/branch3.jpeg",
    "assets/images/branch2.jpg",
    "assets/images/branch1.jpg",
    "assets/images/branch2.jpg",
    "assets/images/branch1.jpg",
    "assets/images/branch2.jpg",
    "assets/images/branch1.jpg",
    "assets/images/branch2.jpg",
    "assets/images/branch1.jpg",
    "assets/images/branch2.jpg",
    "assets/images/branch1.jpg",
    "assets/images/branch2.jpg",
    "assets/images/branch1.jpg",
    "assets/images/branch2.jpg",
    "assets/images/branch1.jpg",
    "assets/images/branch2.jpg",
    "assets/images/branch1.jpg",
    "assets/images/branch2.jpg",
  ];

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getBranchDetails();
    _gethomeData();
    super.initState();
  }

  getBranchDetails() async {
    dashBoardBloc.branchControllerStream.listen((event) {
      if (event != null) {
        // debugger();
        // print(event);
        branchData = event;

        for (int i = 0; i < branchData.length; i++) {
          BranchDetailsModel branchDetailsModel =
              BranchDetailsModel.fromJson(event[i]);
          data.add(branchDetailsModel);
        }
        setState(() {
          loanding = false;
          //print(location);
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callGetBranchDetailsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Branch Location",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.bottomnav);
          },
        ),
      ),
      body: loanding == true
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(0.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 170.h,
                                      width: 330.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.PrimaryMainColor,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                image[index],
                                              ))),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 170.h,
                                            width: 330.w,
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.45),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.sp)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.r),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 70.h,
                                                      ),
                                                      Text(
                                                        data[index]
                                                            .branchName
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: btntext(AppColors
                                                            .PrimaryWhiteColor),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            size: 15.sp,
                                                            color: AppColors
                                                                .PrimaryWhiteColor,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              if (await canLaunch(
                                                                  data[index]
                                                                      .locationUrl)) {
                                                                await launch(data[
                                                                        index]
                                                                    .locationUrl);
                                                              } else {
                                                                throw 'Could not launch';
                                                              }
                                                            },
                                                            child: SizedBox(
                                                              width: 300,
                                                              child: Text(
                                                                  data[index]
                                                                      .branchAddress
                                                                      .toString(),
                                                                  maxLines: 3,
                                                                  style: location(
                                                                      AppColors
                                                                          .PrimaryWhiteColor)
                                                                  // TextStyle(
                                                                  //     color: AppColors
                                                                  //         .PrimaryMainColor,
                                                                  //     decoration:
                                                                  //         TextDecoration
                                                                  //             .underline,
                                                                  //     fontFamily: Constant
                                                                  //         .font_family_poppins,
                                                                  //     fontWeight:
                                                                  //         FontWeight.w600,
                                                                  //     fontSize: 12.sp),
                                                                  ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.phone,
                                                            size: 15.sp,
                                                            color: AppColors
                                                                .PrimaryWhiteColor,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          SizedBox(
                                                            width: 160.w,
                                                            child: Text(
                                                              data[index]
                                                                  .branchPhone
                                                                  .toString(),
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryWhiteColor),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(left: 8.r),
                                    //   child: Column(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.start,
                                    //     children: [
                                    //       Padding(
                                    //         padding: EdgeInsets.all(8.r),
                                    //         child: Text(
                                    //           data[index]
                                    //               .branchName
                                    //               .toString(),
                                    //           textAlign: TextAlign.center,
                                    //           style: OtpText(AppColors
                                    //               .PrimaryBlackColor),
                                    //         ),
                                    //       ),
                                    //       Row(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.start,
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.start,
                                    //         children: [
                                    //           Icon(
                                    //             Icons.location_on,
                                    //             size: 15.sp,
                                    //             color: AppColors
                                    //                 .PrimaryMainColor,
                                    //           ),
                                    //           SizedBox(
                                    //             width: 5.w,
                                    //           ),
                                    //           InkWell(
                                    //             onTap: () async {
                                    //               const url =
                                    //                   'https://www.google.com/maps/d/viewer?mid=1T1ZLcwz23FD9CGb7GnBTTtiXfxw&hl=en_US&ll=28.684263000000033%2C77.18702299999997&z=17';
                                    //               if (await canLaunch(
                                    //                   loc[index])) {
                                    //                 await launch(loc[index]);
                                    //               } else {
                                    //                 throw 'Could not launch $url';
                                    //               }
                                    //             },
                                    //             child: SizedBox(
                                    //               width: 180.w,
                                    //               child: Text(
                                    //                   data[index]
                                    //                       .branchAddress
                                    //                       .toString(),
                                    //                   style: location(AppColors
                                    //                       .PrimaryMainColor)
                                    //                   // TextStyle(
                                    //                   //     color: AppColors
                                    //                   //         .PrimaryMainColor,
                                    //                   //     decoration:
                                    //                   //         TextDecoration
                                    //                   //             .underline,
                                    //                   //     fontFamily: Constant
                                    //                   //         .font_family_poppins,
                                    //                   //     fontWeight:
                                    //                   //         FontWeight.w600,
                                    //                   //     fontSize: 12.sp),
                                    //                   ),
                                    //             ),
                                    //           )
                                    //         ],
                                    //       ),
                                    //       SizedBox(
                                    //         height: 10.h,
                                    //       ),
                                    //       Row(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.start,
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.start,
                                    //         children: [
                                    //           Icon(
                                    //             Icons.phone,
                                    //             size: 15.sp,
                                    //             color: AppColors
                                    //                 .PrimaryBlackColor,
                                    //           ),
                                    //           SizedBox(
                                    //             width: 5.w,
                                    //           ),
                                    //           SizedBox(
                                    //             width: 160.w,
                                    //             child: Text(
                                    //               data[index]
                                    //                   .branchPhone
                                    //                   .toString(),
                                    //               style: batchtext2(AppColors
                                    //                   .PrimaryBlackColor),
                                    //             ),
                                    //           )
                                    //         ],
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }
}
