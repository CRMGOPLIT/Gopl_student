
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
import 'package:global_student/view/dashboard/dash_grid_model.dart';
import 'package:global_student/view/widget/app_bar.dart';

class CourseSerach extends StatefulWidget {
  const CourseSerach({super.key});

  @override
  State<CourseSerach> createState() => _CourseSerachState();
}

// final randomIndex = Random().nextInt(Countrycourse[i].image);
// final imageUrl = images[randomIndex];
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
    // TODO: implement initState
    getdata();
    // getSearchCountry();
    getsearchDashboard();
    super.initState();
  }

  // getSearchCountry() async {
  //   searchBloc.getcountrysearchStream.listen((event) {
  //     if (event != null) {
  //       // debugger();
  //       // print(event);

  //       cuntrydata = event;

  //       for (int i = 0; i < cuntrydata.length; i++) {
  //         CountrySearchModel countrySearchModel =
  //             CountrySearchModel.fromJson(event[i]);

  //         countrySearchdata.add(countrySearchModel);

  //         setState(() {
  //           loading = false;

  //           //print(location);
  //         });
  //       }
  //     }
  //   });
  // }

  getsearchDashboard() async {
    searchBloc.getdashboardsearchStream.listen((event) {
      if (event != null) {
        // debugger();
        // print(event);

        //searchdashdata = event;

        // for (int i = 0; i < cuntrydata.length; i++) {
        SearchDashBoard searchDashBoard = SearchDashBoard.fromJson(event);

        dashboardCourseDetail.addAll(searchDashBoard.dashboardCourseDetail);
        dashboardUniversityDetail
            .addAll(searchDashBoard.dashboardUniversityDetail);
        dashboardCountryDetail.addAll(searchDashBoard.dashboardCountryDetail);

        setState(() {
          loading = false;

          //print(location);
        });
      }
      // }
    });
  }

  getdata() {
    // searchBloc.callGetCountrySearchApi();
    searchBloc.callSearchDashSearchApi();
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
            Navigator.pushNamed(context, RoutesName.bottomnav);
          },
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
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
                        // Text(
                        //   "View All",
                        //   style: FieldTextStyle(
                        //     AppColors.PrimaryMainColor,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 215.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: dashboardCourseDetail.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(
                                CourseDetails(),
                                arguments: [
                                  dashboardCourseDetail[index].courseId,
                                  // dashboardCountryDetail[index].country
                                ],
                                // countrySearchdata[index].name
                              );
                            },
                            child: Container(
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
                                              : CircularProgressIndicator(),
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        height: 80,
                                        width: 300,
                                        color: AppColors.PrimaryWhiteColor,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              dashboardCourseDetail[index]
                                                  .university
                                                  .toString(),
                                              maxLines: 2,
                                              style: OtpText(
                                                  AppColors.PrimaryBlackColor),
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
                                      //"Master of Science in Computer Science with Big Data and Artificial Intelligence",
                                      maxLines: 3,
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
                                      maxLines: 2,
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
                        // Text(
                        //   "View All",
                        //   style: FieldTextStyle(
                        //     AppColors.PrimaryMainColor,
                        //   ),
                        // ),
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
                                TopUniversityList(),
                                arguments: [
                                  dashboardUniversityDetail[index].countryId,
                                  dashboardUniversityDetail[index].universityId,

                                  // dashboardCountryDetail[index].country
                                ],
                                // countrySearchdata[index].name
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
                                    // : Text(
                                    //     dashboardUniversityDetail[index]
                                    //         .university
                                    //         .toString(),
                                    //     maxLines: 2,
                                    //     style: batchtext2(
                                    //         AppColors.PrimaryBlackColor),
                                    //   )
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
                        itemCount: dashboardCountryDetail.length,
                        itemBuilder: (context, index) {
                          final randomIndex =
                              Random().nextInt(Countrycourse.length);
                          final imageUrl = Countrycourse[randomIndex].image;
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    UniversityListPage(),
                                    arguments: [
                                      dashboardCountryDetail[index].countryId,
                                      dashboardCountryDetail[index].country
                                    ],
                                    // countrySearchdata[index].name
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
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: AssetImage(
                                            //   "https://source.unsplash.com/random/"
                                            imageUrl.toString(),
                                          ),
                                          radius: 40,
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
                                          "Courses " +
                                              dashboardCountryDetail[index]
                                                  .universityCount
                                                  .toString(),
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
