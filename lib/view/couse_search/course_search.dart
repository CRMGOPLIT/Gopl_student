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
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Course Details",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.bottomnav);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Find Your Course",
                style: FieldTextStyle(AppColors.PrimaryBlackColor),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.searchPage);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 40.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                      color: AppColors.PrimaryWhiteColor,
                      border: Border.all(color: AppColors.hintcolor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          const Icon(
                            Icons.search,
                            color: AppColors.hintcolor,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            "Search Courses/University",
                            style: batchtext2(AppColors.hintcolor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Courses",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    ),
                  ),
                  Text(
                    "View All",
                    style: FieldTextStyle(
                      AppColors.PrimaryMainColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 215.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: universitylist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: 10.r,
                        bottom: 10.h,
                        top: 10.h,
                      ),
                      width: 220.w,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/upic.png",
                              height: 80.h,
                              width: 300.w,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "Master of Science in Computer Science with Big Data and Artificial Intelligence",
                              maxLines: 3,
                              style: batchtext2(AppColors.PrimaryMainColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "SRH Berlin University of Applied Sciences Ranking",
                              maxLines: 2,
                              style: batchtext1(AppColors.PrimaryBlackColor),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "€ 6450.00/semester",
                              style: batchtext2(AppColors.PrimaryBlackColor),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top University",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    ),
                  ),
                  Text(
                    "View All",
                    style: FieldTextStyle(
                      AppColors.PrimaryMainColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 120.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: universitylist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: 10.r,
                        bottom: 10.h,
                        top: 10.h,
                      ),
                      width: 170.w,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Image.asset(
                                universitylist[index].image.toString(),
                                height: 50.h,
                                width: 50.w,
                              ),
                            ),
                            universitylist[index].title!.length <= 60
                                ? Text(
                                    universitylist[index].title.toString(),
                                    maxLines: 2,
                                    style:
                                        batchtext2(AppColors.PrimaryBlackColor),
                                  )
                                : Text(
                                    universitylist[index].title.toString(),
                                    maxLines: 2,
                                    style:
                                        batchtext2(AppColors.PrimaryBlackColor),
                                  )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Country",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 153.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: Countrycourse.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: double.maxFinite,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                    Countrycourse[index].image.toString(),
                                  ),
                                  radius: 40,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  Countrycourse[index].title.toString(),
                                  style:
                                      batchtext2(AppColors.PrimaryBlackColor),
                                ),
                                Text(
                                  "8 University",
                                  style:
                                      batchtext1(AppColors.PrimaryBlackColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
