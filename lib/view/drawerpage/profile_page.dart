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

    //userData1 = "" as UsersDetailsModel;
    _gethomeData();
    // SaveName();
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
              Navigator.pushNamed(context, RoutesName.bottomnav);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: loading == true
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/account.png",
                          height: 60,
                          width: 60,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: Text(
                          userData1!.fFirstName.toString().toUpperCase(),
                          style: OtpText(AppColors.PrimaryMainColor),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Center(
                        child: Text(
                          "Student Id :- " + userData1!.fStudentId.toString(),
                          style: batchtext2(AppColors.PrimaryBlackColor),
                        ),
                      ),
                      Container(
                        // height: 400.h,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            //color: AppColors.PrimaryMainColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Card(
                              elevation: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // gradient: LinearGradient(
                                  //   colors: [
                                  //     AppColors.PrimaryMainColor,
                                  //     // Color(0xff72DAF7),
                                  //     Color(0xff6538A8),
                                  //   ],
                                  //   begin: Alignment.topLeft,
                                  //   end: Alignment.bottomRight,
                                  // ),
                                ),
                                child: ListTile(
                                  // title: Padding(
                                  //   padding:
                                  //       EdgeInsets.only(bottom: 1.sp, top: 10.sp),
                                  //   child: Text(
                                  //     "Name",
                                  //     style:
                                  //         FieldTextStyle(AppColors.PrimaryBlackColor),
                                  //   ),
                                  // ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 5.sp, top: 5.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text("Mohit Kumar",
                                        //     style: Text2Regular(
                                        //         AppColors.PrimaryBlackColor)),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text("Email",
                                            style: FieldTextStyle(
                                                AppColors.PrimaryBlackColor)),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                            "📩  " +
                                                userData1!.fStudentEmail
                                                    .toString(),
                                            style: TextRegular(
                                                AppColors.PrimaryBlackColor)),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text("Mobile",
                                            style: FieldTextStyle(
                                                AppColors.PrimaryBlackColor)),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                            "📱 " +
                                                userData1!.fMobile.toString(),
                                            style: TextRegular(
                                                AppColors.PrimaryBlackColor)),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text("Branch",
                                            style: FieldTextStyle(
                                                AppColors.PrimaryBlackColor)),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                            "📍 " +
                                                userData1!.fBranceName
                                                    .toString(),
                                            style: TextRegular(
                                                AppColors.PrimaryBlackColor)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              elevation: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // gradient: LinearGradient(
                                  //   colors: [
                                  //     AppColors.PrimaryMainColor,
                                  //     // Color(0xff72DAF7),
                                  //     Color(0xff6538A8),
                                  //   ],
                                  //   begin: Alignment.topLeft,
                                  //   end: Alignment.bottomRight,
                                  // ),
                                ),
                                child: ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 1.sp, top: 5.sp),
                                    child: Text(
                                      "Counsellor  Name",
                                      style: FieldTextStyle(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 5.sp, top: 5.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            userData1!.counsellorName
                                                .toString(),
                                            style: TextRegular(
                                                AppColors.PrimaryBlackColor)),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text("Counsellor  Email",
                                            style: FieldTextStyle(
                                                AppColors.PrimaryBlackColor)),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                            "📩  " +
                                                userData1!.fCounsellorEmail
                                                    .toString(),
                                            style: TextRegular(
                                                AppColors.PrimaryBlackColor)),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text("Counsellor Mobile",
                                            style: FieldTextStyle(
                                                AppColors.PrimaryBlackColor)),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                            "☎️  " +
                                                userData1!.fCounsellorMobile
                                                    .toString(),
                                            style: TextRegular(
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
                ),
        ));
  }
}
