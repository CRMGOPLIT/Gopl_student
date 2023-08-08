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
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                elevation: 4,
                                child: Container(
                                  height: 165.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.PrimaryGreyColor),
                                      color: AppColors.PrimaryWhiteColor,
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Image.network(
                                            data[index].branchUrl,
                                            height: 103.h,
                                            width: 320.w,
                                            fit: BoxFit.fill,
                                          ),
                                          Positioned(
                                            left: 190.w,
                                            top: 4.h,
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                maxHeight: double.infinity,
                                              ),
                                              width: 120.w,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.PrimaryWhiteColor
                                                        .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.r),
                                                child: Text(
                                                  data[index]
                                                      .branchName
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: FieldTextStyle(
                                                      AppColors
                                                          .PrimaryMainColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 60.h,
                                        padding: EdgeInsets.all(5.h),
                                        decoration: const BoxDecoration(
                                            color: AppColors.PrimaryWhiteColor),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 15.sp,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    final Uri url = Uri.parse(
                                                        data[index]
                                                            .locationUrl);
                                                    if (!await launchUrl(url,
                                                        mode: LaunchMode
                                                            .externalApplication)) {
                                                      throw Exception(
                                                          'Could not launch $url');
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    width: 280.w,
                                                    child: Text(
                                                        data[index]
                                                            .branchAddress
                                                            .toString(),
                                                        maxLines: 2,
                                                        style: location(AppColors
                                                            .PrimaryMainColor)),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                openDialPad(
                                                    data[index].branchPhone);
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    size: 15.sp,
                                                    color: Colors.green,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  SizedBox(
                                                    width: 160.w,
                                                    child: Text(
                                                      data[index]
                                                          .branchPhone
                                                          .toString(),
                                                      style: batchtext1(AppColors
                                                          .PrimaryMainColor),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }

  openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
