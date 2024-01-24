import 'dart:io';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/bannermodel.dart';
import 'package:global_student/model/qualificationsubmitModel.dart';
import 'package:global_student/model/usersModel.dart';
import 'package:global_student/model/versioncontrol.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/applicationStatus/application_status.dart';
import 'package:global_student/view/branch_location/branch_location.dart';
import 'package:global_student/view/couse_search/course_search.dart';
import 'package:global_student/view/dashboard/dash_grid_model.dart';
import 'package:global_student/view/event_details/event_detils.dart';
import 'package:global_student/view/fairmodule/gofairpage.dart';
import 'package:global_student/view/ourservices/ourservices.dart';
import 'package:global_student/view/qualification/completeeducation.dart';
import 'package:global_student/view/uploadmoreDocument/upload_more_document.dart';
import 'package:global_student/view/visa/visa_page.dart';
import 'package:global_student/view/widget/drawer.dart';
import 'package:global_student/view/widget/notificationservices.dart';
import 'package:global_student/view/widget/visanotapplicalble.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/gofairbloc.dart';
import '../../model/gofairdetails.dart';
import '../../model/universityvisitModel.dart';
import '../batch_details/batchlist.dart';
import '../qualification/highschool.dart';
import '../qualification/interschool.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  NotificationServices notificationServices = NotificationServices();
  List<Color> color = [
    const Color(0xffCEA279),
    const Color(0xff5D88C6),
    const Color(0xffCE7983),
    const Color(0xff908BCB),
    const Color(0xff61B993),
    const Color(0xffB96191),
    const Color(0xffC65DAF),
    const Color(0xffCEA279),
    const Color(0xff6DACC0),
  ];

  Bannermodel? bannermodeldata;

  List page = [
    const GoFairPage(),
    const HighSchool(),
    const UploadMoreDocument(),
    const CourseSerach(),
    const ApplicationStatus(),
    const BatchList(),
    const EventDetails(),
    const BranchLocation(),
  ];

  bool loanding = true;
  bool loanding1 = true;
  bool loanding3 = true;
  late DashBoardBloc dashBoardBloc;
  late GoFairBloc goFairBloc;
  List data = [];
  List dataUser = [];

  late UsersDetailsModel userData1;

  Versioncontrol? versioncontrol;

  List<String> bannerimages = [];

  List<UniversityVisitModel> universitydetails = [];
  Gofairdetails? getfairModel;

  List universityData = [];
  bool loading1 = true;
  bool loading3 = true;

  String versioncont = "";

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    goFairBloc = GoFairBloc();
    getBannersDetails();
    _gethomeData();
    getUserDetailsdone();
    getUniversityDetails();
    // sendtokennotification();
    sendtoken();
    getUserDetails();
    colors = generateRandomColors();
    super.initState();
    getversionDetails();
    versioncall();
  }

  List<QualificationSubmitModel> qualificationdatasubmit = [];
  List qualidata = [];
  bool loading2 = true;

  getUserDetailsdone() async {
    dashBoardBloc.getqualificationcontrollerStream.listen((event) {
      if (event != null) {
        qualidata = event;
        for (int i = 0; i < qualidata.length; i++) {
          QualificationSubmitModel qualificationSubmitModel =
              QualificationSubmitModel.fromJson(event[i]);
          qualificationdatasubmit.add(qualificationSubmitModel);
        }

        setState(() {
          loading2 = false;
        });
      }
    });
  }

  String? name;
  getUserDetails() async {
    dashBoardBloc.userControllerStream.listen((event) async {
      if (event != null) {
        userData1 = UsersDetailsModel.fromJson(event[0]);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('Name', userData1.fFirstName.toString());
        prefs.setString('Email', userData1.fStudentEmail.toString());
        prefs.setString('studentId', userData1.fStudentId.toString());
        prefs.setString(
            'counsellorcall', userData1.fCounsellorMobile.toString());
        setState(() {
          name = prefs.getString('Name');
          loanding1 = false;
        });
      }
    });
  }

  getBannersDetails() async {
    dashBoardBloc.bannersControllerStream.listen((event) {
      if (event != null) {
        Bannermodel bannermodel = Bannermodel.fromJson(event);
        bannerimages.addAll(bannermodel.images);
        bannermodeldata = bannermodel;
        setState(() {
          loanding = false;
        });
      }
    });
  }

  getUniversityDetails() async {
    dashBoardBloc.universityControllerStream.listen((event) {
      if (event != null) {
        universityData = event;

        for (int i = 0; i < universityData.length; i++) {
          UniversityVisitModel universityVisitModel =
              UniversityVisitModel.fromJson(event[i]);
          universitydetails.add(universityVisitModel);
        }
        setState(() {
          loanding3 = false;
        });
      }
    });
  }

  String? studentid;
  String? tokensend;

  sendtoken() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      sendtokennotification();
    });
  }

  sendtokennotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");
    tokensend = prefs.getString("token");
    Map<String, String> courseAppliedemail = {
      "token": tokensend == null ? "jbblk" : tokensend.toString(),
      "studentid": studentid.toString() == "null" ? "" : studentid.toString(),
    };
    setState(() {});
    goFairBloc.callSendToken(courseAppliedemail);
  }

  _gethomeData() {
    dashBoardBloc.callGetBannersDetailsApi();
    dashBoardBloc.callGetUsersDetailsApi();
    dashBoardBloc.callQualificationApi();
    dashBoardBloc.callGetUniversityDetailsApi();
    goFairBloc.callversionDetailsApi();
  }

  versioncall() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      checkForUpdate(context);
    });
  }

  getversionDetails() async {
    goFairBloc.versiondetailsStream.listen((event) async {
      if (event != null) {
        versioncontrol = Versioncontrol.fromJson(event);

        setState(() {
          versioncont = versioncontrol!.version.toString();
          loading3 = false;
        });
      }
    });
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

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.PrimaryWhiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.PrimaryWhiteColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.PrimaryMainColor),
          leading: InkWell(
            onTap: () {
              if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
                _drawerscaffoldkey.currentState!.closeDrawer();
              } else {
                _drawerscaffoldkey.currentState!.openDrawer();
              }
            },
            child: Icon(
              Icons.menu,
              color: AppColors.PrimaryBlackColor,
              size: 30.sp,
            ),
          ),
          title: loanding1 == true
              ? Container()
              : RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 18.sp),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Hello,',
                            style: batchtext2(
                              AppColors.PrimaryBlackColor,
                            )),
                        TextSpan(
                            text: capitalize(name!).toString(),
                            style: batchtext1(
                              AppColors.PrimaryBlackColor,
                            )),
                      ]),
                ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/bannerlogo.png",
                height: 20.h,
                width: 150.w,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        drawer: const drawer(),
        key: _drawerscaffoldkey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 160.h,
                padding: EdgeInsets.all(10.r),
                child: loanding == true
                    ? Container(
                        color: AppColors.PrimaryGreyColor,
                      )
                    : ImageSlideshow(
                        width: double.infinity,
                        initialPage: 0,
                        indicatorColor: const Color(0xff5D88C6),
                        indicatorBackgroundColor: AppColors.PrimaryGreyColor,
                        onPageChanged: (value) {},
                        autoPlayInterval: 3000,
                        isLoop: true,
                        children: List.generate(bannerimages.length, (index) {
                          return index == 3
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => const GoFairPage());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(bannerimages[index]),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(bannerimages[index]),
                                        fit: BoxFit.fill),
                                  ),
                                );
                        }))),
            Expanded(child: homeBoard()),
          ],
        ),
      ),
    );
  }

  Future<String> getCurrentAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  void checkForUpdate(BuildContext context) async {
    String currentVersion = await getCurrentAppVersion();
    String latestVersion = versioncont;

    if (latestVersion.compareTo(currentVersion) > 0) {
      showUpdateDialog(context);
    } else {
      // No updates available, show a different dialog or perform another action
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text('No Updates'),
      //       content: Text('You are using the latest version of the app.'),
      //       actions: <Widget>[
      //         TextButton(
      //           child: Text('OK'),
      //           onPressed: () {
      //             Navigator.pop(context); // Close the dialog
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
    }
  }

  void showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Update Available',
            style: batchtext2(AppColors.PrimaryMainColor),
          ),
          content: Text(
            'A new version of the app is available. Please update to continue using the app.',
            style: batchtext1(AppColors.PrimaryBlackColor),
          ),
          actions: [
            Center(
              child: TextButton(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.PrimaryMainColor,
                      borderRadius: BorderRadius.circular(5).r),
                  padding: const EdgeInsets.all(10).r,
                  child: Text(
                    'Update Now',
                    style: batchtext2(AppColors.PrimaryWhiteColor),
                  ),
                ),
                onPressed: () async {
                  final Uri url = Platform.isIOS
                      ? Uri.parse(
                          "https://apps.apple.com/np/app/global-opportunities/id6466146185")
                      : Uri.parse(
                          "https://play.google.com/store/apps/details?id=com.appgopl.globalopportunities");
                  if (!await launchUrl(url,
                      mode: LaunchMode.externalApplication)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget universityBanner() {
    return loanding3 == true
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 28.h,
                padding: EdgeInsets.all(5.h),
                child: Center(
                  child: AnimatedTextKit(
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                          'Global Opportunities Fair Started...',
                          textStyle: FieldTextStyle(Colors.red)),
                      TypewriterAnimatedText('Book your Appointment Now 👆',
                          textStyle: batchtext2(Colors.green)),
                    ],
                    onTap: () {
                      Get.to(() => const GoFairPage());
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.r),
                child: Text("University Visit",
                    textAlign: TextAlign.center,
                    style: batchtext2(
                      AppColors.PrimaryBlackColor,
                    )),
              ),
              SizedBox(
                height: 80.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: universityData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10.r),
                        child: Row(
                          children: [
                            Card(
                              child: Container(
                                  height: 80.h,
                                  width: 320.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.PrimaryGreyColor),
                                      color: getRandomColor(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: FlipCard(
                                    flipOnTouch: true,
                                    front: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          universitydetails[index]
                                                          .logo
                                                          .toString() !=
                                                      "null" &&
                                                  universitydetails[index]
                                                          .logo
                                                          .toString() !=
                                                      ""
                                              ? Image.network(
                                                  universitydetails[index]
                                                      .logo
                                                      .toString(),
                                                  height: 50.h,
                                                  width: 80.w,
                                                  fit: BoxFit.fill,
                                                )
                                              : Icon(
                                                  Icons.school,
                                                  size: 40.h,
                                                ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Container(
                                                  // color: AppColors
                                                  //     .PrimaryGreyColor,
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  width: 390.w,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        universitydetails[index]
                                                            .university
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: batchtext2(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Text(
                                                        universitydetails[index]
                                                            .branchName
                                                            .toString(),
                                                        style: batchtext1(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Text(
                                                    "View More 👆",
                                                    style: TextStyle(
                                                      fontSize: 9.sp,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppColors
                                                          .PrimaryMainColor,
                                                      fontFamily: "Outfit",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    back: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Country :- ${universitydetails[index].country}",
                                            style: batchtext2(
                                                AppColors.PrimaryBlackColor),
                                          ),
                                          Text(
                                            "Date :- ${universitydetails[index].dateOfVisit}",
                                            style: batchtext1(
                                                AppColors.PrimaryBlackColor),
                                          ),
                                          Text(
                                            "Time :- ${"${universitydetails[index].timeFrom} To ${universitydetails[index].timeTo}"}",
                                            style: batchtext1(
                                                AppColors.PrimaryBlackColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
  }

  Widget homeBoard() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          universityData.isNotEmpty ? universityBanner() : Container(),
          Padding(
            padding: EdgeInsets.only(left: 10.r, right: 10.r),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(
                  parent: NeverScrollableScrollPhysics()),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.r,
                  mainAxisSpacing: 10.r,
                  childAspectRatio: 15.w / 10.w),
              itemCount: dashgrid.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    if (index == 8) {
                      bannermodeldata!.isVisaApplicable == "0"
                          ? Get.to(() => const VisaNotApplicable(), arguments: [
                              bannermodeldata!.isVisaApplicable,
                            ])
                          : bannermodeldata!.isVisaApplicable == "2"
                              ? Get.to(() => const VisaNotApplicable(),
                                  arguments: [
                                      bannermodeldata!.isVisaApplicable,
                                    ])
                              : Get.to(
                                  () => const VisaPage(),
                                  arguments: [
                                    bannermodeldata!.countryId,
                                    bannermodeldata!.countryName,
                                    bannermodeldata!.isVisaApplicable,
                                    bannermodeldata!.courseId,
                                    bannermodeldata!.studentId,
                                  ],
                                );
                    } else if (index == 9) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OurServices()));
                    } else {
                      index == 1
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      qualificationdatasubmit.isEmpty
                                          ? const HighSchool()
                                          : qualificationdatasubmit.length == 1
                                              ? const InterSchool()
                                              : const DonePage()))
                          : Navigator.push(
                              context, FadeInPageRoute(page: page[index]));
                    }
                  },
                  child: Card(
                    elevation: 4,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: AppColors.PrimaryGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: dashgrid[index].color,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.sp),
                            alignment: Alignment.center,
                            child: Image.asset(
                              dashgrid[index].image!,
                              height: 50.h,
                              width: 75.w,
                            ),
                          ),
                          Text(dashgrid[index].title!,
                              textAlign: TextAlign.center,
                              style: batchtext2(
                                AppColors.PrimaryBlackColor,
                              )),
                        ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Custom page route transition using FadeIn animation
class FadeInPageRoute extends PageRouteBuilder {
  final Widget page;
  FadeInPageRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            final tween = Tween(begin: begin, end: end);
            final opacityAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: opacityAnimation,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) => page,
        );
}
