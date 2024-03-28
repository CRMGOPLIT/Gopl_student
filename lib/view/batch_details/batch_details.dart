import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/batchperformadetailsBloc.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/batchModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/loader.dart';
import 'package:lottie/lottie.dart';
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

  late BatchperformaBloc batchperformaBloc;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  static bool _isStart = true;
  var data2 = Get.arguments;

  @override
  void initState() {
    batchperformaBloc = BatchperformaBloc();
    dashBoardBloc = DashBoardBloc();
    getBranchDetails();
    batchdetailslist();
    saveName();
    succesEmail();
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
    super.initState();
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

  String? studentid;
  batchdetailslist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");

    String spselcected = data2[0].toString();
    Map<String, String> data = {
      "BatchType": spselcected.toString(),
      "StudentId": studentid.toString(),
    };

    dashBoardBloc.callGetBatchDetailsApi(data);
  }

  String? sName;
  saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    sName = prefs.getString('Name');
  }

  List<Color> colors = [];

  List<Color> generateRandomColors() {
    List<Color> colorList = [
      const Color(0xffEEF5FF),
      const Color(0xffFFEEF0),
      const Color(0xffF4F3FF),
      const Color(0xffF2F9F6),
      const Color(0xffF9F2F6),
      const Color(0xffFFEEF9),
      const Color(0xffFFF6EE),
      const Color(0xffF3FCFF),
    ];

    colorList.shuffle(Random());
    return colorList;
  }

  Color getRandomColor() {
    if (colors.isEmpty) {
      colors = generateRandomColors();
    }
    return colors.removeLast();
  }

  succesEmail() {
    batchperformaBloc.applybatchemailStream.listen((event) {
      Navigator.pop(context);

      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true && event.data['Status'] == 'Success') {
        sucess();
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.batchlist,
            (routes) => false,
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(milliseconds: 1000),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Search your batch',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                          "Already Applied ${event.data['BatchID'].toString()} ",
                          style: batchtext1(
                            AppColors.PrimaryWhiteColor,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    });
  }

  searchFilter(String batchname) async {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");
    Map<String, String> courseAppliedemail = {
      "BatchType": batchname.toString(),
      "StudentId": studentid.toString()
    };

    batchperformaBloc.callbatchapplyemail(courseAppliedemail);
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
                            color: getRandomColor(),
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
                              padding: const EdgeInsets.all(10.0).r,
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
                                          Row(
                                            children: [
                                              // ImageIcon(
                                              //   AssetImage(
                                              //       "assets/images/b4.png"),
                                              // ),
                                              Text(
                                                data[index]
                                                    .fFacultyName
                                                    .toString(),
                                                style: batchtexthead(AppColors
                                                    .PrimaryBlackColor),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
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
                                                  style:
                                                      batchtext2(Colors.green),
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
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor),
                                          children: [
                                            TextSpan(
                                              text: data[index]
                                                  .fBatchName
                                                  .toString(),
                                              style: batchtext2(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeExtension(5).h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
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
                                          RichText(
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                    ],
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
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
                                                style: batchtext1(AppColors
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
                                                style: batchtext2(AppColors
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
                                                style: batchtext1(AppColors
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
                                                style: batchtext2(AppColors
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
                                                style: batchtext1(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                avalible(index).toString(),
                                                textAlign: TextAlign.center,
                                                style: batchtext2(AppColors
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
                                                style: batchtext1(AppColors
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
                                                style: batchtext2(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  data[index].fBatchName.toString() ==
                                          data[index].status.toString()
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                "assets/images/bannerlogo.png",
                                                height: 40.h,
                                                width: 150.w,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  RoutesName.batchperforma,
                                                );
                                              },
                                              child: Container(
                                                  width: 100,
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                                  5)
                                                              .r),
                                                  child: Center(
                                                      child: Text(
                                                    "Proforma",
                                                    style: batchtexthead(
                                                        AppColors
                                                            .PrimaryWhiteColor),
                                                  ))),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                "assets/images/bannerlogo.png",
                                                height: 40.h,
                                                width: 150.w,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                searchFilter(
                                                  data[index]
                                                      .fBatchName
                                                      .toString(),
                                                );
                                                //    sucess();
                                                // Navigator.pushNamed(
                                                //   context,
                                                //   RoutesName.batchperforma,
                                                //   // (routes) => false,
                                                // );
                                              },
                                              child: Container(
                                                  width: 100,
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .PrimaryMainColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                                  5)
                                                              .r),
                                                  child: Center(
                                                      child: Text(
                                                    "Interested",
                                                    style: batchtexthead(
                                                        AppColors
                                                            .PrimaryWhiteColor),
                                                  ))),
                                            ),
                                          ],
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
    int cf = int.parse(data[i].confirmedWithFullPayment.toString());
    int cp = int.parse(data[i].confirmedWithPartialPayment.toString());
    int totl = int.parse(data[i].fBatchSize.toString());
    return totl - (cf + cp);
  }

  sucess() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xffF2F9F6),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                  height: 90.h,
                  child: Lottie.asset("assets/images/sucess1.json",
                      fit: BoxFit.contain)),
            ],
          ),
        ),
        content: Text(
          "🤗 Hey,Thank you for Applying Batch. We Will Contact Soon..",
          textAlign: TextAlign.center,
          style: batchtext2(AppColors.PrimaryMainColor),
        ),
      ),
    );
  }
}
