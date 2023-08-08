import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/allpication_status_card.dart';

// ignore: must_be_immutable
class AccordingWidget extends StatefulWidget {
  String? country;
  String? institution;
  String? ug;
  String? course;
  String? chort;
  String? preference;
  String? apidate;
  String? apistatus;
  String? apinumber;
  String? aremark;

  AccordingWidget({
    super.key,
    required this.country,
    required this.institution,
    required this.ug,
    required this.course,
    required this.chort,
    required this.preference,
    required this.apidate,
    required this.apistatus,
    required this.apinumber,
    required this.aremark,
  });

  @override
  // ignore: no_logic_in_create_state
  State<AccordingWidget> createState() => _AccordingWidgetState(
      country: country,
      institution: institution,
      ug: ug,
      course: course,
      chort: chort,
      preference: preference,
      apidate: apidate,
      apistatus: apistatus,
      apinumber: apinumber,
      aremark: aremark);
}

class _AccordingWidgetState extends State<AccordingWidget> {
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

  String? aremark;
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
    required this.aremark,
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
            decoration: BoxDecoration(
              color: AppColors.PrimaryMainColor,
              borderRadius: isExpanded == false
                  ? BorderRadius.circular(4)
                  : const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(institution!,
                      style: FieldTextStyle(
                        AppColors.PrimaryWhiteColor,
                      )),
                  isExpanded == true
                      ? Align(
                          child: SizedBox(
                              width: 20.w,
                              height: 40.h,
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: AppColors.PrimaryWhiteColor,
                                  size: 25.sp,
                                ),
                              )),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: 20.w,
                              height: 40.h,
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_down,
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
                      FlipCard(
                          front: SizedBox(
                            width: 370.w,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: AppColors.PrimaryMainColor,
                                  )),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Country :- ',
                                        style: batchtext2(
                                            AppColors.PrimaryBlackColor),
                                        children: [
                                          TextSpan(
                                              text: "$country",
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    ApplicationStatusCard(
                                      title: "Course",
                                      subtitle: course,
                                    ),
                                    SizedBox(height: 5.h),
                                    Text("Application Status",
                                        style: batchtext2(
                                          AppColors.PrimaryBlackColor,
                                        )),
                                    SizedBox(height: 5.h),
                                    Text(apistatus!,
                                        style: batchtext1(Colors.green)),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text("Application Remark",
                                        style: batchtext2(
                                          AppColors.PrimaryBlackColor,
                                        )),
                                    SizedBox(height: 5.h),
                                    Text(aremark!,
                                        style: batchtext1(Colors.red)),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "View More 👆",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 9.sp,
                                          color: AppColors.PrimaryMainColor,
                                          fontFamily: "Outfit",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          back: SizedBox(
                            width: 370.w,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: AppColors.PrimaryMainColor,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Preference :-  ',
                                        style: batchtext2(
                                            AppColors.PrimaryBlackColor),
                                        children: [
                                          TextSpan(
                                              text: "My $preference preference",
                                              style:
                                                  FieldTextStyle(Colors.green)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "Label of Study:- $ug",
                                      style: batchtext2(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Application No :- ',
                                        style: batchtext2(
                                            AppColors.PrimaryBlackColor),
                                        children: [
                                          TextSpan(
                                              text: "$apinumber",
                                              style:
                                                  FieldTextStyle(Colors.green)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    ApplicationStatusCard(
                                      title: "Application Date",
                                      subtitle: apidate,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "My Intake:- $chort",
                                      style: batchtext2(Colors.orange),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
