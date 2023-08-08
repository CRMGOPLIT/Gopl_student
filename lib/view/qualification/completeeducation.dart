import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/model/qualificationsubmitModel.dart';
import '../../bloc/dashboardBloc.dart';
import '../../utils/color.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';
import '../widget/app_bar.dart';

class DonePage extends StatefulWidget {
  const DonePage({
    super.key,
  });

  @override
  // ignore: no_logic_in_create_state
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  late DashBoardBloc dashBoardBloc;

  List<QualificationSubmitModel> qualificationdatasubmit = [];
  List qualidata = [];
  bool loading2 = true;

  @override
  initState() {
    dashBoardBloc = DashBoardBloc();
    super.initState();
    getUserDetails();
    _gethomeData();
  }

  _gethomeData() {
    dashBoardBloc.callQualificationApi();
  }

  getUserDetails() async {
    dashBoardBloc.getqualificationcontrollerStream.listen((event) {
      if (event != null) {
        qualidata = event;
        for (int i = 0; i < qualidata.length; i++) {
          QualificationSubmitModel qualificationSubmitModel =
              QualificationSubmitModel.fromJson(event[i]);
          qualificationdatasubmit.add(qualificationSubmitModel);
        }

        setState(() {
          loading2 = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Qualification ",
            onpress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.bottomnav,
                (routes) => false,
              );
            },
          ),
        ),
        body: loading2 == true
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: AppColors.PrimaryMainColor,
              ))
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                    itemCount: qualificationdatasubmit.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: const BorderSide(
                              color: AppColors.PrimaryMainColor),
                        ),
                        elevation: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            subtitle: Padding(
                              padding: EdgeInsets.only(
                                bottom: 5.sp,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Container(
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.PrimaryMainColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Qualification   ",
                                            style: batchtext2(
                                                AppColors.PrimaryWhiteColor)),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                            qualificationdatasubmit[index]
                                                .fQualification
                                                .toString(),
                                            style: batchtext1(
                                                AppColors.PrimaryWhiteColor)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Text("Stream :- ",
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                          qualificationdatasubmit[index]
                                              .fCoursesStudied
                                              .toString(),
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text("Course Type :- ",
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                          qualificationdatasubmit[index]
                                              .fRegularDistance
                                              .toString(),
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("University/Board :- ",
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor)),
                                      Flexible(
                                        child: Text(
                                            qualificationdatasubmit[index]
                                                .fUniversityBoard
                                                .toString(),
                                            style: batchtext1(
                                                AppColors.PrimaryBlackColor)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text("Percentage/Grade :- ",
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor)),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                          qualificationdatasubmit[index]
                                              .fAvgGrade
                                              .toString(),
                                          style: batchtext1(
                                              AppColors.PrimaryBlackColor)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Start Year :- ",
                                              style: batchtext2(
                                                  AppColors.PrimaryBlackColor)),
                                          Text(
                                              qualificationdatasubmit[index]
                                                  .fStartingYear
                                                  .toString(),
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Text("Start Month :- ",
                                              style: batchtext2(
                                                  AppColors.PrimaryBlackColor)),
                                          Text(
                                              qualificationdatasubmit[index]
                                                  .startingMonth
                                                  .toString(),
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Pass Year :- ",
                                              style: batchtext2(
                                                  AppColors.PrimaryBlackColor)),
                                          Text(
                                              qualificationdatasubmit[index]
                                                  .fPassingYear
                                                  .toString(),
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Text("Pass Month :- ",
                                              style: batchtext2(
                                                  AppColors.PrimaryBlackColor)),
                                          Text(
                                              qualificationdatasubmit[index]
                                                  .passingMonth
                                                  .toString(),
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor)),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ));
  }
}
