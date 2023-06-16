// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:global_student/bloc/searchBloc.dart';
// import 'package:global_student/model/universitySearchModel.dart';
// import 'package:global_student/utils/text_style.dart';
// import 'package:global_student/view/widget/app_bar.dart';
// import '../../utils/color.dart';
// import '../../utils/routes/routes_name.dart';

// class UniversityListPage extends StatefulWidget {
//   const UniversityListPage({super.key});

//   @override
//   State<UniversityListPage> createState() => _UniversityListPageState();
// }

// class _UniversityListPageState extends State<UniversityListPage> {
//   late SearchBloc searchBloc;
//   List<UniversitySearchModel> universitySearchdata = [];

//   List universitydata = [];
//   bool loanding = true;
//   var data2 = Get.arguments;
//   final scrollController = ScrollController();
//   int page = 1;
//   bool isloadingmore = false;
//   int limit = 8;
//   bool hasmore = true;

//   List<String> _items = [];

//   final int _pageSize = 10;

//   List<String> items = List.generate(8, (index) => "${index + 1}");

//   @override
//   void initState() {
//     searchBloc = SearchBloc();
//     // scrollController.addListener(_scrollListener);
//     super.initState();
//     GetUniversity();
//     calluniverstty();

//     scrollController.addListener(() async {
//       if (scrollController.offset ==
//           scrollController.position.maxScrollExtent) {
//         GetUniversity();
//       }
//     });
//   }

//   void GetUniversity() async {
//     if (!isloadingmore && hasmore) {
//       isloadingmore = true;
//       setState(() {});

//       await searchBloc.getuniversitysearchStream.listen((event) async {
//         if (event != null) {
//           universitydata = event;

//           for (int i = 0; i < universitydata.length; i++) {
//             UniversitySearchModel universitySearchModel =
//                 UniversitySearchModel.fromJson(event[i]);
//             universitySearchdata.add(universitySearchModel);
//             // await Future.delayed(Duration(seconds: 4));
//             // List<String> loadedItems = items.length > 40
//             //     ? []
//             //     : List.generate(_pageSize,
//             //         (index) => 'Item ${universitySearchdata.length + 1}');

//             // _items.addAll(loadedItems);
//             if (_items.isEmpty) {
//               hasmore = false;
//             }
//             isloadingmore = false;
//             setState(() {
//               loanding = false;
//             });
//           }
//         }
//       });
//     }
//   }

//   calluniverstty() {
//     String spselcected = data2[0].toString();
//     Map<String, dynamic> data = {"countryId": spselcected};
//     searchBloc.callGetUniversitySearchApi(data);
//   }

//   // Future<void> _scrollListener() async {
//   //   // if (isloadingmore) return;
//   //   if (scrollController.offset == scrollController.position.maxScrollExtent) {
//   //     // page = page + 1;
//   //     // setState(() {
//   //     //   isloadingmore = false;
//   //     // });
//   //     GetUniversity();
//   //     // setState(() {
//   //     //   isloadingmore = true;
//   //     // });
//   //   }
//   // }

//   text1(int index) {
//     var output;
//     for (int i = 0; i < universitySearchdata.length; i++) {
//       output = universitySearchdata[index].name;
//     }
//     return output[0];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroungcolor,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50.h),
//         child: AppBarCustom(
//           title: data2[1].toString(),
//           onpress: () {
//             Navigator.pushNamed(context, RoutesName.courseSearch);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: loanding
//             ? Center(
//                 child: CircularProgressIndicator(
//                   color: AppColors.PrimaryMainColor,
//                 ),
//               )
//             : Column(
//                 children: [
//                   //  Text(universitySearchdata.length.toString()),
//                   Expanded(
//                       child: ListView.builder(
//                           controller: scrollController,
//                           itemCount: hasmore
//                               ? universitySearchdata.length
//                               : universitySearchdata.length + 1,
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             if (index < universitySearchdata.length) {
//                               return InkWell(
//                                 onTap: () {},
//                                 child: Card(
//                                   elevation: 3,
//                                   child: ListTile(
//                                     leading: Container(
//                                       // padding: EdgeInsets.all(10),
//                                       height: 50.h,
//                                       width: 50.w,
//                                       decoration: BoxDecoration(
//                                           color: AppColors.PrimaryMainColor,
//                                           borderRadius:
//                                               BorderRadius.circular(40)),
//                                       child: Center(
//                                           child: Text(
//                                         text1(index),
//                                         style: hometext(
//                                             AppColors.PrimaryWhiteColor),
//                                       )),
//                                     ),
//                                     title: Padding(
//                                       padding: EdgeInsets.only(
//                                           bottom: 5.sp, top: 10.sp),
//                                       child: Text(
//                                         universitySearchdata[index].name,
//                                         // universitySearchdata[index]
//                                         //     .name
//                                         //     .toString(),
//                                         style: batchtext2(
//                                             AppColors.PrimaryMainColor),
//                                       ),
//                                     ),
//                                     subtitle: Padding(
//                                       padding: EdgeInsets.only(
//                                           bottom: 10.sp, top: 5.sp),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Go fair Start 23 March In Delhi. Visit Our WebSite. ",
//                                             style: batchtext1(
//                                                 AppColors.PrimaryBlackColor),
//                                           ),
//                                           SizedBox(
//                                             height: 8.h,
//                                           ),
//                                           Text(
//                                             "13 Mar At 9:00 AM ",
//                                             style: batchtext1(Colors.grey),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: isloadingmore
//                                     ? Center(child: CircularProgressIndicator())
//                                     : Text("no data "),
//                               );
//                             }
//                           })),
//                   if (isloadingmore)
//                     Padding(
//                       padding: EdgeInsets.all(10),
//                       child: CircularProgressIndicator(),
//                     )
//                 ],
//               ),
//       ),
//     );
//   }
// }

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
    // scrollController.addListener(_scrollListener);
    super.initState();
    getListofuniversity();

    searchFilter();
    // GetCourseData();
    // callcourseDetails();
  }

  void dispose() {
    super.dispose();
    scrollController.dispose();
    // getListofuniversity();
  }

  getListofuniversity() async {
    searchBloc.getfiltersearchStream.listen((event) {
      // Navigator.pop(context);

      // debugger();
      // print(event);
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
    // if (isloadingmore) return;
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
    //  NetworkDialogLoading.showLoadingDialog(context, _keyLoader);
    // String spselcected = "";
    // String uniselected = "";
    // String spdispline = "";
    // String studyarea = "";
    // String program = "";
    // String intake = "";
    // String location = "";
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

  text1(int index) {
    var output;
    for (int i = 0; i < objCourse.length; i++) {
      output = objCourse[index].fUniversity;
    }
    return output[0];
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
            Navigator.pushNamed(context, RoutesName.courseSearch);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.PrimaryMainColor,
                ),
              )
            : Column(
                children: [
                  //  Text(universitySearchdata.length.toString()),
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
                                    CourseDetails(),
                                    arguments: [
                                      objCourse[index].fCourseDetailId,
                                      // dashboardCountryDetail[index].country
                                    ],
                                    // countrySearchdata[index].name
                                  );
                                },
                                child: Card(
                                  elevation: 3,
                                  child: ListTile(
                                    leading: Container(
                                        // padding: EdgeInsets.all(10),
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.PrimaryMainColor,
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            image:
                                                objCourse[index].logo == "null"
                                                    ? DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/account.png"),
                                                        fit: BoxFit.fill,
                                                      )
                                                    : DecorationImage(
                                                        image: NetworkImage(
                                                          objCourse[index]
                                                              .logo
                                                              .toString(),
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ))),
                                    //   child: objCourse[index]
                                    //               .logo
                                    //               .split(".svg") ==
                                    //           ".svg"
                                    //       ? Text("ejj")
                                    //       : CircleAvatar(
                                    //           radius: 30,
                                    //           backgroundColor:
                                    //               AppColors.PrimaryMainColor,
                                    //           backgroundImage: NetworkImage(
                                    //             objCourse[index].logo,
                                    //           ),
                                    //         ),
                                    // ),
                                    //   child: Container(
                                    //     height: 50.h,
                                    //     width: 50.w,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(40)),
                                    //     child: Image.network(
                                    //       objCourse[index].logo.toString(),
                                    //       height: 30.h,
                                    //       width: 40.w,
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    // ),
                                    title: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 5.sp, top: 10.sp),
                                      child: Text(
                                        objCourse[index].fUniversity,
                                        // universitySearchdata[index]
                                        //     .name
                                        //     .toString(),
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
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: isloadingmore
                                    ? Center(child: CircularProgressIndicator())
                                    : Text("no data "),
                              );
                            }
                          })),
                  if (isloadingmore)
                    Padding(
                      padding: EdgeInsets.all(10),
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
