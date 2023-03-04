import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/widget/app_bar.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h), // here the desired height
        child: AppBarCustom(
          title: "Event Details",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.bottomnav);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(
                                  3,
                                  3,
                                ),
                                color: Colors.black12,
                                blurRadius: 1.0,
                                spreadRadius: 0.0),
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 120.h,
                                      width: 320.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.PrimaryMainColor,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                "assets/images/evh.png",
                                              ))),
                                    ),
                                    Positioned(
                                      left: 175.h,
                                      top: 5.h,
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          maxHeight: double.infinity,
                                        ),
                                        width: 120.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.PrimaryWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.r),
                                          child: Text(
                                            "Mumbai, 29 Jan",
                                            textAlign: TextAlign.center,
                                            style: FieldTextStyle(
                                                AppColors.PrimaryMainColor),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(left: 10.r),
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       RichText(
                                //         text: TextSpan(
                                //           text: 'Date :- ',
                                //           style: batchtext1(
                                //               AppColors.PrimaryBlackColor),
                                //           children: [
                                //             TextSpan(
                                //               text: '29/01/2023',
                                //               style: batchtext2(
                                //                   AppColors.PrimaryBlackColor),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //       SizedBox(
                                //         height: 10.h,
                                //       ),
                                //       RichText(
                                //         text: TextSpan(
                                //           text: 'Time :- ',
                                //           style: batchtext1(
                                //               AppColors.PrimaryBlackColor),
                                //           children: [
                                //             TextSpan(
                                //               text: '11:00 AM To 5:00 PM',
                                //               style: batchtext2(
                                //                   AppColors.PrimaryBlackColor),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //       SizedBox(
                                //         height: 10.h,
                                //       ),
                                //       SizedBox(
                                //         width: 200.w,
                                //         child: RichText(
                                //           // overflow: TextOverflow.ellipsis,
                                //           text: TextSpan(
                                //             text: 'Venue :- ',
                                //             style: batchtext1(
                                //                 AppColors.PrimaryBlackColor),
                                //             children: [
                                //               TextSpan(
                                //                 text:
                                //                     'Courtyard by Marriott Mumbai',
                                //                 style: batchtext2(AppColors
                                //                     .PrimaryBlackColor),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //       SizedBox(
                                //         height: 10.h,
                                //       ),
                                //       RichText(
                                //         // overflow: TextOverflow.ellipsis,
                                //         text: TextSpan(
                                //           text: 'Phone :- ',
                                //           style: batchtext1(
                                //               AppColors.PrimaryBlackColor),
                                //           children: [
                                //             TextSpan(
                                //               text: '9090909090',
                                //               style: batchtext2(
                                //                   AppColors.PrimaryBlackColor),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.r),
                            child: Container(
                              height: 1.h,
                              width: 300.w,
                              color: AppColors.PrimaryGreyColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8.r, right: 8.r, bottom: 8.r, top: 8.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 300.w,
                                  child: RichText(
                                    // overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Venue :- ',
                                      style: batchtext1(
                                          AppColors.PrimaryBlackColor),
                                      children: [
                                        TextSpan(
                                          text: 'Courtyard by Marriott Mumbai',
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    Text(
                                      "11:00 AM To 5:00 PM",
                                      style: batchtext1(
                                          AppColors.PrimaryBlackColor),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 20.sp,
                                      color: AppColors.PrimaryMainColor,
                                    ),
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    SizedBox(
                                      width: 290,
                                      child: Text(
                                        "Cts 215, Andheri - Kurla Rd, Andheri East, Mumbai 400059",
                                        style: batchtext1(
                                            AppColors.PrimaryMainColor),
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
                  );
                }),
          )
        ],
      ),
    );
  }
}
