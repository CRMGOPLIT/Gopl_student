import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/searchBloc.dart';
import 'package:global_student/model/filtersearch.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/widget/app_bar.dart';
import '../../networking/NetworkConstant.dart';
import '../../utils/color.dart';
import '../../utils/routes/routes_name.dart';
import '../course_details/course_details.dart';

class UniversityListPage extends StatefulWidget {
  const UniversityListPage({super.key});

  @override
  State<UniversityListPage> createState() => _UniversityListPageState();
}

class _UniversityListPageState extends State<UniversityListPage> {
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
      NetworkConstant.universityId: "",
      NetworkConstant.fRequest: "CRM",
      NetworkConstant.crmAccessRequest: "Country Manager",
    };
    searchBloc.callGetFilterSearch(filterdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: data2[1].toString(),
          onpress: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.courseSearch,
              (routes) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: loading
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
                          itemCount:
                              hasmore ? objCourse.length : objCourse.length + 1,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index < objCourse.length) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    const CourseDetails(),
                                    arguments: [
                                      objCourse[index].fCourseDetailId,
                                    ],
                                  );
                                },
                                child: Card(
                                  elevation: 3,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      onForegroundImageError:
                                          (exception, stackTrace) => {
                                        const AssetImage(
                                            "assets/images/c1.png"),
                                      },
                                      backgroundColor:
                                          AppColors.PrimaryMainColor,
                                      radius: 30.r,
                                      foregroundImage: NetworkImage(
                                        objCourse[index].logo.toString(),
                                      ),
                                    ),
                                    title: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 5.sp, top: 10.sp),
                                      child: Text(
                                        objCourse[index].fUniversity,
                                        style: batchtext2(
                                            AppColors.PrimaryMainColor),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 10.sp, top: 5.sp),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            objCourse[index].fProgram.trim(),
                                            textAlign: TextAlign.start,
                                            style: batchtext1(
                                                AppColors.PrimaryBlackColor),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            objCourse[index]
                                                .fCountryName
                                                .toString(),
                                            style: batchtext1(Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                "no data ",
                                style: batchtext2(AppColors.PrimaryMainColor),
                              ));
                            }
                          })),
                  if (isloadingmore)
                    Padding(
                      padding: const EdgeInsets.all(10).w,
                      child: CircularProgressIndicator(
                        color: AppColors.PrimaryMainColor,
                        strokeWidth: 2.w,
                      ),
                    )
                ],
              ),
      ),
    );
  }
}
