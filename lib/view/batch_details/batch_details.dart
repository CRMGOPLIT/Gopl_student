import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/batchModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BatchDetails extends StatefulWidget {
  const BatchDetails({super.key});

  @override
  State<BatchDetails> createState() => _BatchDetailsState();
}

class _BatchDetailsState extends State<BatchDetails> {
  List<BatchDetailsModel> data = [];

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
        body: ListBatch(
          index: data.length,
        ));
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
    dashBoardBloc = DashBoardBloc();
    getBranchDetails();
    _gethomeData();
    saveName();
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

  bool loanding = true;
  late DashBoardBloc dashBoardBloc;
  List<BatchDetailsModel> data = [];
  List batchData = [];
  int? avl;

  getBranchDetails() async {
    dashBoardBloc.batchControllerStream.listen((event) {
      if (event != null) {
        batchData = event;
        for (int i = 0; i < batchData.length; i++) {
          BatchDetailsModel branchDetailsModel =
              BatchDetailsModel.fromJson(event[i]);

          data.add(branchDetailsModel);
        }
        setState(() {
          loanding = false;
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callGetBatchDetailsApi();
  }

  String? sName;
  saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    sName = prefs.getString('Name');
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return loanding
        ? Center(
            child: CircularProgressIndicator(
            strokeWidth: 2.w,
            color: AppColors.PrimaryMainColor,
          ))
        : AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: _animate ? 1 : 0,
            curve: Curves.easeOutCubic,
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 700),
              padding: _animate
                  ? const EdgeInsets.all(2.0)
                  : const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 5)
                          .r,
                      child: Container(
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
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Row(
                                children: [
                                  Container(
                                    height: 60.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.PrimaryMainColor,
                                        image: data[index].fFacultyImag.isEmpty
                                            ? const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/fimg.png"),
                                                fit: BoxFit.cover,
                                              )
                                            : DecorationImage(
                                                image: NetworkImage(
                                                    data[index].fFacultyImag),
                                                fit: BoxFit.cover,
                                              ),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Name :- ',
                                            style: batchtext2(
                                                AppColors.PrimaryBlackColor),
                                            children: [
                                              TextSpan(
                                                text: data[index]
                                                    .fFacultyName
                                                    .toString(),
                                                style: batchtext1(AppColors
                                                    .PrimaryBlackColor),
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
                                            style: batchtext2(
                                                AppColors.PrimaryBlackColor),
                                            children: [
                                              TextSpan(
                                                text: data[index]
                                                    .fFacultyGrade
                                                    .toString(),
                                                style: batchtext1(AppColors
                                                    .PrimaryBlackColor),
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
                                            style: batchtext2(
                                                AppColors.PrimaryBlackColor),
                                            children: [
                                              TextSpan(
                                                text: data[index]
                                                    .fIsOffline
                                                    .toString(),
                                                style: batchtext1(AppColors
                                                    .PrimaryBlackColor),
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
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Batch Name :- ',
                                      style: batchtext2(
                                          AppColors.PrimaryBlackColor),
                                      children: [
                                        TextSpan(
                                          text:
                                              data[index].fBatchName.toString(),
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          text: 'Start Date :- ',
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor),
                                          children: [
                                            TextSpan(
                                              text: data[index]
                                                  .fBatchStartDate
                                                  .toString(),
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          text: 'End Date :- ',
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor),
                                          children: [
                                            TextSpan(
                                              text: data[index]
                                                  .fBatchEndDate
                                                  .toString(),
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
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
                                height: 55.h,
                                width: 390.w,
                                decoration: BoxDecoration(
                                    color: AppColors.PrimaryMainColor,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Batch Size",
                                            style: batchtext2(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            data[index].fBatchSize.toString(),
                                            textAlign: TextAlign.center,
                                            style: batchtext1(
                                                AppColors.PrimaryWhiteColor),
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
                                      padding: const EdgeInsets.all(7.0).w,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Time",
                                            style: batchtext2(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            data[index].fBatchTiming.toString(),
                                            textAlign: TextAlign.center,
                                            style: batchtext1(
                                                AppColors.PrimaryWhiteColor),
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
                                        children: [
                                          Text(
                                            "Available",
                                            style: batchtext2(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            avalible(index).toString(),
                                            textAlign: TextAlign.center,
                                            style: batchtext1(
                                                AppColors.PrimaryWhiteColor),
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
                                        children: [
                                          Text(
                                            "Enrolled",
                                            style: batchtext2(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, RoutesName.home,
                                                  arguments: [
                                                    "name ",
                                                    "jdnwkk",
                                                    "wndopi"
                                                  ]);
                                            },
                                            child: Text(
                                              data[index]
                                                  .confirmedWithFullPayment
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: batchtext1(
                                                  AppColors.PrimaryWhiteColor),
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
                    );
                  })),
            ),
          );
  }

  avalible(int i) {
    int cf = data[i].confirmedWithFullPayment;
    int cp = data[i].confirmedWithPartialPayment;
    int totl = int.parse(data[i].fBatchSize);

    return totl - (cf + cp);
  }
}
