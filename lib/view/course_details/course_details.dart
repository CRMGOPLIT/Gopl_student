import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/searchBloc.dart';
import 'package:global_student/model/coursedetailsmodel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  late SearchBloc searchBloc;
  List<CourseMoreDetails> coursemoredetails = [];

  List colordata = [
    Color(0xffc3ddd6),
    Color(0xffefc5b5),
    Color(0xfffbdd7e),
    Color(0xffeeaaff),
    Color(0xffBEFE9D),
    Color(0xff99FFEB),
    Color(0xffAD6AEB),
    Color(0xffF79DAA),
    Color(0xffF3AB6F),
  ];

  List coursedata = [];
  bool loanding = true;
  var data2 = Get.arguments;
  final scrollController = ScrollController();
  int page = 1;
  bool isloadingmore = false;
  int limit = 8;
  bool hasmore = true;

  List<String> items = List.generate(8, (index) => "${index + 1}");
  List yearList = [];

  showYear() {
    int year = DateTime.now().year;
    int yearfrom = year;
    int yearto = year + 2;
    for (int i = yearfrom; i <= yearto; i++) {
      yearList.add(i);
    }
  }

  @override
  void initState() {
    searchBloc = SearchBloc();
    // scrollController.addListener(_scrollListener);
    super.initState();
    GetCourseData();
    callcourseDetails();
  }

  void GetCourseData() async {
    if (!isloadingmore && hasmore) {
      isloadingmore = true;
      setState(() {});

      await searchBloc.coursemoredetailsStream.listen((event) async {
        if (event != null) {
          // debugger();
          // print(event);
          coursedata = event;

          for (int i = 0; i < coursedata.length; i++) {
            CourseMoreDetails courseDetails =
                CourseMoreDetails.fromJson(event[i]);
            coursemoredetails.add(courseDetails);
            log("dbnkjn" + coursedata.toString());

            setState(() {
              loanding = false;
            });
          }
        }
      });
    }
  }

  callcourseDetails() {
    String spselcected = data2[0].toString();
    Map<String, dynamic> data = {"CourseId": spselcected};
    searchBloc.callGetCourseDetails(data);
  }

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
      body: loanding
          ? Center(child: Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < coursemoredetails.length; i++)
                      SizedBox(
                        height: 10.h,
                      ),
                    for (int i = 0; i < coursemoredetails.length; i++)
                      // Center(
                      //   child: Image.network(
                      //     coursemoredetails[i].fUniversityLogo,
                      //     height: 120.h,
                      //     width: 300.w,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      Center(
                        child: Image.network(
                          coursemoredetails[0].fUniversityLogo.toString(),
                          loadingBuilder: (context, child, loadingProgress) =>
                              (loadingProgress == null ||
                                      coursemoredetails[0]
                                              .fUniversityLogo
                                              .toString() ==
                                          "")
                                  ? child
                                  : CircularProgressIndicator(),
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 120.h,
                            width: 300.w,
                            color: AppColors.PrimaryWhiteColor,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  coursemoredetails[0].fUniversity.toString(),
                                  maxLines: 2,
                                  style: OtpText(AppColors.PrimaryBlackColor),
                                ),
                              ),
                            ),
                          ),
                          height: 120.h,
                          width: 300.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    for (int i = 0; i < coursemoredetails.length; i++)
                      Center(
                        child: Text(
                          coursemoredetails[i].fUniversity,
                          style: OtpText(AppColors.PrimaryMainColor),
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    for (int i = 0; i < coursemoredetails.length; i++)
                      Text(
                        coursemoredetails[i].fAddress.toString().trim(),
                        //textAlign: TextAlign.center,
                        style: Text2Regular(AppColors.PrimaryBlackColor),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < coursemoredetails.length; i++)
                          Container(
                            height: 40.h,
                            width: 160.w,
                            decoration: BoxDecoration(
                                color: AppColors.PrimaryMainColor,
                                borderRadius: BorderRadius.circular(5.sp)),
                            child: ListTile(
                              leading: Text(
                                "QS Ranking :-  " +
                                    coursemoredetails[i].fNationalRank,
                                textAlign: TextAlign.center,
                                style: batchtext1(AppColors.PrimaryWhiteColor),
                              ),
                              // Image.asset(
                              //   "assets/images/ranklogo.png",
                              //   height: 30.h,
                              //   width: 30.w,
                              //   fit: BoxFit.cover,
                              // ),
                              // trailing: Text(
                              //   "QS Ranking" + coursemoredetails[i].fNationalRank,
                              //   style: TextRegular(AppColors.PrimaryWhiteColor),
                              // ),
                            ),
                          ),
                        for (int i = 0; i < coursemoredetails.length; i++)
                          Container(
                            height: 40.h,
                            width: 160.w,
                            decoration: BoxDecoration(
                                color: AppColors.PrimaryMainColor,
                                borderRadius: BorderRadius.circular(5.sp)),
                            child: ListTile(
                              leading: Text(
                                "GOPL Ranking :- " +
                                    coursemoredetails[i]
                                        .fGlobalOpsRanking
                                        .toString(),
                                style: batchtext1(AppColors.PrimaryWhiteColor),
                              ),
                              // Image.asset(
                              //   "assets/images/ranklogo.png",
                              //   height: 30.h,
                              //   width: 30.w,
                              //   fit: BoxFit.cover,
                              //   alignment: Alignment.center,
                              // ),
                              // trailing: Text(
                              //   "GOPL Ranking " +
                              //       coursemoredetails[i].ranking.toString(),
                              //   style: TextRegular(AppColors.PrimaryBlackColor),
                              // ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Text(
                        "Web Url",
                        style: OtpText(AppColors.PrimaryBlackColor),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    for (int i = 0; i < coursemoredetails.length; i++)
                      InkWell(
                        onTap: () async {
                          // const url = "${coursemoredetails[i].fUniversityUrl}";
                          if (await canLaunch(
                              coursemoredetails[i].fUniversityUrl)) {
                            await launch(coursemoredetails[i].fUniversityUrl);
                          } else {
                            throw 'Could not launch ${coursemoredetails[i].fUniversityUrl}';
                          }
                        },
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: 45.h,
                            width: 300.w,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.PrimaryBlackColor),
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                coursemoredetails[i].fUniversityUrl,
                                maxLines: 1,
                                style: location(AppColors.PrimaryMainColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          //color: AppColors.hintcolor,
                          borderRadius: BorderRadius.circular(5.sp)),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          "",
                          textAlign: TextAlign.start,
                          style: OtpText(AppColors.PrimaryMainColor),
                        ),
                      ),
                    ),
                    // Container(
                    //   height: 1.h,
                    //   width: double.infinity,
                    //   color: AppColors.PrimaryMainColor,
                    // ),
                    SizedBox(
                      height: 5.h,
                    ),

                    Text(
                      coursemoredetails[0].fProgram,
                      textAlign: TextAlign.center,
                      style: FieldTextStyle(AppColors.PrimaryMainColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Card(
                      elevation: 3,
                      child: ListTile(
                        // title: Padding(
                        //   padding: EdgeInsets.only(bottom: 1.sp, top: 10.sp),
                        //   child: Text(
                        //     "Course",
                        //     style: FieldTextStyle(AppColors.PrimaryBlackColor),
                        //   ),
                        // ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // for (int i = 0; i < coursemoredetails.length; i++)
                              //   Text(
                              //     coursemoredetails[i].fProgram,
                              //     style: batchtext2(AppColors.PrimaryBlackColor),
                              //   ),
                              SizedBox(
                                height: 5.h,
                              ),

                              coursefield(
                                title: "Intakes :-  ",
                                subtitle: coursemoredetails[0].fIntake,
                              ),

                              coursefield(
                                title: "Duration :- ",
                                subtitle: coursemoredetails[0].fDurationName,
                              ),

                              // SizedBox(
                              //   height: 5.h,
                              // ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "Course Url :-  ",
                              //       style: batchtext2(AppColors.PrimaryBlackColor),
                              //     ),
                              //     for (int i = 0; i < coursemoredetails.length; i++)
                              //       Text(
                              //         "",
                              //         style: batchtext1(AppColors.PrimaryBlackColor),
                              //       ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 5.h,
                              // ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "Application Url :-  ",
                              //       style: batchtext2(AppColors.PrimaryBlackColor),
                              //     ),
                              //     for (int i = 0; i < coursemoredetails.length; i++)
                              //       Text(
                              //         "",
                              //         style: batchtext2(AppColors.PrimaryBlackColor),
                              //       ),
                              //   ],
                              // ),

                              coursefield(
                                title: "Location :- ",
                                subtitle: coursemoredetails[0].fLocation,
                              ),

                              coursefield(
                                title: "Campus :- ",
                                subtitle: coursemoredetails[0].fCampus,
                              ),
                              // for (int i = 0; i < coursemoredetails.length; i++)
                              //   SizedBox(
                              //     height: 5.h,
                              //   ),
                              // for (int i = 0; i < coursemoredetails.length; i++)
                              //   Container(
                              //     child: coursefield(
                              //       title: "Majors -",
                              //       subtitle: "",
                              //     ),
                              //   ),

                              coursefield(
                                title: "Application Fee :- ",
                                subtitle: coursemoredetails[0].fCurrency +
                                    " " +
                                    coursemoredetails[0]
                                        .fApplicationFee
                                        .toString(),
                              ),

                              coursemoredetails[0].fMoreThanApplicationFee > 0
                                  ? coursefield(
                                      title:
                                          "Multiple Course Application Fee :- ",
                                      subtitle: coursemoredetails[0]
                                          .fMoreThanApplicationFee
                                          .toString(),
                                    )
                                  : Container(),

                              coursefield(
                                title: "Tuition Fee :- ",
                                subtitle: coursemoredetails[0].fCurrency +
                                    " " +
                                    coursemoredetails[0].fTuitionFee.toString(),
                              ),

                              coursefield(
                                title: "Scholarship :- ",
                                subtitle: coursemoredetails[0]
                                            .fIsScholarshipAvailable ==
                                        true
                                    ? "No"
                                    : "Yes",
                              ),

                              coursefield(
                                title: "Placement :-",
                                subtitle:
                                    coursemoredetails[0].fIsPlacement == true
                                        ? " No"
                                        : "Yes",
                              ),

                              coursefield(
                                title: "Living expensive :- ",
                                subtitle: coursemoredetails[0]
                                    .fExpenditureFee
                                    .toString(),
                              ),

                              // coursefield(
                              //   title: "Conditional Offer -",
                              //   subtitle: "...",
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Container(
                    //   constraints: const BoxConstraints(
                    //     maxHeight: double.infinity,
                    //   ),
                    //   width: 350.w,
                    //   decoration: BoxDecoration(
                    //     color: AppColors.PrimaryWhiteColor,
                    //     borderRadius: BorderRadius.circular(10.r),
                    //     boxShadow: const [
                    //       BoxShadow(
                    //           offset: Offset(
                    //             4,
                    //             4,
                    //           ),
                    //           color: Colors.black12,
                    //           blurRadius: 2.0,
                    //           spreadRadius: 3.0),
                    //     ],
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       ListTile(
                    //         leading: Text(
                    //           "Intakes -",
                    //           style: FieldTextStyle(AppColors.PrimaryBlackColor),
                    //         ),
                    //         title: Text(
                    //           "September",
                    //           style: Text2Regular(AppColors.PrimaryBlackColor),
                    //         ),
                    //       ),
                    //       ListTile(
                    //         leading: Text(
                    //           "Duration -",
                    //           style: FieldTextStyle(AppColors.PrimaryBlackColor),
                    //         ),
                    //         title: Text(
                    //           "3 year",
                    //           style: Text2Regular(AppColors.PrimaryBlackColor),
                    //         ),
                    //       ),
                    //       ListTile(
                    //         leading: Text(
                    //           "Course Url -",
                    //           style: FieldTextStyle(AppColors.PrimaryBlackColor),
                    //         ),
                    //         title: Text(
                    //           "https://www.solent.ac.uk./courses/undergraduate/sport-and",
                    //           style: Text2Regular(AppColors.PrimaryMainColor),
                    //         ),
                    //       ),
                    //       ListTile(
                    //         leading: Text(
                    //           "Application Url -",
                    //           style: FieldTextStyle(AppColors.PrimaryBlackColor),
                    //         ),
                    //         title: Text(
                    //           "https://www.solent.ac.uk./courses/undergraduate/sport-and",
                    //           style: Text2Regular(AppColors.PrimaryMainColor),
                    //         ),
                    //       ),
                    //       coursefield(
                    //         title: "Location -",
                    //         subtitle: "Southampton",
                    //       ),
                    //       coursefield(
                    //         title: "Campus -",
                    //         subtitle: "Southampton City Campus",
                    //       ),
                    //       coursefield(
                    //         title: "Majors -",
                    //         subtitle: "Sports Science, Sports, Sports Management",
                    //       ),
                    //       coursefield(
                    //         title: "Application Fee -",
                    //         subtitle: "GBP 22.00",
                    //       ),
                    //       coursefield(
                    //         title: "Multiple Course\nApplication Fee  -",
                    //         subtitle: "GBP 26.50",
                    //       ),
                    //       coursefield(
                    //         title: "Tuition Fee -",
                    //         subtitle: "GBP 15000.00/year",
                    //       ),
                    //       coursefield(
                    //         title: "Scholarship -",
                    //         subtitle: "No",
                    //       ),
                    //       coursefield(
                    //         title: "Placement -",
                    //         subtitle: "GBP 22.00",
                    //       ),
                    //       coursefield(
                    //         title: "Living expensive -",
                    //         subtitle: "",
                    //       ),
                    //       coursefield(
                    //         title: "Conditional Offer -",
                    //         subtitle: "No",
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Standardized Test Requirement",
                            style: FieldTextStyle(
                              AppColors.PrimaryBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 130.h,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: coursemoredetails.length,
                          itemBuilder: (context, index) {
                            // final randomIndex =
                            //     Random().nextInt(Countrycourse.length);
                            // final imageUrl = Countrycourse[randomIndex].image;
                            return Row(
                              children: [
                                Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: double.maxFinite,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        coursemoredetails[0].fIelts > 0
                                            ? StanderedTest(
                                                colordata: colordata[0],
                                                coursemoredetails:
                                                    coursemoredetails[0]
                                                        .fIelts
                                                        .toString(),
                                                title: "IELTS Overall",
                                              )
                                            : Container(),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        coursemoredetails[0].fIeltsMore > 0
                                            ? StanderedTest(
                                                colordata: colordata[1],
                                                coursemoredetails:
                                                    coursemoredetails[0]
                                                        .fIeltsMore
                                                        .toString(),
                                                title:
                                                    "IELTS No Band Less Than ",
                                              )
                                            : Container(),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        coursemoredetails[0].fToeflIbt > 0
                                            ? StanderedTest(
                                                colordata: colordata[2],
                                                coursemoredetails:
                                                    coursemoredetails[0]
                                                        .fToeflIbt
                                                        .toString(),
                                                title: "TOEFL IBT Overall",
                                              )
                                            : Container(),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        coursemoredetails[0].fToeflMore > 0
                                            ? StanderedTest(
                                                colordata: colordata[3],
                                                coursemoredetails:
                                                    coursemoredetails[0]
                                                        .fToeflMore
                                                        .toString(),
                                                title:
                                                    "TOEFL IBT No Bands Less Than ",
                                              )
                                            : Container(),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        coursemoredetails[0].fPte > 0
                                            ? StanderedTest(
                                                colordata: colordata[4],
                                                coursemoredetails:
                                                    coursemoredetails[0]
                                                        .fPte
                                                        .toString(),
                                                title: "PTE Score ",
                                              )
                                            : Container(),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        coursemoredetails[0].fAct > 0
                                            ? StanderedTest(
                                                colordata: colordata[5],
                                                coursemoredetails:
                                                    coursemoredetails[0]
                                                        .fAct
                                                        .toString(),
                                                title: "ACT Score",
                                              )
                                            : Container(),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        coursemoredetails[0].fDat > 0
                                            ? StanderedTest(
                                                colordata: colordata[6],
                                                coursemoredetails:
                                                    coursemoredetails[0]
                                                        .fDat
                                                        .toString(),
                                                title: "Dat Score ",
                                              )
                                            : Container(),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        coursemoredetails[0].fGre > 0
                                            ? StanderedTest(
                                                colordata: colordata[7],
                                                coursemoredetails:
                                                    coursemoredetails[0]
                                                        .fGre
                                                        .toString(),
                                                title: "GRE Score",
                                              )
                                            : Container(),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        coursemoredetails[0].fGmat > 0
                                            ? StanderedTest(
                                                colordata: colordata[8],
                                                coursemoredetails:
                                                    coursemoredetails[0]
                                                        .fGmat
                                                        .toString(),
                                                title: "GMAT Score",
                                              )
                                            : Container(),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        coursemoredetails[0].fSat > 0
                                            ? StanderedTest(
                                                colordata: colordata[9],
                                                coursemoredetails:
                                                    coursemoredetails[0]
                                                        .fSat
                                                        .toString(),
                                                title: "SAT Score",
                                              )
                                            : Container(),
                                        // Container(
                                        //   height: 110.h,
                                        //   width: 150.w,
                                        //   decoration: BoxDecoration(
                                        //       color: colordata[2],
                                        //       borderRadius:
                                        //           BorderRadius.circular(10)),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     children: [
                                        //       Container(
                                        //         padding: EdgeInsets.only(
                                        //             top: 25, left: 25),
                                        //         child: CircularPercentIndicator(
                                        //           animation: true,
                                        //           animationDuration: 3600,
                                        //           radius: 25.0,
                                        //           lineWidth: 3.0,
                                        //           percent:
                                        //               coursemoredetails[0].fIelts /
                                        //                   10,
                                        //           // header: new Text("Icon header"),
                                        //           center: Text(
                                        //             coursemoredetails[0]
                                        //                 .fIelts
                                        //                 .toString(),
                                        //             style: batchtext2(
                                        //                 AppColors.PrimaryBlackColor),
                                        //           ),
                                        //           backgroundColor: Colors.green,
                                        //           progressColor: Colors.green,
                                        //         ),
                                        //       ),
                                        //       SizedBox(
                                        //         height: 10,
                                        //       ),
                                        //       Padding(
                                        //         padding: const EdgeInsets.all(8.0),
                                        //         child: Text(
                                        //           "IELTS Overall",
                                        //           style: batchtext2(
                                        //               AppColors.PrimaryBlackColor),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        // Container(
                                        //   height: 110.h,
                                        //   width: 150.w,
                                        //   decoration: BoxDecoration(
                                        //       color: colordata[3],
                                        //       borderRadius:
                                        //           BorderRadius.circular(10)),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     children: [
                                        //       Container(
                                        //         padding: EdgeInsets.only(
                                        //             top: 25, left: 25),
                                        //         child: CircularPercentIndicator(
                                        //           animation: true,
                                        //           animationDuration: 3600,
                                        //           radius: 25.0,
                                        //           lineWidth: 3.0,
                                        //           percent:
                                        //               coursemoredetails[0].fToeflIbt /
                                        //                   100,

                                        //           // header: new Text("Icon header"),
                                        //           center: Text(
                                        //             coursemoredetails[0]
                                        //                 .fToeflIbt
                                        //                 .toString(),
                                        //             style: batchtext1(
                                        //                 AppColors.PrimaryBlackColor),
                                        //           ),
                                        //           backgroundColor: Colors.white,
                                        //           progressColor: Colors.green,
                                        //         ),
                                        //       ),
                                        //       SizedBox(
                                        //         height: 10,
                                        //       ),
                                        //       Padding(
                                        //         padding: const EdgeInsets.all(8.0),
                                        //         child: Text(
                                        //           "TOEFL IBT Overall ",
                                        //           style: batchtext2(
                                        //               AppColors.PrimaryBlackColor),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),

                    // Text(
                    //   "Standardized Test Requirement",
                    //   style: OtpText(AppColors.PrimaryMainColor),
                    // ),

                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    // Column(
                    //   children: [
                    //     Card(
                    //       elevation: 3,
                    //       child: ListTile(
                    //         // title: Padding(
                    //         //   padding: EdgeInsets.only(bottom: 1.sp, top: 10.sp),
                    //         //   child: Text(
                    //         //     "Visit Our Website",
                    //         //     style: FieldTextStyle(AppColors.PrimaryBlackColor),
                    //         //   ),
                    //         // ),
                    //         subtitle: Padding(
                    //           padding: EdgeInsets.only(left: 0),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               for (int i = 0; i < coursemoredetails.length; i++)
                    //                 coursefield(
                    //                   title: "IELTS Overall :- ",
                    //                   subtitle:
                    //                       coursemoredetails[i].fIelts.toString(),
                    //                 ),
                    //               SizedBox(
                    //                 height: 5,
                    //               ),
                    //               for (int i = 0; i < coursemoredetails.length; i++)
                    //                 coursefield(
                    //                   title: "CIELTS no Band Less Than :- ",
                    //                   subtitle: coursemoredetails[i].count.toString(),
                    //                 ),
                    //               SizedBox(
                    //                 height: 5,
                    //               ),
                    //               for (int i = 0; i < coursemoredetails.length; i++)
                    //                 coursefield(
                    //                   title: "TOEFL iBT Overall :- ",
                    //                   subtitle:
                    //                       coursemoredetails[i].fToeflIbt.toString(),
                    //                 ),
                    //               SizedBox(
                    //                 height: 5,
                    //               ),
                    //               coursefield(
                    //                 title: "TOEFL iBT No Bands Less Than :- ",
                    //                 subtitle: "  20.0",
                    //               ),
                    //               SizedBox(
                    //                 height: 5,
                    //               ),
                    //               for (int i = 0; i < coursemoredetails.length; i++)
                    //                 coursefield(
                    //                   title: "Dat Score :- ",
                    //                   subtitle: coursemoredetails[i].fDat.toString(),
                    //                 ),
                    //               // Text(
                    //               //   "https://www.global-opportunities.net",
                    //               //   style: TextStyle(
                    //               //       color: AppColors.PrimaryMainColor,
                    //               //       decoration: TextDecoration.underline,
                    //               //       fontFamily: Constant.font_family_poppins,
                    //               //       fontWeight: FontWeight.w600,
                    //               //       fontSize: 12.sp),
                    //               // ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    coursemoredetails[0].expectableBoard == ""
                        ? Text("")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Expectable Board",
                                style:
                                    FieldTextStyle(AppColors.PrimaryMainColor),
                              ),
                              Container(
                                height: 1.h,
                                width: double.infinity,
                                color: AppColors.PrimaryMainColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Text(
                                  coursemoredetails[0]
                                      .expectableBoard
                                      .toString(),
                                  style:
                                      batchtext1(AppColors.PrimaryBlackColor),
                                ),
                              ),
                            ],
                          ),

                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    coursemoredetails[0].fEntryRequirements == "null"
                        ? Text("")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Entry Requirements",
                                style:
                                    FieldTextStyle(AppColors.PrimaryMainColor),
                              ),
                              Container(
                                height: 1.h,
                                width: double.infinity,
                                color: AppColors.PrimaryMainColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Text(
                                  coursemoredetails[0]
                                      .fEntryRequirements
                                      .toString(),
                                  style:
                                      batchtext1(AppColors.PrimaryBlackColor),
                                ),
                              ),
                            ],
                          ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),

                    coursemoredetails[0].fRemark == ""
                        ? Text("")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Remarks",
                                style:
                                    FieldTextStyle(AppColors.PrimaryMainColor),
                              ),
                              Container(
                                height: 1.h,
                                width: double.infinity,
                                color: AppColors.PrimaryMainColor,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                coursemoredetails[0].fRemark.toString(),
                                style: batchtext1(AppColors.PrimaryBlackColor),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}

class StanderedTest extends StatelessWidget {
  const StanderedTest({
    super.key,
    required this.colordata,
    required this.coursemoredetails,
    required this.title,
  });

  final Color colordata;
  final String coursemoredetails;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
      ),
      child: Container(
        height: 115.h,
        width: 150.w,
        decoration: BoxDecoration(
            color: colordata, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 25, left: 25),
              child: CircularPercentIndicator(
                animation: true,
                animationDuration: 3600,
                radius: 25.0,
                lineWidth: 3.0,

                // header: new Text("Icon header"),
                center: Text(
                  coursemoredetails,
                  style: batchtext2(AppColors.PrimaryBlackColor),
                ),
                backgroundColor: Colors.black,
                progressColor: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                maxLines: 2,
                style: batchtext2(AppColors.PrimaryBlackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class coursefield extends StatelessWidget {
  String title;
  String subtitle;
  coursefield({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Color(0xff8A48FC),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: batchtext2(AppColors.PrimaryBlackColor),
          ),
          Flexible(
            child: Text(
              subtitle,
              //overflow: TextOverflow.ellipsis,
              style: batchtext1(AppColors.PrimaryBlackColor),
            ),
          ),
        ],
      ),
    );
  }
}

//raghuwar@global-opportunities.net
