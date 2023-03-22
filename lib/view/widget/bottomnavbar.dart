import 'package:flutter/material.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/applicationStatus/application_status.dart';
import 'package:global_student/view/dashboard/home_page.dart';
import 'package:global_student/view/drawerpage/aboutus.dart';
import 'package:global_student/view/event_details/event_detils.dart';

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
    const AboutUs(),
    const EventDetails()
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pageData[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
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
              label: "Application Status",
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
        },
      ),
    );
  }
}