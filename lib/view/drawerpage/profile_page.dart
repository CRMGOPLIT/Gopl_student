import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/usersModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';

import 'package:global_student/view/widget/app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late DashBoardBloc dashBoardBloc;
  UsersDetailsModel? userData1;

  bool loading = true;

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getUserDetails();
    _gethomeData();
    super.initState();
  }

  getUserDetails() {
    dashBoardBloc.userControllerStream.listen((event) {
      if (event != null) {
        setState(() {
          userData1 = UsersDetailsModel.fromJson(event[0]);

          loading = false;
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callGetUsersDetailsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Profile",
            onpress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.bottomnav,
                (routes) => false,
              );
            },
          ),
        ),
        body: loading == true
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: AppColors.PrimaryMainColor,
              ))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/proimg.png",
                        height: 70,
                        width: 70,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Container(
                        height: 50.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                            color: AppColors.PrimaryWhiteColor,
                            border: Border.all(color: AppColors.hintcolor),
                            borderRadius: BorderRadius.circular(40)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                userData1!.fFirstName.toString().toUpperCase(),
                                style:
                                    FieldTextStyle(AppColors.PrimaryMainColor),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Center(
                              child: Text(
                                "Student ID :- ${userData1!.fStudentId}",
                                style: batchtext1(AppColors.PrimaryBlackColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10).w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50).w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                subtitle: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 5.sp, top: 5.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text("Email",
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text("📩  ${userData1!.fStudentEmail}",
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text("Mobile",
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text("📱 ${userData1!.fMobile}",
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text("Branch",
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text("📍  ${userData1!.fBranceName}",
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 1.sp, top: 5.sp),
                                  child: Text(
                                    "Counsellor  Name",
                                    style:
                                        batchtext2(AppColors.PrimaryBlackColor),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 5.sp, top: 5.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("🧑  ${userData1!.counsellorName}",
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text("Counsellor  Email",
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text("📩  ${userData1!.fCounsellorEmail}",
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text("Counsellor Mobile",
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text(
                                          "☎️  ${userData1!.fCounsellorMobile}",
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
