import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/routes/routes_name.dart';

// ignore: camel_case_types
class drawer extends StatefulWidget {
  const drawer({
    Key? key,
  }) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

// ignore: camel_case_types
class _drawerState extends State<drawer> {
  String? token;

  String? email;

  String? name;

  setdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("Name");
    email = prefs.getString("Email");
    setState(() {});
  }

  @override
  void initState() {
    setdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // decoration: BoxDecoration(color: AppColors.PrimaryBlackColor
      //     // border: Border.all(),
      //     // borderRadius: BorderRadius.circular(40)
      //     ),
      width: 230.w,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.only(
            topRight: const Radius.circular(35),
            bottomRight: Radius.circular(50.r)),
        child: Drawer(
          // shape: borders,
          //backgroundColor: AppColors.PrimaryWhiteColor,
          child: ListView(
            //  clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.all(0.0),
            children: [
              UserAccountsDrawerHeader(
                //decoration: BoxDecoration(color: AppColors.PrimaryMainColor),
                accountName: Text(name.toString(),
                    style: batchtext2(
                      AppColors.PrimaryWhiteColor,
                    )),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(name.toString(),
                //         style: batchtext2(
                //           AppColors.PrimaryWhiteColor,
                //         )),
                //     Text(email.toString(),
                //         maxLines: 1,
                //         style: batchtext1(
                //           AppColors.PrimaryWhiteColor,
                //         )),
                //   ],
                // ),
                accountEmail: Text(email.toString(),
                    maxLines: 1,
                    style: batchtext1(
                      AppColors.PrimaryWhiteColor,
                    )),
                decoration: const BoxDecoration(
                  // color: AppColors.PrimaryMainColor,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://insidemusicschools.com/wp-content/uploads/2020/03/pexels-pixabay-267885-scaled.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Image.asset(
                "assets/images/bannerlogo.png",
                height: 30,
                width: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: ListTile(
                  leading: const Icon(
                    CupertinoIcons.home,
                    color: Colors.black,
                  ),
                  title: Text("Home",
                      textScaleFactor: 1.0,
                      style: batchtext2(AppColors.PrimaryBlackColor)),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.profilepage);
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: Text("Profile",
                      textScaleFactor: 1.0,
                      style: batchtext2(AppColors.PrimaryBlackColor)),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.aboutpage);
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.school,
                    color: Colors.black,
                  ),
                  title: Text("About Us",
                      textScaleFactor: 1.0,
                      style: batchtext2(AppColors.PrimaryBlackColor)),
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
                  child: Text("Contact Us",
                      textScaleFactor: 1.0,
                      style: batchtext2(AppColors.PrimaryBlackColor)),
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
                  child: Text("Log Out",
                      textScaleFactor: 1.0, style: batchtext2(Colors.red)),
                ),
              ),
              ListTile(
                // leading: const Icon(
                //   Icons.phone,
                //   color: Colors.black,
                // ),
                title: Text("Version 1.0.0",
                    textScaleFactor: 1.0,
                    style: batchtext2(AppColors.PrimaryBlackColor)),
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
