import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/dashboard/dash_grid_model.dart';
import 'package:global_student/view/widget/app_bar.dart';

class CourseSerach extends StatefulWidget {
  const CourseSerach({super.key});

  @override
  State<CourseSerach> createState() => _CourseSerachState();
}

class _CourseSerachState extends State<CourseSerach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h), // here the desired height
        child: AppBarCustom(
          title: "Course Search",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.home);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              visualDensity: VisualDensity(horizontal: 1.r, vertical: -3.r),
              leading: Text(
                "Country",
                style: OtpText(
                  AppColors.PrimaryBlackColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.PrimaryBlackColor,
                size: 20.sp,
              ),
            ),
            SizedBox(
              // constraints: BoxConstraints(
              //   maxHeight: double.infinity,
              // ),
              height: 123.h,

              // color: Colors.amber,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: Countrycourse.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: double.maxFinite,
                          ),
                          margin: EdgeInsets.only(
                              left: 14.r, bottom: 10.h, top: 10.h, right: 14.r),
                          // height: 100.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: AppColors.PrimaryWhiteColor,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(
                                    4,
                                    4,
                                  ),
                                  color: Colors.black12,
                                  blurRadius: 2.0,
                                  spreadRadius: 3.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  Countrycourse[index].image.toString(),
                                  height: 70.h,
                                  width: 70.w,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  Countrycourse[index].title.toString(),
                                  style:
                                      Text2Regular(AppColors.PrimaryBlackColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 1.r, vertical: -3.r),
              leading: Text(
                "University",
                style: OtpText(
                  AppColors.PrimaryBlackColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.PrimaryBlackColor,
                size: 20.sp,
              ),
            ),
            SizedBox(
              height: 170.h,
              // color: Colors.amber,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: universitylist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 14.r, bottom: 10.h, top: 10.h, right: 14.r),
                      // height: 100.h,
                      width: 170.w,
                      decoration: BoxDecoration(
                        color: AppColors.PrimaryWhiteColor,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(
                                4,
                                4,
                              ),
                              color: Colors.black12,
                              blurRadius: 2.0,
                              spreadRadius: 3.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Image.asset(
                                universitylist[index].image.toString(),
                                height: 70.h,
                                width: 70.w,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            universitylist[index].title!.length <= 60
                                ? Text(
                                    universitylist[index].title.toString(),
                                    style: Text2Regular(
                                        AppColors.PrimaryBlackColor),
                                  )
                                : Text(
                                    universitylist[index].title.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Text2Regular(
                                        AppColors.PrimaryBlackColor),
                                  )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 1.r, vertical: -3.r),
              leading: Text(
                "Courses",
                style: OtpText(
                  AppColors.PrimaryBlackColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.PrimaryBlackColor,
                size: 20.sp,
              ),
            ),
            SizedBox(
              height: 300.h,
              // color: Colors.amber,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: universitylist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 14.r, bottom: 10.h, top: 10.h, right: 14.r),
                      //height: 100.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: AppColors.PrimaryWhiteColor,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(
                                4,
                                4,
                              ),
                              color: Colors.black12,
                              blurRadius: 2.0,
                              spreadRadius: 3.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/upic.png",
                              height: 120.h,
                              width: 300.w,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.r, right: 8.r, bottom: 8.r, top: 8.r),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "University Name -",
                                    style: Text2Regular(
                                        AppColors.PrimaryBlackColor),
                                  ),
                                  SizedBox(
                                    width: 140.w,
                                    child: Text(
                                      "SRH Berlin University of Applied Sciences Ranking",
                                      style: TextRegular(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.r, right: 8.r, bottom: 8.r, top: 8.r),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Course Name -",
                                    style: Text2Regular(
                                        AppColors.PrimaryBlackColor),
                                  ),
                                  SizedBox(
                                    width: 140.w,
                                    child: Text(
                                      "Master of Science in Computer Science with Big Data and Artificial Intelligence",
                                      style: TextRegular(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.r, right: 8.r, bottom: 8.r, top: 8.r),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tuition Fees -",
                                    style: Text2Regular(
                                        AppColors.PrimaryBlackColor),
                                  ),
                                  SizedBox(
                                    width: 140.w,
                                    child: Text(
                                      "€ 6450.00/semester",
                                      style: TextRegular(
                                          AppColors.PrimaryBlackColor),
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
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
