import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/applicationStatus/application_status.dart';
import 'package:global_student/view/dashboard/home_page.dart';
import 'package:global_student/view/drawerpage/contactus.dart';
import 'package:global_student/view/drawerpage/profile_page.dart';

// ignore: must_be_immutable
class Bottom extends StatefulWidget {
  int? index;
  Bottom({Key? key, this.index}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;
  List pageData = [
    const HomePage(),
    const ApplicationStatus(),
    const ContactUs(),
    const ProfilePage()
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onbackbuttondoubleClick(context),
      child: Scaffold(
        body: Center(child: pageData[_currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: batchtext2(AppColors.hintcolor),
            unselectedLabelStyle: batchtext1(AppColors.hintcolor),
            iconSize: 25,
            backgroundColor: AppColors.PrimaryWhiteColor,
            elevation: 10,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedItemColor: AppColors.PrimaryMainColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home",
                  backgroundColor: AppColors.PrimaryGreyColor),
              BottomNavigationBarItem(
                  icon: InkWell(
                    child: Icon(
                      Icons.query_stats_rounded,
                    ),
                  ),
                  label: "Application",
                  backgroundColor: Colors.red),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.phone,
                  ),
                  label: "Contact Us",
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profile',
                  backgroundColor: Colors.white),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            }),
      ),
    );
  }

  bool back = false;
  int time = 0;
  int duration = 1000;
  Future<bool> _onbackbuttondoubleClick(BuildContext context) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (back && time >= now) {
      back = false;
      exit(0);
    } else {
      time = DateTime.now().millisecondsSinceEpoch + duration;

      back = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.PrimaryWhiteColor,

          // width: double.infinity,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: AppColors.PrimaryMainColor,
                // decoration:
                //     BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  "assets/images/logomain.jpg",
                  height: 20.h,
                  width: 20.w,
                ),
              ),
              Text(
                "Press again the button to exit",
                style: batchtext1(AppColors.PrimaryMainColor),
              ),
            ],
          )));
    }
    return false;
  }
}
