import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';

class BatchDetails extends StatefulWidget {
  const BatchDetails({super.key});

  @override
  State<BatchDetails> createState() => _BatchDetailsState();
}

class _BatchDetailsState extends State<BatchDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Batch Details",
            onpress: () {
              // Navigator.pushNamed(context, RoutesName.login);
            },
          ),
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: ((context, index) {
              return ListBatch(
                key: ValueKey<int>(index),
                index: index,
              );
            })));
  }
}

class ListBatch extends StatefulWidget {
  final int index;
  ListBatch({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<ListBatch> createState() => _ListBatchState();
}

class _ListBatchState extends State<ListBatch> {
  bool _animate = false;

  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    if (_isStart) {
      Future.delayed(Duration(milliseconds: widget.index * 1000), () {
        setState(() {
          _animate = true;
          _isStart = false;
        });
      });
    } else {
      _animate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeOutCubic,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 700),
        padding: _animate
            ? const EdgeInsets.all(2.0)
            : const EdgeInsets.only(top: 10),
        child: Padding(
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
                  padding: EdgeInsets.all(8.r),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 120.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: AppColors.PrimaryMainColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                            child: Text(
                              "IELTS/2022/0064",
                              textAlign: TextAlign.center,
                              style:
                                  FieldTextStyle(AppColors.PrimaryWhiteColor),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 10.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Name :- ',
                                style:
                                    FieldTextStyle(AppColors.PrimaryBlackColor),
                                children: [
                                  TextSpan(
                                    text: 'Mohit Singh',
                                    style: Text2Regular(
                                        AppColors.PrimaryBlackColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Faculty Grade :- ',
                                style:
                                    FieldTextStyle(AppColors.PrimaryBlackColor),
                                children: [
                                  TextSpan(
                                    text: 'A',
                                    style: Text2Regular(
                                        AppColors.PrimaryBlackColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Batch Type :- ',
                                style:
                                    FieldTextStyle(AppColors.PrimaryBlackColor),
                                children: [
                                  TextSpan(
                                    text: 'Online',
                                    style: Text2Regular(
                                        AppColors.PrimaryBlackColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              width: 190.w,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: 'Start Date :- ',
                                  style: FieldTextStyle(
                                      AppColors.PrimaryBlackColor),
                                  children: [
                                    TextSpan(
                                      text: '01 jan 23',
                                      style: Text2Regular(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              width: 190.w,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: 'End Date :- ',
                                  style: FieldTextStyle(
                                      AppColors.PrimaryBlackColor),
                                  children: [
                                    TextSpan(
                                      text: '02 feb 23',
                                      style: Text2Regular(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Container(
                    height: 60.h,
                    width: 390.w,
                    decoration: BoxDecoration(
                        color: AppColors.PrimaryMainColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Batch Size",
                                style:
                                    FieldTextStyle(AppColors.PrimaryWhiteColor),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "10",
                                textAlign: TextAlign.center,
                                style:
                                    Text2Regular(AppColors.PrimaryWhiteColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40.h,
                          width: 2.w,
                          color: AppColors.PrimaryWhiteColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Time",
                                style:
                                    FieldTextStyle(AppColors.PrimaryWhiteColor),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "7:00 PM",
                                textAlign: TextAlign.center,
                                style:
                                    Text2Regular(AppColors.PrimaryWhiteColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40.h,
                          width: 2.w,
                          color: AppColors.PrimaryWhiteColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Available",
                                style:
                                    FieldTextStyle(AppColors.PrimaryWhiteColor),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "5",
                                textAlign: TextAlign.center,
                                style:
                                    Text2Regular(AppColors.PrimaryWhiteColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40.h,
                          width: 2.w,
                          color: AppColors.PrimaryWhiteColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enrolled",
                                style:
                                    FieldTextStyle(AppColors.PrimaryWhiteColor),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "5",
                                textAlign: TextAlign.center,
                                style:
                                    Text2Regular(AppColors.PrimaryWhiteColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
