import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/applicationStatus/application_status.dart';
import 'package:global_student/view/batch_details/batch_details.dart';
import 'package:global_student/view/dashboard/dash_grid_model.dart';
import 'package:global_student/view/login/otp_page.dart';
import 'package:lottie/lottie.dart';

import '../qualification/highschool.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List image = [
    "assets/images/banner1.jpg",
    "assets/images/banner2.jpg",
    "assets/images/banner1.jpg",
    "assets/images/banner2.jpg"
  ];

  List page = [
    HighSchool(),
    OtpPage(),
    OtpPage(),
    ApplicationStatus(),
    BatchDetails(),
    OtpPage(),
    ApplicationStatus(),
    ApplicationStatus(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PrimaryWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.PrimaryMainColor,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: AppColors.PrimaryWhiteColor,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150.h,
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
                      image: DecorationImage(
                        image: AssetImage(image[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.PrimaryMainColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.r),
                  topLeft: Radius.circular(25.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: Row(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15.r,
                            mainAxisSpacing: 20.r,
                            childAspectRatio: 10 / 7.5),
                        itemCount: 8,
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
                                  color: AppColors.PrimaryWhiteColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(
                                          5,
                                          10,
                                        ),
                                        color: Colors.black38,
                                        blurRadius: 2.0,
                                        spreadRadius: 2.0),
                                    // BoxShadow(
                                    //     offset: Offset(
                                    //       -2,
                                    //       -5,
                                    //     ),
                                    //     color: Colors.black12,
                                    //     blurRadius: 2.0,
                                    //     spreadRadius: 2.0),
                                  ]),
                              child: Column(children: [
                                // Lottie.asset(
                                //   dashgrid[index].image!,
                                //   height: 60.h,
                                //   width: 60.w,
                                //   fit: BoxFit.cover,
                                // ),
                                Image.asset(
                                  // "assets/images/timer.json",
                                  dashgrid[index].image!,
                                  height: 60.h,
                                  width: 60.w,

                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(dashgrid[index].title!,
                                    textAlign: TextAlign.center,
                                    style: Text2Regular(
                                      AppColors.PrimaryMainColor,
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
