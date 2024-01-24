import 'package:flutter/material.dart';
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
      width: 230.w,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.only(
            topRight: const Radius.circular(35),
            bottomRight: Radius.circular(50.r)),
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(name.toString(),
                    style: batchtext2(
                      AppColors.PrimaryWhiteColor,
                    )),
                accountEmail: Text(email.toString(),
                    maxLines: 1,
                    style: batchtext1(
                      AppColors.PrimaryWhiteColor,
                    )),
                decoration: const BoxDecoration(
                  // color: AppColors.PrimaryMainColor,
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/drawerimg.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Image.asset(
                "assets/images/bannerlogo.png",
                height: 30.h,
                width: 100.w,
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
                  leading: Image.asset(
                    "assets/images/b1.png",
                    height: 20.h,
                    color: AppColors.PrimaryBlackColor,
                    fit: BoxFit.contain,
                  ),
                  title: Text("Home",
                      textScaleFactor: 1.0,
                      style: batchtext2(AppColors.PrimaryBlackColor)),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  Navigator.pushNamed(context, RoutesName.profilepage);
                },
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/b4.png",
                    height: 20.h,
                    color: AppColors.PrimaryBlackColor,
                    fit: BoxFit.contain,
                  ),
                  title: Text("Profile",
                      textScaleFactor: 1.0,
                      style: batchtext2(AppColors.PrimaryBlackColor)),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();

                  Navigator.pushNamed(context, RoutesName.aboutpage);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.school,
                    size: 20.sp,
                    color: AppColors.PrimaryBlackColor,
                  ),
                  title: Text("About Us",
                      textScaleFactor: 1.0,
                      style: batchtext2(AppColors.PrimaryBlackColor)),
                ),
              ),
              ListTile(
                leading: Image.asset(
                  "assets/images/b3.png",
                  height: 20.h,
                  color: AppColors.PrimaryBlackColor,
                  fit: BoxFit.contain,
                ),
                title: GestureDetector(
                  onTap: () {
                    Get.back();
                    Navigator.pushNamed(context, RoutesName.contactpage);
                  },
                  child: Text("Contact Us",
                      textScaleFactor: 1.0,
                      style: batchtext2(AppColors.PrimaryBlackColor)),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.history,
                  size: 20.sp,
                  color: AppColors.PrimaryBlackColor,
                ),
                title: GestureDetector(
                  onTap: () {
                    Get.back();
                    Navigator.pushNamed(context, RoutesName.paymenthistory);
                  },
                  child: Text("Payment History",
                      textScaleFactor: 1.0,
                      style: batchtext2(AppColors.PrimaryBlackColor)),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  size: 20.sp,
                  color: AppColors.PrimaryBlackColor,
                ),
                title: InkWell(
                  onTap: () {
                    Get.back();
                    Navigator.pushNamed(context, RoutesName.deleteaccount);
                  },
                  child: Text("Delete Account",
                      textScaleFactor: 1.0,
                      style: batchtext2(AppColors.PrimaryBlackColor)),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 20.sp,
                  color: Colors.red,
                ),
                title: GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                        title: "Are You Sure Logout ?",
                        backgroundColor: AppColors.PrimaryWhiteColor,
                        titleStyle: btntext(AppColors.PrimaryMainColor),
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

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesName.login,
                            (routes) => false,
                          );
                        },
                        content: Container());
                  },
                  child: Text("Log Out",
                      textScaleFactor: 1.0, style: batchtext2(Colors.red)),
                ),
              ),
              ListTile(
                title: Text("Version 1.0.8",
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
