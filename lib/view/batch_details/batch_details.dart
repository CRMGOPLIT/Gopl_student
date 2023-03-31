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
  bool loanding = true;
  late DashBoardBloc dashBoardBloc;
  List<BatchDetailsModel> data = [];
  List BatchData = [];

  // @override
  // void initState() {
  //   dashBoardBloc = DashBoardBloc();
  //   getBranchDetails();
  //   _gethomeData();
  //   super.initState();
  // }

  // getBranchDetails() async {
  //   await dashBoardBloc.batchControllerStream.listen((event) {
  //     if (event != null) {
  //       BatchData = event;
  //       for (int i = 0; i < BatchData.length; i++) {
  //         BatchDetailsModel branchDetailsModel =
  //             BatchDetailsModel.fromJson(event[i]);
  //         data.add(branchDetailsModel);
  //       }
  //       setState(() {
  //         loanding = false;
  //       });
  //     }
  //   });
  // }

  // _gethomeData() {
  //   dashBoardBloc.callGetBatchDetailsApi();
  // }

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
    SaveName();
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
  List BatchData = [];
  int? avl;

  getBranchDetails() async {
    await dashBoardBloc.batchControllerStream.listen((event) {
      if (event != null) {
        BatchData = event;
        for (int i = 0; i < BatchData.length; i++) {
          BatchDetailsModel branchDetailsModel =
              BatchDetailsModel.fromJson(event[i]);

          data.add(branchDetailsModel);
          // int cf = data[i].confirmedWithFullPayment;
          // int cp = data[i].confirmedWithPartialPayment;
          // int totl = int.parse(data[i].fBatchSize);

          // avl = totl - (cf + cp);
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
  SaveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    sName = prefs.getString('Name');
  }

  @override
  Widget build(BuildContext context) {
    return loanding == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
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
                                        image: data[index].fFacultyImag == null
                                            ? DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/fimg.png"),
                                                fit: BoxFit.cover,
                                              )
                                            : DecorationImage(
                                                image: NetworkImage(
                                                    data[index].fFacultyImag),
                                                fit: BoxFit.cover,
                                                onError:
                                                    (exception, stackTrace) {
                                                  data[index].fFacultyImag !=
                                                          null
                                                      ? Image.asset(
                                                          "assets/images/fimg.png")
                                                      : Text("oke;okn");
                                                },
                                              ),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Name :- ',
                                            style: batchtext1(
                                                AppColors.PrimaryBlackColor),
                                            children: [
                                              TextSpan(
                                                text: data[index]
                                                    .fFacultyName
                                                    .toString(),
                                                style: batchtext2(AppColors
                                                    .PrimaryBlackColor),
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
                                            style: batchtext1(
                                                AppColors.PrimaryBlackColor),
                                            children: [
                                              TextSpan(
                                                text: data[index]
                                                    .fFacultyGrade
                                                    .toString(),
                                                style: batchtext2(AppColors
                                                    .PrimaryBlackColor),
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
                                            style: batchtext1(
                                                AppColors.PrimaryBlackColor),
                                            children: [
                                              TextSpan(
                                                text: data[index]
                                                    .fIsOffline
                                                    .toString(),
                                                style: batchtext2(AppColors
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Batch Name :- ',
                                      style: batchtext1(
                                          AppColors.PrimaryBlackColor),
                                      children: [
                                        TextSpan(
                                          text:
                                              data[index].fBatchName.toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 170.w,
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: 'Start Date :- ',
                                            style: batchtext1(
                                                AppColors.PrimaryBlackColor),
                                            children: [
                                              TextSpan(
                                                text: data[index]
                                                    .fBatchStartDate
                                                    .toString(),
                                                style: batchtext2(AppColors
                                                    .PrimaryBlackColor),
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
                                            style: batchtext1(
                                                AppColors.PrimaryBlackColor),
                                            children: [
                                              TextSpan(
                                                text: data[index]
                                                    .fBatchEndDate
                                                    .toString(),
                                                style: batchtext2(AppColors
                                                    .PrimaryBlackColor),
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
                                            style: batchtext1(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            data[index].fBatchSize.toString(),
                                            textAlign: TextAlign.center,
                                            style: batchtext2(
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
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Time",
                                            style: batchtext1(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            data[index].fBatchTiming.toString(),
                                            textAlign: TextAlign.center,
                                            style: batchtext2(
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
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Available",
                                            style: batchtext1(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          //                             cf = data[index].confirmedWithFullPayment;
                                          // int cp = data[i].confirmedWithPartialPayment;
                                          // int totl = int.parse(data[i].fBatchSize);

                                          Text(
                                            avalible(index).toString(),
                                            //  -  data[index]
                                            //         .confirmedWithPartialPayment,

                                            textAlign: TextAlign.center,
                                            style: batchtext2(
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
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Enrolled",
                                            style: batchtext1(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                          SizedBox(
                                            height: 10.h,
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
                                              style: batchtext2(
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
