import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/model/applicationStatusModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/applicationStatus/according_widget.dart';
import 'package:global_student/view/widget/app_bar.dart';

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

    //userData1 = "" as UsersDetailsModel;
    _gethomeData();
    // SaveName();
    super.initState();
  }

  getUserDetails() {
    dashBoardBloc.applicationControllerStream.listen((event) {
      if (event != null) {
        //   debugger();
        // print(event);
        applicationdata = event;
        for (int i = 0; i < applicationdata.length; i++) {
          ApplicationStatusModel applicationStatusModel =
              ApplicationStatusModel.fromJson(event[i]);
          application.add(applicationStatusModel);
        }
        // Application.add(userData1);
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
          title: "Application Status",
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
                  // ListTile(
                  //   leading: Text("Application",
                  //       style: Text2Regular(
                  //         AppColors.PrimaryBlackColor,
                  //       )),
                  //   trailing: Text("View All",
                  //       style: Text2Regular(
                  //         AppColors.PrimaryBlackColor,
                  //       )),
                  // ),
                  SizedBox(
                    height: 15.h,
                  ),
                  application.isEmpty
                      ? Container(
                          height: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 300,
                              ),
                              Center(
                                child: Text(
                                  "No Application Found",
                                  style: OtpText(AppColors.PrimaryMainColor),
                                ),
                              ),
                            ],
                          ),
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
                                  )),
                          ],
                        )
                ],
              ),
            ),
    );
  }
}
