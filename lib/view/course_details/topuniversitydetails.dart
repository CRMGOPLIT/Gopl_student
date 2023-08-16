import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/searchBloc.dart';
import 'package:global_student/model/filtersearch.dart';
import 'package:global_student/networking/NetworkConstant.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/course_details/course_details.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/widget/app_bar.dart';

class TopUniversityList extends StatefulWidget {
  const TopUniversityList({super.key});

  @override
  State<TopUniversityList> createState() => _TopUniversityListState();
}

class _TopUniversityListState extends State<TopUniversityList> {
  int page = 1;
  bool loading = true;
  bool hasmore = true;
  var data2 = Get.arguments;
  bool isloadingmore = false;

  late SearchBloc searchBloc;
  final scrollController = ScrollController();

  List<ObjCourse> objCourse = [];

  @override
  void initState() {
    searchBloc = SearchBloc();
    scrollController.addListener(_scrollListener);

    super.initState();
    getListofuniversity();
    searchFilter();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  getListofuniversity() async {
    searchBloc.getfiltersearchStream.listen((event) {
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true) {
        FilterSeach filterSeach = FilterSeach.fromJson(event.data);

        if (filterSeach.objCourse.isNotEmpty) {
          objCourse.addAll(filterSeach.objCourse);
        } else {
          setState(() {
            hasmore = false;
          });
        }
      }
      if (objCourse.isEmpty) {
        hasmore = false;
      }
      isloadingmore = false;

      setState(() {
        loading = false;
      });
    });
  }

  Future<void> _scrollListener() async {
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      page = page + 1;
      setState(() {
        isloadingmore = false;
      });
      await searchFilter();
      setState(() {
        isloadingmore = true;
      });
    }
  }

  searchFilter() {
    Map<String, String> filterdata = {
      NetworkConstant.filterType: "Advance Search",
      NetworkConstant.pageNumber: page.toString(),
      NetworkConstant.sortBy: "",
      NetworkConstant.courseName: "",
      NetworkConstant.year: DateTime.now().year.toString(),
      NetworkConstant.intake: "",
      NetworkConstant.countryId: data2[0].toString(),
      NetworkConstant.scholarship: "",
      NetworkConstant.studyArea: "",
      NetworkConstant.disciplineArea: "",
      NetworkConstant.flocation: "",
      NetworkConstant.duration: "0",
      NetworkConstant.isIELTS: "",
      NetworkConstant.istOEFL: "",
      NetworkConstant.placement: "",
      NetworkConstant.ispte: "",
      NetworkConstant.issat: "",
      NetworkConstant.isACT: "",
      NetworkConstant.isGRE: "",
      NetworkConstant.isGMAT: "",
      NetworkConstant.deadlineAvailable: "",
      NetworkConstant.fifteenYearsOfEd: "",
      NetworkConstant.eslElp: "",
      NetworkConstant.conditionalOffer: "",
      NetworkConstant.programLevel: "",
      NetworkConstant.universityId: data2[1].toString(),
      NetworkConstant.fRequest: "CRM",
      NetworkConstant.crmAccessRequest: "Country Manager",
    };
    searchBloc.callGetFilterSearch(filterdata);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Courses",
          onpress: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.courseSearch,
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
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: objCourse.length + 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index < objCourse.length) {
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  () => const CourseDetails(),
                                  arguments: [
                                    objCourse[index].fCourseDetailId,
                                  ],
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                            title: Text(
                                                objCourse[index]
                                                    .fProgram
                                                    .toString(),
                                                style: batchtext2(AppColors
                                                    .PrimaryMainColor)),
                                            subtitle: Column(
                                              children: [
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: Image.network(
                                                        objCourse[index]
                                                            .logo
                                                            .toString(),
                                                        height: 30.h,
                                                        width: 40.w,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    SizedBox(
                                                      width: screenSize.width *
                                                          0.6,
                                                      child: Text(
                                                        objCourse[index]
                                                            .fUniversity
                                                            .toString(),
                                                        style: batchtext2(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    // Icon(Icons.map),
                                                    Image.asset(
                                                      "assets/images/worldmap.png",
                                                      height: 30.h,
                                                      width: 30.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    SizedBox(
                                                      width: 90.w,
                                                      child: Text(
                                                        objCourse[index]
                                                            .fCountryName
                                                            .toString(),
                                                        style: batchtext1(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Image.asset(
                                                      "assets/images/rupee.png",
                                                      height: 30.h,
                                                      width: 30.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "${objCourse[index].fCurrency} ${objCourse[index].fTuitionFee.toString().split(".")[0]}/${objCourse[index].fTermTuitionFee}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: batchtext1(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: hasmore
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: AppColors.PrimaryMainColor,
                                      strokeWidth: 2.w,
                                    ))
                                  : Center(
                                      child: Text(
                                      "No Data Found",
                                      style: batchtext2(
                                          AppColors.PrimaryMainColor),
                                    )),
                            );
                          }
                        })),
              ],
            ),
    );
  }
}
