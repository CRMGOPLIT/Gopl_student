import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/searchBloc.dart';
import 'package:global_student/model/coursedetailsmodel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/routes/routes_name.dart';
import '../helper/apiResponseHelper.dart';
import '../widget/loader.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  late SearchBloc searchBloc;
  List<CourseMoreDetails> coursemoredetails = [];
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  List colordata = [
    const Color(0xffc3ddd6),
    const Color(0xffefc5b5),
    const Color(0xfffbdd7e),
    const Color(0xffeeaaff),
    const Color(0xffBEFE9D),
    const Color(0xff99FFEB),
    const Color(0xffAD6AEB),
    const Color(0xffF79DAA),
    const Color(0xffF3AB6F),
    const Color(0xffefc5b5),
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

  String? studentid;

  setdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");

    setState(() {});
  }

  @override
  void initState() {
    searchBloc = SearchBloc();
    setdata();
    // scrollController.addListener(_scrollListener);
    super.initState();
    getCourseData();
    callcourseDetails();

    searchBloc.courseappliedEmailStream.listen((event) {
      Navigator.pop(context);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true && event.data['Status'] == 'Success') {
        sucess();
        Timer(const Duration(milliseconds: 3000), () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.bottomnav,
            (routes) => false,
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(seconds: 2),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oops Error!',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text("Sorry!! Please Contact to Your counsellor",
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

 
  void getCourseData() async {
    if (!isloadingmore && hasmore) {
      isloadingmore = true;
      setState(() {});

      searchBloc.coursemoredetailsStream.listen((event) async {
        if (event != null) {
          coursedata = event;

          for (int i = 0; i < coursedata.length; i++) {
            CourseMoreDetails courseDetails =
                CourseMoreDetails.fromJson(event[i]);
            coursemoredetails.add(courseDetails);

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

  searchFilter() {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Map<String, String> courseAppliedemail = {
      "CourseId": coursemoredetails[0].fCourseDetailId.toString(),
      "StudentId": studentid.toString(),
    };
    searchBloc.callCourseAppliedEmail(courseAppliedemail);
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
            Get.back();
          },
        ),
      ),
      body: loanding
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 2.w,
              color: AppColors.PrimaryMainColor,
            ))
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
                                  : const CircularProgressIndicator(
                                      color: AppColors.PrimaryMainColor,
                                    ),
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
                    Center(
                      child: Text(
                        coursemoredetails[0].fUniversity,
                        style: OtpText(AppColors.PrimaryMainColor),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      coursemoredetails[0].fAddress.toString().trim(),
                      style: Text2Regular(AppColors.PrimaryBlackColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40.h,
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                              color: AppColors.PrimaryMainColor,
                              borderRadius: BorderRadius.circular(5.sp)),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/ranklogo.png",
                                height: 30.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Center(
                                child: Text(
                                  "QS Ranking :-  ${coursemoredetails[0].fNationalRank}",
                                  textAlign: TextAlign.center,
                                  style:
                                      batchtext1(AppColors.PrimaryWhiteColor),
                                ),
                              ),
                            ],
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
                    InkWell(
                      onTap: () async {
                        final Uri url = Uri.parse(
                            coursemoredetails[0].fUniversityUrl.toString());
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch $url');
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
                              coursemoredetails[0].fUniversityUrl,
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
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      coursemoredetails[0].fProgram,
                      textAlign: TextAlign.center,
                      style: FieldTextStyle(AppColors.PrimaryMainColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side:
                            const BorderSide(color: AppColors.PrimaryMainColor),
                      ),
                      elevation: 2,
                      child: ListTile(
                        subtitle: Padding(
                          padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Coursefield(
                                title: "Program Level :-  ",
                                subtitle: coursemoredetails[0].fProgramLevel,
                              ),
                              Coursefield(
                                title: "Intakes :-  ",
                                subtitle: coursemoredetails[0].fIntake,
                              ),
                              Coursefield(
                                title: "Duration :- ",
                                subtitle: coursemoredetails[0].fDurationName,
                              ),
                              Coursefield(
                                title: "Location :- ",
                                subtitle: coursemoredetails[0].fLocation,
                              ),
                              Coursefield(
                                title: "Campus :- ",
                                subtitle: coursemoredetails[0].fCampus,
                              ),
                              Coursefield(
                                title: "Application Fee :- ",
                                subtitle:
                                    "${coursemoredetails[0].fCurrency} ${coursemoredetails[0].fApplicationFee}",
                              ),
                              coursemoredetails[0].fMoreThanApplicationFee > 0
                                  ? Coursefield(
                                      title:
                                          "Multiple Course Application Fee :- ",
                                      subtitle: coursemoredetails[0]
                                          .fMoreThanApplicationFee
                                          .toString(),
                                    )
                                  : Container(),
                              Coursefield(
                                title: "Tuition Fee :- ",
                                subtitle:
                                    "${coursemoredetails[0].fCurrency} ${coursemoredetails[0].fTuitionFee}",
                              ),
                              Coursefield(
                                title: "Scholarship :- ",
                                subtitle: coursemoredetails[0]
                                            .fIsScholarshipAvailable ==
                                        true
                                    ? "No"
                                    : "Yes",
                              ),
                              Coursefield(
                                title: "Placement :-",
                                subtitle:
                                    coursemoredetails[0].fIsPlacement == true
                                        ? " No"
                                        : "Yes",
                              ),
                              Coursefield(
                                title: "Living expensive :- ",
                                subtitle: coursemoredetails[0]
                                    .fExpenditureFee
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                    coursemoredetails[0].fIelts <= 0 &&
                            coursemoredetails[0].fIeltsMore <= 0 &&
                            coursemoredetails[0].fToeflIbt <= 0 &&
                            coursemoredetails[0].fToeflMore <= 0 &&
                            coursemoredetails[0].fPte <= 0 &&
                            coursemoredetails[0].fAct <= 0 &&
                            coursemoredetails[0].fDat <= 0 &&
                            coursemoredetails[0].fGre <= 0 &&
                            coursemoredetails[0].fGmat <= 0 &&
                            coursemoredetails[0].fSat <= 0
                        ? Container()
                        : SizedBox(
                            height: 138.h,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: coursemoredetails.length,
                                itemBuilder: (context, index) {
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
                                              coursemoredetails[0].fIeltsMore >
                                                      0
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
                                              coursemoredetails[0].fToeflIbt > 0
                                                  ? StanderedTest(
                                                      colordata: colordata[2],
                                                      coursemoredetails:
                                                          coursemoredetails[0]
                                                              .fToeflIbt
                                                              .toString(),
                                                      title:
                                                          "TOEFL IBT Overall",
                                                    )
                                                  : Container(),
                                              coursemoredetails[0].fToeflMore >
                                                      0
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                    coursemoredetails[0].expectableBoard == ""
                        ? const Text("")
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
                    coursemoredetails[0].fEntryRequirements == "null"
                        ? const Text("")
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
                    coursemoredetails[0].fRemark == ""
                        ? const Text("")
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
                              // Image.asset("assets/images/sucess.gif"),
                              Padding(
                                padding: const EdgeInsets.all(8.0).r,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      searchFilter();
                                      // sucess();
                                    },
                                    child: Container(
                                        height: 40.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.sp),
                                            color: Colors.green),
                                        child: Center(
                                          child: Text(
                                            "Apply Now",
                                            style: batchtext2(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  sucess() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Column(
          children: [
            Image.asset(
              "assets/images/bannerlogo.png",
              height: 40.h,
              width: 200.w,
              fit: BoxFit.contain,
            ),
            SizedBox(
                height: 100.h,
                child: Lottie.asset(
                  "assets/images/sucess1.json",
                )),
          ],
        ),
        content: Text(
          "Your Query is submitted to counsellor🤗",
          style: batchtext2(AppColors.PrimaryMainColor),
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
        height: 120.h,
        width: 150.w,
        decoration: BoxDecoration(
            color: colordata, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 25, left: 25).r,
              child: CircularPercentIndicator(
                animation: true,
                animationDuration: 3600,
                radius: 25.0.r,
                lineWidth: 3.0,
                center: Text(
                  coursemoredetails,
                  style: batchtext2(AppColors.PrimaryBlackColor),
                ),
                backgroundColor: Colors.black,
                progressColor: Colors.black,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0).r,
              child: Text(
                title,
                maxLines: 1,
                style: batchtext2(AppColors.PrimaryBlackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Coursefield extends StatelessWidget {
  String title;
  String subtitle;
  Coursefield({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125.w,
            child: Text(
              title,
              style: batchtext2(AppColors.PrimaryBlackColor),
            ),
          ),
          Flexible(
            child: Text(
              subtitle,
              style: batchtext1(AppColors.PrimaryBlackColor),
            ),
          ),
        ],
      ),
    );
  }
}
