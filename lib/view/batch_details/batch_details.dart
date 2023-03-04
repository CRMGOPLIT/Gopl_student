import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
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
              Navigator.pushNamed(context, RoutesName.bottomnav);
            },
          ),
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: ((context, index) {
              return ListBatch(
                key: ValueKey(index),
                index: index,
              );
            })));
  }
}

class ListBatch extends StatefulWidget {
  final int index;
  const ListBatch({
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
                  // BoxShadow(
                  //     offset: Offset(
                  //       -2,
                  //       -5,
                  //     ),
                  //     color: Colors.black12,
                  //     blurRadius: 2.0,
                  //     spreadRadius: 2.0),
                ]),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: AppColors.PrimaryMainColor,
                            image: DecorationImage(
                              image: AssetImage("assets/images/fimg.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10.r)),
                        // child: Column(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Padding(
                        //       padding: EdgeInsets.all(0.r),
                        //       child: Image.asset(
                        //         "assets/images/fimg.png",
                        //         fit: BoxFit.cover,
                        //         height: 80.h,
                        //       ),
                        //     ),
                        //     // Text(
                        //     //   "IELTS/2022/0064",
                        //     //   textAlign: TextAlign.center,
                        //     //   style:
                        //     //       FieldTextStyle(AppColors.PrimaryWhiteColor),
                        //     // ),
                        //   ],
                        // )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Name :- ',
                                style: batchtext1(AppColors.PrimaryBlackColor),
                                children: [
                                  TextSpan(
                                    text: 'Gautam Sir',
                                    style:
                                        batchtext2(AppColors.PrimaryBlackColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Faculty Grade :- ',
                                style: batchtext1(AppColors.PrimaryBlackColor),
                                children: [
                                  TextSpan(
                                    text: 'A',
                                    style:
                                        batchtext2(AppColors.PrimaryBlackColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Batch Type :- ',
                                style: batchtext1(AppColors.PrimaryBlackColor),
                                children: [
                                  TextSpan(
                                    text: 'Online',
                                    style:
                                        batchtext2(AppColors.PrimaryBlackColor),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Batch Name :- ',
                          style: batchtext1(AppColors.PrimaryBlackColor),
                          children: [
                            TextSpan(
                              text: 'IELTS/2022/0064',
                              style: batchtext2(AppColors.PrimaryBlackColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 170.w,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: 'Start Date :- ',
                                style: batchtext1(AppColors.PrimaryBlackColor),
                                children: [
                                  TextSpan(
                                    text: '01 jan 23',
                                    style:
                                        batchtext2(AppColors.PrimaryBlackColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150.w,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: 'End Date :- ',
                                style: batchtext1(AppColors.PrimaryBlackColor),
                                children: [
                                  TextSpan(
                                    text: '02 feb 23',
                                    style:
                                        batchtext2(AppColors.PrimaryBlackColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 300,
                        height: 1.h,
                        color: AppColors.PrimaryGreyColor,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Batch Size",
                                style: batchtext1(AppColors.PrimaryWhiteColor),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "10",
                                textAlign: TextAlign.center,
                                style: batchtext2(AppColors.PrimaryWhiteColor),
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
                                style: batchtext1(AppColors.PrimaryWhiteColor),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "7:00 PM",
                                textAlign: TextAlign.center,
                                style: batchtext2(AppColors.PrimaryWhiteColor),
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
                                style: batchtext1(AppColors.PrimaryWhiteColor),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "5",
                                textAlign: TextAlign.center,
                                style: batchtext2(AppColors.PrimaryWhiteColor),
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
                          padding: EdgeInsets.all(7.r),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enrolled",
                                style: batchtext1(AppColors.PrimaryWhiteColor),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutesName.home,
                                      arguments: ["name ", "jdnwkk", "wndopi"]);
                                },
                                child: Text(
                                  "5",
                                  textAlign: TextAlign.center,
                                  style:
                                      batchtext2(AppColors.PrimaryWhiteColor),
                                ),
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
