import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/routes/routes_name.dart';

class drawer extends StatelessWidget {
  drawer({
    Key? key,
  }) : super(key: key);
  String? token;
  @override
  Widget build(BuildContext context) {
    final imageurl =
        "https://cdn.siasat.com/wp-content/uploads/2021/05/tiger-shroff.jpg";
    return Container(
      width: 250.w,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(50.r)),
        child: Drawer(
          // shape: borders,
          //backgroundColor: AppColors.PrimaryWhiteColor,
          child: ListView(
            //  clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.all(0.0),
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('Gautam Sir'),
                accountEmail: Text('example@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: AppColors.PrimaryMainColor,
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://insidemusicschools.com/wp-content/uploads/2020/03/pexels-pixabay-267885-scaled.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(
                  CupertinoIcons.home,
                  color: Colors.black,
                ),
                title: Text(
                  "Home",
                  textScaleFactor: 1.0,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  "Profile",
                  textScaleFactor: 1.0,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.aboutpage);
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.school,
                    color: Colors.black,
                  ),
                  title: Text(
                    "About Us",
                    textScaleFactor: 1.0,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
                title: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.contactpage);
                  },
                  child: const Text(
                    "Contact Us",
                    textScaleFactor: 1.0,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/signup');
                    Get.defaultDialog(
                        title: "Are You Sure Logout ?",
                        // middleText: "Hello world!",
                        backgroundColor: AppColors.PrimaryWhiteColor,
                        titleStyle: btntext(AppColors.PrimaryMainColor),
                        //middleTextStyle: TextStyle(color: Colors.white),
                        titlePadding: EdgeInsets.all(15.sp),
                        textConfirm: "Yes",
                        textCancel: "No",
                        cancelTextColor: AppColors.PrimaryMainColor,
                        confirmTextColor: Colors.white,
                        buttonColor: AppColors.PrimaryMainColor,
                        barrierDismissible: false,
                        radius: 10,
                        onConfirm: () {
                          removeValues();
                          Navigator.pushNamed(context, RoutesName.login);
                        },
                        content: Container());
                  },
                  child: const Text(
                    "Log Out",
                    textScaleFactor: 1.0,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              ListTile(
                // leading: const Icon(
                //   Icons.phone,
                //   color: Colors.black,
                // ),
                title: Text(
                  "Version 1.0.0",
                  textScaleFactor: 1.0,
                  style: TextRegular(AppColors.PrimaryBlackColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.remove("stringValue").toString();
  }
}
