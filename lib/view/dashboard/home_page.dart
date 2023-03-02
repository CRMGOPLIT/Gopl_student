import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/applicationStatus/application_status.dart';
import 'package:global_student/view/batch_details/batch_details.dart';
import 'package:global_student/view/branch_location/branch_location.dart';
import 'package:global_student/view/couse_search/course_search.dart';
import 'package:global_student/view/dashboard/dash_grid_model.dart';
import 'package:global_student/view/event_details/event_detils.dart';
import 'package:global_student/view/login/otp_page.dart';
import 'package:global_student/view/visa/visa_page.dart';
import 'package:global_student/view/widget/drawer.dart';
import 'package:global_student/view/widget/internetconnection.dart';
import 'package:lottie/lottie.dart';

import '../qualification/highschool.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();
  List image = [
    "assets/images/banner1.jpg",
    "assets/images/banner2.jpg",
    "assets/images/banner3.jpg",
    "assets/images/banner2.jpg"
  ];
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

  List page = [
    const HighSchool(),
    const OtpPage(),
    const CourseSerach(),
    const ApplicationStatus(),
    const BatchDetails(),
    const EventDetails(),
    const BranchLocation(),
    const VisaPage(),
  ];
  @override
  void initState() {
    //  ConnectionChecker();
    // TODO: implement initState
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
              //if drawer is open, then close the drawer
              Navigator.pop(context);
            } else {
              _drawerscaffoldkey.currentState!.openDrawer();
              //if drawer is closed then open the drawer.
            }
          },
          child: Icon(
            Icons.menu,
            color: AppColors.PrimaryBlackColor,
            size: 30.sp,
          ),
        ),
        title: Text("Welcome Mohit",
            style: btntext(
              AppColors.PrimaryBlackColor,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.notifications_rounded,
              size: 30.sp,
              color: AppColors.PrimaryBlackColor,
            ),
          ),
        ],
      ),
      drawer: const drawer(),
      key: _drawerscaffoldkey,
      body: Column(
        children: [
          Container(
            height: 160.h,
            padding: EdgeInsets.all(15.r),
            child: ImageSlideshow(
                width: double.infinity,
                // height: 15.h,
                initialPage: 0,
                indicatorColor: AppColors.PrimaryMainColor,
                indicatorBackgroundColor: Colors.white,
                onPageChanged: (value) {},
                autoPlayInterval: 3000,
                isLoop: true,
                children: List.generate(image.length, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      image: DecorationImage(
                          image: AssetImage(image[index]), fit: BoxFit.fill
                          // fit: BoxFit.cover,
                          ),
                    ),
                  );
                })),
          ),
          // SizedBox(
          //   height: 10.h,
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
                padding: EdgeInsets.all(15.r),
                child: Row(
                  children: [
                    Expanded(
                      child: GridView.builder(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => page[index]));
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
                                        style: hometext(
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        // currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        // onTap: _onItemTapped,
      ),
    );
  }
}
