import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/model/applicationStatusModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/applicationStatus/according_widget.dart';
import 'package:global_student/view/widget/app_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/dashboardBloc.dart';

class ApplicationStatus extends StatefulWidget {
  const ApplicationStatus({super.key});

  @override
  State<ApplicationStatus> createState() => _ApplicationStatusState();
}

class _ApplicationStatusState extends State<ApplicationStatus> {
  bool isExpanded = false;
  int? num;
  late DashBoardBloc dashBoardBloc;
  List<ApplicationStatusModel> application = [];
  List applicationdata = [];

  bool loading = true;

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getUserDetails();
    _gethomeData();
    super.initState();
  }

  getUserDetails() {
    dashBoardBloc.applicationControllerStream.listen((event) {
      if (event != null) {
        applicationdata = event;
        for (int i = 0; i < applicationdata.length; i++) {
          ApplicationStatusModel applicationStatusModel =
              ApplicationStatusModel.fromJson(event[i]);
          application.add(applicationStatusModel);
        }

        setState(() {
          loading = false;
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callApplicationstatusApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "My Application Status",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.bottomnav);
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
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  application.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            Center(
                                child: Image.asset(
                              "assets/images/noapplication.png",
                              height: 230.h,
                              width: 250.w,
                              fit: BoxFit.contain,
                            )),
                            Text("No Application Found ?",
                                style: H2TextStyle(AppColors.PrimaryMainColor)),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text("Contact To Your Counsellor.",
                                style: batchtext2(AppColors.PrimaryMainColor)),
                            SizedBox(
                              height: 40.h,
                            ),
                            Container(
                              height: 50.h,
                              width: 185.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xff143C79),
                                      Color(0xff2A67C5),
                                    ],
                                  )),
                              child: ElevatedButton(
                                onPressed: _makingPhoneCall,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    textStyle: OtpText(Colors.green),
                                    shadowColor: Colors.transparent,
                                    elevation: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.phone),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Center(
                                      child:
                                          Text("Call Counsellor".toUpperCase(),
                                              style: batchtext2(
                                                AppColors.PrimaryWhiteColor,
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            for (int i = 0; i < application.length; i++)
                              Container(
                                  margin: EdgeInsets.only(
                                    left: 15.r,
                                    right: 15.r,
                                    bottom: 10.r,
                                  ),
                                  child: AccordingWidget(
                                    apinumber: application[i]
                                        .fCourcesAppliedId
                                        .toString(),
                                    country: application[i].country.toString(),
                                    institution:
                                        application[i].university.toString(),
                                    ug: application[i]
                                        .fCourseStandard
                                        .toString(),
                                    course: application[i]
                                        .fCourcesApplied
                                        .toString(),
                                    chort: application[i].fIntake.toString(),
                                    preference:
                                        application[i].fPreference.toString(),
                                    apidate:
                                        application[i].fCreationdate.toString(),
                                    apistatus: application[i]
                                        .fApplicationStage
                                        .toString(),
                                    aremark: application[i]
                                        .fApplicationRemark
                                        .toString(),
                                  )),
                          ],
                        )
                ],
              ),
            ),
    );
  }

  _makingPhoneCall() async {
    String? phonenumber;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phonenumber = prefs.getString('counsellorcall');
    var url = Uri.parse("tel:${phonenumber.toString()}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
