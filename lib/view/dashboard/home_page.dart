import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/bannermodel.dart';
import 'package:global_student/model/qualificationsubmitModel.dart';
import 'package:global_student/model/usersModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/applicationStatus/application_status.dart';
import 'package:global_student/view/branch_location/branch_location.dart';
import 'package:global_student/view/couse_search/course_search.dart';
import 'package:global_student/view/dashboard/dash_grid_model.dart';
import 'package:global_student/view/event_details/event_detils.dart';
import 'package:global_student/view/qualification/completeeducation.dart';
import 'package:global_student/view/uploadmoreDocument/upload_more_document.dart';
import 'package:global_student/view/visa/visa_page.dart';
import 'package:global_student/view/widget/drawer.dart';
import 'package:global_student/view/widget/visanotapplicalble.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  List<Color> color = [
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
    const HighSchool(),
    const UploadMoreDocument(),
    const CourseSerach(),
    const ApplicationStatus(),
    const BatchList(),
    const EventDetails(),
    const BranchLocation(),
    // Container(),
    // VisaPage(arguments:[] ),
    //VisaPage(countryId: bannermodeldata!.isVisaApplicable.toString(), isVisaApplicable: , ),
  ];

  bool loanding = true;
  bool loanding1 = true;
  bool loanding3 = true;
  late DashBoardBloc dashBoardBloc;
  List data = [];
  List dataUser = [];

  late UsersDetailsModel userData1;

  List<String> bannerimages = [];

  List<UniversityVisitModel> universitydetails = [];

  List universityData = [];

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getBannersDetails();
    _gethomeData();
    getUserDetailsdone();
    getUniversityDetails();

    setState(() {
      getUserDetails();
    });
    colors = generateRandomColors();

    super.initState();
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

        // userData1.add(userData);
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

  _gethomeData() {
    dashBoardBloc.callGetBannersDetailsApi();
    dashBoardBloc.callGetUsersDetailsApi();
    dashBoardBloc.callQualificationApi();
    dashBoardBloc.callGetUniversityDetailsApi();
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
    // Shuffle the colors randomly
    colorList.shuffle(Random());
    return colorList;
  }

  Color getRandomColor() {
    if (colors.isEmpty) {
      // Regenerate colors if the list is empty
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
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              image: DecorationImage(
                                  image: NetworkImage(bannerimages[index]),
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

  Widget universityBanner() {
    return loanding3 == true
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.r),
                child: Text("University Visit",
                    textAlign: TextAlign.center,
                    style: batchtext2(
                      AppColors.PrimaryBlackColor,
                    )),
              ),
              SizedBox(
                height: 75.h,
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
                                  height: 70.h,
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
                                                        height: 5.h,
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
                    if (index == 7) {
                      bannermodeldata!.isVisaApplicable == "0"
                          ? Get.to(const VisaNotApplicable(), arguments: [
                              bannermodeldata!.isVisaApplicable,
                            ])
                          : bannermodeldata!.isVisaApplicable == "2"
                              ? Get.to(const VisaNotApplicable(), arguments: [
                                  bannermodeldata!.isVisaApplicable,
                                ])
                              : Get.to(
                                  const VisaPage(),
                                  arguments: [
                                    bannermodeldata!.countryId,
                                    bannermodeldata!.countryName,
                                    bannermodeldata!.isVisaApplicable,
                                    bannermodeldata!.courseId,
                                    bannermodeldata!.studentId,
                                  ],
                                );
                    } else {
                      index == 0
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
                              context,
                              FadeInPageRoute(page: page[index]),
                            );
                    }
                  },
                  child: Card(
                    elevation: 4,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: dashgrid[index].color,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.sp),
                            alignment: Alignment.center,
                            height: 55.h,
                            width: 55.w,
                            decoration: BoxDecoration(
                                color: color[index], shape: BoxShape.circle),
                            child: Image.asset(
                              dashgrid[index].image!,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
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
