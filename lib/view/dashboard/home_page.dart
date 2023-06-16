import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/bannermodel.dart';
import 'package:global_student/model/usersModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/applicationStatus/application_status.dart';
import 'package:global_student/view/batch_details/batch_details.dart';
import 'package:global_student/view/branch_location/branch_location.dart';
import 'package:global_student/view/couse_search/course_search.dart';
import 'package:global_student/view/dashboard/dash_grid_model.dart';
import 'package:global_student/view/event_details/event_detils.dart';
import 'package:global_student/view/qualification/graduation.dart';
import 'package:global_student/view/uploadmoreDocument/upload_more_document.dart';
import 'package:global_student/view/visa/visa_page.dart';
import 'package:global_student/view/widget/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  // List image = [
  //   "assets/images/appbanner1.jpg",
  //   "assets/images/appbanner2.jpg",
  //   "assets/images/appbanner3.jpg",
  // ];
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
    const Graduation(),
    const UploadMoreDocument(),
    const CourseSerach(),
    const ApplicationStatus(),
    const BatchDetails(),
    const EventDetails(),
    const BranchLocation(),
    // Container(),
    // VisaPage(arguments:[] ),
    //VisaPage(countryId: bannermodeldata!.isVisaApplicable.toString(), isVisaApplicable: , ),
  ];

// List myList = List.from(page1);

  bool loanding = true;
  bool loanding1 = true;
  late DashBoardBloc dashBoardBloc;
  List data = [];
  List dataUser = [];
  List BranchData = [];
  late UsersDetailsModel userData1;

  List<String> bannerimages = [];

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getBannersDetails();
    _gethomeData();
    setState(() {
      getUserDetails();
    });

    // SaveName();
    super.initState();
  }

//     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     bool _seen = (prefs.getBool('seen') ?? false);

  //     if (_seen) {
  //       Future.delayed(const Duration(seconds: 3), () {
  //         Navigator.pushNamed(context, RoutesName.home);

  //         print("if $check");
  //         // getConnectivity();
  //       });
  //     } else {
  //       await prefs.setBool('seen', true);
  //       Future.delayed(const Duration(seconds: 3), () {
  //         Navigator.pushNamed(context, RoutesName.onbording);
  //         //  getConnectivity();
  //       });
  //     }
  String? name;
  getUserDetails() async {
    await dashBoardBloc.userControllerStream.listen((event) async {
      if (event != null) {
        // debugger();
        // print(event);
        userData1 = UsersDetailsModel.fromJson(event[0]);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('Name', userData1.fFirstName.toString());
        prefs.setString('Email', userData1.fStudentEmail.toString());
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

  // String? sName;
  // SaveName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return String
  //   sName = prefs.getString('Name');
  // }

  getBannersDetails() async {
    await dashBoardBloc.bannersControllerStream.listen((event) {
      // debugger();
      // print(event);
      if (event != null) {
        Bannermodel bannermodel = Bannermodel.fromJson(event);

        bannerimages.addAll(bannermodel.images);

        bannermodeldata = bannermodel;

        // BranchData = event;
        // for (int i = 0; i < BranchData.length; i++) {
        //   Bannermodel bannermodel1 = Bannermodel.fromJson(event[i]);

        //   data.add(bannermodel1);
        // }
        setState(() {
          loanding = false;
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callGetBannersDetailsApi();
    dashBoardBloc.callGetUsersDetailsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PrimaryWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.PrimaryWhiteColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.PrimaryMainColor),
        leading: InkWell(
          onTap: () {
            if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
              Navigator.pop(context);
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
            ? Text("")
            : Text(name.toString(),
                style: btntext(
                  AppColors.PrimaryBlackColor,
                )),
        // loanding1 == true
        //     ? const Text(
        //         "",
        //       )
        //     : Text(userData1.fFirstName.toString(),
        //         style: btntext(
        //           AppColors.PrimaryBlackColor,
        //         )
        // ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.notificationpage);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.notifications_rounded,
                size: 30.sp,
                color: AppColors.PrimaryBlackColor,
              ),
            ),
          ),
        ],
      ),
      drawer: drawer(),
      key: _drawerscaffoldkey,
      body: Column(
        children: [
          Container(
              height: 160.h,
              padding: EdgeInsets.all(15.r),
              child: loanding == true
                  ? Container(
                      color: AppColors.PrimaryGreyColor,
                    )
                  : ImageSlideshow(
                      width: double.infinity,
                      // height: 15.h,
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
                                fit: BoxFit.fill
                                // fit: BoxFit.cover,
                                ),
                          ),
                        );
                      }))),
          // SizedBox(
          //   height: 10.h,
          // ),
          // Text(
          //   bannermodeldata!.isVisaApplicable.toString(),
          //   style: TextStyle(color: AppColors.PrimaryBlackColor),
          // ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                // color: AppColors.PrimaryMainColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.r),
                  topLeft: Radius.circular(25.r),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: 15.r,
                  right: 15.r,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.r,
                            mainAxisSpacing: 20.r,
                            childAspectRatio: 10 / 8),
                        itemCount: dashgrid.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              if (index == 7) {
                                Get.to(
                                  VisaPage(),
                                  arguments: [
                                    bannermodeldata!.countryId,
                                    bannermodeldata!.countryName,
                                    bannermodeldata!.isVisaApplicable,
                                    bannermodeldata!.courseId,
                                    bannermodeldata!.studentId,
                                    // dashboardCountryDetail[index].country
                                  ],
                                );
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => page[index]));
                              }

                              // Navigator.pushNamed(
                              //     context, page[index].toString());
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                  color: dashgrid[index].color,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Lottie.asset(
                                    //   dashgrid[index].image!,
                                    //   height: 60.h,
                                    //   width: 60.w,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Container(
                                      padding: EdgeInsets.all(10.sp),
                                      alignment: Alignment.center,
                                      height: 55.h,
                                      width: 55.w,
                                      decoration: BoxDecoration(
                                          color: color[index],
                                          shape: BoxShape.circle),
                                      child: Image.asset(
                                        // "assets/images/timer.json",
                                        dashgrid[index].image!,
                                        // height: 5.h,
                                        // width: 5.w,

                                        //fit: BoxFit.cover,
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
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
