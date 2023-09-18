import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  var data2 = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "${data2[0]} Course",
            onpress: () {
              Navigator.pushNamed(context, RoutesName.batchlist);
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
  var data2 = Get.arguments;

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
    Map<String, String> data = {
      "BatchType": data2[0].toString(),
    };

    dashBoardBloc.callGetBatchDetailsApi(data);
  }

  String? sName;
  saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    sName = prefs.getString('Name');
  }

  @override
  Widget build(BuildContext context) {
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
              child: data.isEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80.h,
                          ),
                          Center(
                              child: Image.asset(
                            "assets/images/class.png",
                            height: 250.h,
                            width: 280.w,
                            fit: BoxFit.contain,
                          )),
                          Text("Batch coming soon please wait..👨🏼‍💻",
                              style: H2TextStyle(AppColors.PrimaryMainColor)),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            bottom: 5,
                          ).r,
                          child: Card(
                            elevation: 4,
                            borderOnForeground: true,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color:
                                    AppColors.PrimaryMainColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: '',
                                              style: batchtext2(
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
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Batch Name :- ',
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor),
                                          children: [
                                            TextSpan(
                                              text: data[index]
                                                  .fBatchName
                                                  .toString(),
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
                                                  style: batchtext1(AppColors
                                                      .PrimaryBlackColor),
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
                                                  style: batchtext1(AppColors
                                                      .PrimaryBlackColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                    ],
                                  ),
                                  Card(
                                    elevation: 4,
                                    color: AppColors.backgroungcolor,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: AppColors.PrimaryMainColor
                                            .withOpacity(0.3),
                                      ),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Batch Size",
                                                style: batchtext2(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                data[index]
                                                    .fBatchSize
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: batchtext1(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 40.h,
                                          width: 1.w,
                                          color: AppColors.PrimaryBlackColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0).w,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Time",
                                                style: batchtext2(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                data[index]
                                                    .fBatchTiming
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: batchtext1(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 40.h,
                                          width: 1.w,
                                          color: AppColors.PrimaryBlackColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Available",
                                                style: batchtext2(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                avalible(index).toString(),
                                                textAlign: TextAlign.center,
                                                style: batchtext1(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 40.h,
                                          width: 1.w,
                                          color: AppColors.PrimaryBlackColor,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(7.r),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Enrolled",
                                                style: batchtext2(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                data[index]
                                                    .confirmedWithFullPayment
                                                    .toString(),
                                                textAlign: TextAlign.center,
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
