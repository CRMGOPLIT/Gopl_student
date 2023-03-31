import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/applicationStatusModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/applicationStatus/according_model.dart';
import 'package:global_student/view/widget/allpication_status_card.dart';

class AccordingWidget extends StatefulWidget {
  //AccordingLModel accordingData;
  String? country;
  String? institution;
  String? ug;
  String? course;
  String? chort;
  String? preference;
  String? apidate;
  String? apistatus;
  String? apinumber;

  AccordingWidget({
    required this.country,
    required this.institution,
    required this.ug,
    required this.course,
    required this.chort,
    required this.preference,
    required this.apidate,
    required this.apistatus,
    required this.apinumber,
  });

  @override
  State<AccordingWidget> createState() => _AccordingWidgetState(
      country: country,
      institution: institution,
      ug: ug,
      course: course,
      chort: chort,
      preference: preference,
      apidate: apidate,
      apistatus: apistatus,
      apinumber: apinumber);
}

class _AccordingWidgetState extends State<AccordingWidget> {
  final _controller = FadeInController();

  // AccordingLModel accordingData;
  String? country;
  String? institution;
  String? ug;
  String? course;
  String? chort;
  String? preference;
  String? apidate;
  String? apistatus;
  String? apinumber;
  _AccordingWidgetState({
    required this.country,
    required this.institution,
    required this.ug,
    required this.course,
    required this.chort,
    required this.preference,
    required this.apidate,
    required this.apistatus,
    required this.apinumber,
  });

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        children: [
          Container(
            height: 45.h,
            // width: 400.w,
            // margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.PrimaryMainColor,
              borderRadius: isExpanded == false
                  ? BorderRadius.circular(4)
                  : const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Application No :- " + "$apinumber",
                      style: FieldTextStyle(
                        AppColors.PrimaryWhiteColor,
                      )),
                  isExpanded == true
                      ? Align(
                          child: SizedBox(
                              width: 20,
                              height: 40,
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.PrimaryWhiteColor,
                                  size: 25.sp,
                                ),
                              )),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: 20,
                              height: 40,
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: AppColors.PrimaryWhiteColor,
                                  size: 25.sp,
                                ),
                              )),
                        ),
                ],
              ),
            ),
          ),
          isExpanded == true
              ? FadeIn(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 1000),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.PrimaryWhiteColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ApplicationStatusCard(
                                    title: "Country",
                                    subtitle: country,
                                  ),
                                  ApplicationStatusCard(
                                    title: "Institution",
                                    subtitle: institution,
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ApplicationStatusCard(
                                    title: "UG/PG",
                                    subtitle: ug,
                                  ),
                                  ApplicationStatusCard(
                                    title: "Course",
                                    subtitle: course,
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ApplicationStatusCard(
                                    title: "Chort",
                                    subtitle: chort,
                                  ),
                                  ApplicationStatusCard(
                                    title: "Preference",
                                    subtitle: preference,
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ApplicationStatusCard(
                                    title: "Application Date",
                                    subtitle: apidate,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 25.r,
                                        right: 25.r,
                                        top: 20.r,
                                        bottom: 20.r),
                                    margin: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                        color: AppColors.PrimaryGreyColor,
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(
                                                2,
                                                2,
                                              ),
                                              color: Colors.black12,
                                              blurRadius: 1.0,
                                              spreadRadius: 0.0),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 85.w,
                                          child: Text(
                                            "Application Status",
                                            textAlign: TextAlign.center,
                                            style: FieldTextStyle(
                                                AppColors.PrimaryBlackColor),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(5.r),
                                          height: 1.h,
                                          width: 70.w,
                                          color: AppColors.PrimaryBlackColor,
                                        ),
                                        SizedBox(
                                          width: 80.w,
                                          child: Text(
                                            "$apistatus",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    AppColors.PrimaryMainColor,
                                                // fontFamily: Constant.font_poppins_bold,
                                                fontWeight: FontWeight.w500,
                                                height: 1.1,
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // ApplicationStatusCard(
                                  //   title: "Application Status",
                                  //   subtitle: "Visa Approved".toUpperCase(),
                                  // ),
                                ]),
                            SizedBox(
                              height: 15.h,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
