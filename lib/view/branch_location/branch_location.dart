import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/branchDetailsModels.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';

class BranchLocation extends StatefulWidget {
  const BranchLocation({super.key});

  @override
  State<BranchLocation> createState() => _BranchLocationState();
}

class _BranchLocationState extends State<BranchLocation> {
  bool loanding = true;
  late DashBoardBloc dashBoardBloc;
  List<BranchDetailsModel> data = [];
  List branchData = [];

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getBranchDetails();
    _gethomeData();
    super.initState();
  }

  getBranchDetails() async {
    dashBoardBloc.branchControllerStream.listen((event) {
      if (event != null) {
        branchData = event;

        for (int i = 0; i < branchData.length; i++) {
          BranchDetailsModel branchDetailsModel =
              BranchDetailsModel.fromJson(event[i]);
          data.add(branchDetailsModel);
        }
        setState(() {
          loanding = false;
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callGetBranchDetailsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Branch Location",
          onpress: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.bottomnav,
              (routes) => false,
            );
          },
        ),
      ),
      body: loanding == true
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 2.w,
              color: AppColors.PrimaryMainColor,
            ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.r,
                                  right: 15.r,
                                  bottom: 5.r.r,
                                  top: 5.r),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 150.h,
                                    width: 330.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.PrimaryMainColor,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              data[index].branchUrl,
                                            ))),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150.h,
                                          width: 330.w,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(10.sp)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.r),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 70.h,
                                                    ),
                                                    Text(
                                                      data[index]
                                                          .branchName
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: batchtext2(AppColors
                                                          .PrimaryWhiteColor),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 15.sp,
                                                          color: AppColors
                                                              .PrimaryWhiteColor,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            final Uri url =
                                                                Uri.parse(data[
                                                                        index]
                                                                    .locationUrl);
                                                            if (!await launchUrl(
                                                                url,
                                                                mode: LaunchMode
                                                                    .externalApplication)) {
                                                              throw Exception(
                                                                  'Could not launch $url');
                                                            }
                                                          },
                                                          child: SizedBox(
                                                            width: 300.w,
                                                            child: Text(
                                                                data[index]
                                                                    .branchAddress
                                                                    .toString(),
                                                                maxLines: 3,
                                                                style: location(
                                                                    AppColors
                                                                        .PrimaryWhiteColor)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.phone,
                                                          size: 15.sp,
                                                          color: AppColors
                                                              .PrimaryWhiteColor,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        SizedBox(
                                                          width: 160.w,
                                                          child: Text(
                                                            data[index]
                                                                .branchPhone
                                                                .toString(),
                                                            style: batchtext2(
                                                                AppColors
                                                                    .PrimaryWhiteColor),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                )
              ],
            ),
    );
  }
}
