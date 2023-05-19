import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:global_student/bloc/searchBloc.dart';
import 'package:global_student/model/universitySearchModel.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';
import '../../utils/color.dart';
import '../../utils/routes/routes_name.dart';

class UniversityListPage extends StatefulWidget {
  const UniversityListPage({super.key});

  @override
  State<UniversityListPage> createState() => _UniversityListPageState();
}

class _UniversityListPageState extends State<UniversityListPage> {
  late SearchBloc searchBloc;
  List<UniversitySearchModel> universitySearchdata = [];

  List universitydata = [];
  bool loanding = true;
  var data2 = Get.arguments;
  final scrollController = ScrollController();
  int page = 1;
  bool isloadingmore = false;
  int limit = 8;
  bool hasmore = true;

  List<String> _items = [];
  int _currentPage = 1;
  bool _isLoading = false;

  final int _pageSize = 10;

  List<String> items = List.generate(8, (index) => "${index + 1}");

  @override
  void initState() {
    searchBloc = SearchBloc();
    // scrollController.addListener(_scrollListener);
    super.initState();
    GetUniversity();
    calluniverstty();

    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        // page = page + 1;
        // setState(() {
        //   isloadingmore = false;
        // });
        GetUniversity();
        // setState(() {
        //   isloadingmore = true;
        // });
      }
    });
  }

  void GetUniversity() async {
    if (!isloadingmore && hasmore) {
      isloadingmore = true;
      setState(() {});

      await searchBloc.getuniversitysearchStream.listen((event) async {
        if (event != null) {
          universitydata = event;

          for (int i = 0; i < universitydata.length; i++) {
            UniversitySearchModel universitySearchModel =
                UniversitySearchModel.fromJson(event[i]);
            universitySearchdata.add(universitySearchModel);
            await Future.delayed(Duration(seconds: 4));
            List<String> loadedItems = items.length > 40
                ? []
                : List.generate(_pageSize,
                    (index) => 'Item ${universitySearchdata.length + 1}');

            _items.addAll(loadedItems);
            if (_items.isEmpty) {
              hasmore = false;
            }
            isloadingmore = false;
            setState(() {
              loanding = false;
            });
          }
        }
      });
    }
  }

  calluniverstty() {
    String spselcected = data2[0].toString();
    Map<String, dynamic> data = {"countryId": spselcected};
    searchBloc.callGetUniversitySearchApi(data);
  }

  // Future<void> _scrollListener() async {
  //   // if (isloadingmore) return;
  //   if (scrollController.offset == scrollController.position.maxScrollExtent) {
  //     // page = page + 1;
  //     // setState(() {
  //     //   isloadingmore = false;
  //     // });
  //     GetUniversity();
  //     // setState(() {
  //     //   isloadingmore = true;
  //     // });
  //   }
  // }

  text1(int index) {
    var output;
    for (int i = 0; i < universitySearchdata.length; i++) {
      output = universitySearchdata[index].name;
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
        child: loanding
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
                              hasmore ? _items.length : _items.length + 1,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index < _items.length) {
                              return InkWell(
                                onTap: () {},
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
                                              BorderRadius.circular(40)),
                                      child: Center(
                                          child: Text(
                                        "A",
                                        //  text1(index),
                                        style: hometext(
                                            AppColors.PrimaryWhiteColor),
                                      )),
                                    ),
                                    title: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 5.sp, top: 10.sp),
                                      child: Text(
                                        "dnlknkn'e",
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
                                        children: [
                                          Text(
                                            "Go fair Start 23 March In Delhi. Visit Our WebSite. ",
                                            style: batchtext1(
                                                AppColors.PrimaryBlackColor),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            "13 Mar At 9:00 AM ",
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
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
      ),
    );
  }
}
