import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

import 'package:global_student/view/widget/allpication_status_card.dart';

class AccordingWidget extends StatefulWidget {
  // AccordingLModel accordingData;
  // String title;
  // AccordingWidget({required this.accordingData});

  @override
  State<AccordingWidget> createState() => _AccordingWidgetState();
}

class _AccordingWidgetState extends State<AccordingWidget> {
  final _controller = FadeInController();

  // AccordingLModel accordingData;
  // String title;
  _AccordingWidgetState();

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
                  Text("Application No :- 12345",
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
                                    subtitle: "Uk",
                                  ),
                                  ApplicationStatusCard(
                                    title: "Institution",
                                    subtitle: "ABC University",
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ApplicationStatusCard(
                                    title: "UG/PG",
                                    subtitle: "PG",
                                  ),
                                  ApplicationStatusCard(
                                    title: "Course",
                                    subtitle: "BA",
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ApplicationStatusCard(
                                    title: "Chort",
                                    subtitle: "Aug 2022 to Nov 2022",
                                  ),
                                  ApplicationStatusCard(
                                    title: "Preference",
                                    subtitle: "1",
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ApplicationStatusCard(
                                    title: "Application Date",
                                    subtitle: "24/02/2022",
                                  ),
                                  ApplicationStatusCard(
                                    title: "Application Status",
                                    subtitle: "Visa Approved",
                                  ),
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
