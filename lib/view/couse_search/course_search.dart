import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/searchBloc.dart';
import 'package:global_student/model/countrySearchModel.dart';
import 'package:global_student/model/search_dashboard.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/course_details/course_details.dart';
import 'package:global_student/view/course_details/topuniversitydetails.dart';
import 'package:global_student/view/couse_search/universitylistpage.dart';
import 'package:global_student/view/widget/app_bar.dart'; 

class CourseSerach extends StatefulWidget {
  const CourseSerach({super.key});

  @override
  State<CourseSerach> createState() => _CourseSerachState();
}

class _CourseSerachState extends State<CourseSerach> {
  late SearchBloc searchBloc;
  List<CountrySearchModel> countrySearchdata = [];
  List cuntrydata = [];
  bool loading = true;

  List<DashboardCourseDetail> dashboardCourseDetail = [];
  List<DashboardUniversityDetail> dashboardUniversityDetail = [];
  List<DashboardCountryDetail> dashboardCountryDetail = [];
  List searchdashdata = [];

  @override
  void initState() {
    searchBloc = SearchBloc();

    getdata();

    getsearchDashboard();
    super.initState();
  }

  getsearchDashboard() async {
    searchBloc.getdashboardsearchStream.listen((event) {
      if (event != null) {
        SearchDashBoard searchDashBoard = SearchDashBoard.fromJson(event);

        dashboardCourseDetail.addAll(searchDashBoard.dashboardCourseDetail);
        dashboardUniversityDetail
            .addAll(searchDashBoard.dashboardUniversityDetail);
        dashboardCountryDetail.addAll(searchDashBoard.dashboardCountryDetail);

        setState(() {
          loading = false;
        });
      }
    });
  }

  getdata() {
    searchBloc.callSearchDashSearchApi();
  }

  List<String> colors = [];

  List<String> generateRandomColors() {
    List<String> colorList = [
      'assets/images/c1.png',
      'assets/images/c2.png',
      'assets/images/c3.png',
      'assets/images/c1.png',
    ];

    colorList.shuffle(Random());
    return colorList;
  }

  getRandomColor() {
    if (colors.isEmpty) {
      // Regenerate colors if the list is empty
      colors = generateRandomColors();
    }
    return colors.removeLast(); // Remove the last color from the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Course Details",
          onpress: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.bottomnav,
              (routes) => false,
            );
          },
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 2.w,
              color: AppColors.PrimaryMainColor,
            ))
          : SingleChildScrollView(
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
                                Icon(
                                  Icons.search,
                                  color: AppColors.hintcolor,
                                  size: 15.sp,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: dashboardCourseDetail.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => const CourseDetails(),
                                arguments: [
                                  dashboardCourseDetail[index].courseId,
                                ],
                              );
                            },
                            child: SizedBox(
                              width: 230.w,
                              // decoration: BoxDecoration(
                              //     color: AppColors.PrimaryWhiteColor,
                              //     borderRadius: BorderRadius.circular(10.r),
                              //     boxShadow: const [
                              //       BoxShadow(
                              //           offset: Offset(
                              //             3,
                              //             3,
                              //           ),
                              //           color: Colors.black12,
                              //           blurRadius: 1.0,
                              //           spreadRadius: 0.0),
                              //     ]),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    //<-- SEE HERE
                                    borderRadius: BorderRadius.circular(10)
                                    // side: BorderSide(
                                    //   color: AppColors.hintcolor,
                                    // ),
                                    ),
                                margin: EdgeInsets.only(
                                  left: 10.r,
                                  bottom: 10.h,
                                  top: 10.h,
                                ),
                                // width: 220.w,

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        dashboardCourseDetail[index]
                                            .universityImage,
                                        loadingBuilder: (context, child,
                                                loadingProgress) =>
                                            (loadingProgress == null ||
                                                    dashboardCourseDetail[index]
                                                            .universityImage ==
                                                        "")
                                                ? child
                                                : const CircularProgressIndicator(),
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          height: 80.h,
                                          width: 300.w,
                                          color: AppColors.PrimaryWhiteColor,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                dashboardCourseDetail[index]
                                                    .university
                                                    .toString(),
                                                maxLines: 2,
                                                style: OtpText(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        height: 80.h,
                                        width: 300.w,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        dashboardCourseDetail[index]
                                            .course
                                            .toString(),
                                        maxLines: 2,
                                        style: batchtext2(
                                            AppColors.PrimaryMainColor),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        dashboardCourseDetail[index]
                                            .university
                                            .toString(),
                                        maxLines: 1,
                                        style: batchtext1(
                                            AppColors.PrimaryBlackColor),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        dashboardCourseDetail[index]
                                            .fees
                                            .toString(),
                                        style: batchtext2(
                                            AppColors.PrimaryBlackColor),
                                      ),
                                    ],
                                  ),
                                ),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: dashboardUniversityDetail.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => const TopUniversityList(),
                                arguments: [
                                  dashboardUniversityDetail[index].countryId,
                                  dashboardUniversityDetail[index].universityId,
                                ],
                              );
                            },
                            child: Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.network(
                                        dashboardUniversityDetail[index]
                                            .universityImage
                                            .toString(),
                                        height: 40.h,
                                        width: 80.w,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      dashboardUniversityDetail[index]
                                          .university
                                          .toString(),
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      style: batchtext2(
                                          AppColors.PrimaryBlackColor),
                                    )
                                  ],
                                ),
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
                          "Popular Country Courses",
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
                        itemCount: dashboardCountryDetail.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    () => const UniversityListPage(),
                                    arguments: [
                                      dashboardCountryDetail[index].countryId,
                                      dashboardCountryDetail[index].country
                                    ],
                                  );
                                },
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: double.maxFinite,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        dashboardCountryDetail[index]
                                                        .countryImg
                                                        .toString() !=
                                                    "" &&
                                                dashboardCountryDetail[index]
                                                        .countryImg
                                                        .toString() !=
                                                    "null"
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(
                                                  dashboardCountryDetail[index]
                                                      .countryImg
                                                      .toString(),
                                                ),
                                                radius: 40.r,
                                              )
                                            : CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage:
                                                    const AssetImage(
                                                        "assets/images/c1.png"),
                                                radius: 40.r,
                                              ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          dashboardCountryDetail[index]
                                              .country
                                              .toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor),
                                        ),
                                        Text(
                                          "Courses ${dashboardCountryDetail[index].universityCount}",
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor),
                                        )
                                      ],
                                    ),
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
