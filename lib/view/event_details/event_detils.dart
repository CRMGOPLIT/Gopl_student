import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/EventDetailsModel.dart';
import 'package:global_student/model/universityvisitModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool loanding = true;
  bool loanding1 = true;
  late DashBoardBloc dashBoardBloc;
  List<EvenetDetailsModel> data = [];

  List<UniversityVisitModel> universitydetails = [];
  List eventData = [];
  List universityData = [];

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getEventsDetails();
    getUniversityDetails();
    _gethomeData();
    super.initState();
  }

  getEventsDetails() async {
    dashBoardBloc.getEventDetailsStream.listen((event) {
      if (event != null) {
        eventData = event;
        for (int i = 0; i < eventData.length; i++) {
          EvenetDetailsModel evenetDetailsModel =
              EvenetDetailsModel.fromJson(event[i]);
          data.add(evenetDetailsModel);
        }

        setState(() {
          loanding = false;
        });
      }
    });
  }

  getUniversityDetails() async {
    dashBoardBloc.universityControllerStream.listen((event) {
      if (event != null) {
        universityData = event;

        for (int i = 0; i < universityData.length; i++) {
          UniversityVisitModel universityVisitModel =
              UniversityVisitModel.fromJson(event[i]);
          universitydetails.add(universityVisitModel);
        }

        setState(() {
          loanding1 = false;
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callGetEventDetailsApi();
    dashBoardBloc.callGetUniversityDetailsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Event Details",
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
          : DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: TabBar(
                        labelColor: AppColors.PrimaryWhiteColor,
                        indicatorColor: AppColors.PrimaryBlackColor,
                        unselectedLabelColor: AppColors.PrimaryMainColor,
                        padding: EdgeInsets.only(
                            left: 10.r, right: 10.r, bottom: 10.r),
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.PrimaryMainColor),
                        tabs: const [
                          Tab(
                            child: Text(
                              "University Visit",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Upcoming Events",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      //Tab 1

                      universitydetails.isEmpty
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 100.h,
                                  ),
                                  Center(
                                      child: Image.asset(
                                    "assets/images/noevent.png",
                                    height: 230.h,
                                    width: 250.w,
                                    fit: BoxFit.contain,
                                  )),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text("Event Coming soon...👨‍💻",
                                      style: H2TextStyle(
                                          AppColors.PrimaryMainColor)),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: universitydetails.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 5,
                                          top: 5)
                                      .r,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                            bottom: 10, top: 10)
                                        .r,
                                    decoration: BoxDecoration(
                                        color: AppColors.PrimaryWhiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(
                                                3,
                                                3,
                                              ),
                                              color: Colors.black12,
                                              blurRadius: 1.0,
                                              spreadRadius: 0.0),
                                        ]),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 8.r,
                                            right: 8.r,
                                            bottom: 8.r,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                universitydetails[index]
                                                    .branchName
                                                    .toString(),
                                                style: OtpText(
                                                    AppColors.PrimaryMainColor),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "University :- ",
                                                    style: batchtext2(AppColors
                                                        .PrimaryBlackColor),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      universitydetails[index]
                                                          .university
                                                          .toString(),
                                                      style: batchtext1(AppColors
                                                          .PrimaryMainColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 135.w,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Intake :- ",
                                                          style: batchtext2(
                                                              AppColors
                                                                  .PrimaryBlackColor),
                                                        ),
                                                        Text(
                                                          universitydetails[
                                                                  index]
                                                              .intake
                                                              .toString(),
                                                          style: batchtext1(
                                                              AppColors
                                                                  .PrimaryBlackColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Delegate :- ",
                                                          style: batchtext2(
                                                              AppColors
                                                                  .PrimaryBlackColor),
                                                        ),
                                                        SizedBox(
                                                          width: 115.w,
                                                          child: Text(
                                                            universitydetails[
                                                                    index]
                                                                .deligate
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: batchtext1(
                                                                AppColors
                                                                    .PrimaryBlackColor),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 135.w,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Date :- ",
                                                          style: batchtext2(
                                                              AppColors
                                                                  .PrimaryBlackColor),
                                                        ),
                                                        Text(
                                                          universitydetails[
                                                                  index]
                                                              .dateOfVisit
                                                              .toString(),
                                                          style: batchtext1(
                                                              AppColors
                                                                  .PrimaryBlackColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Country :- ",
                                                          style: batchtext2(
                                                              AppColors
                                                                  .PrimaryBlackColor),
                                                        ),
                                                        SizedBox(
                                                          width: 115.w,
                                                          child: Text(
                                                            universitydetails[
                                                                    index]
                                                                .country
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: batchtext1(
                                                                AppColors
                                                                    .PrimaryBlackColor),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.watch_later,
                                                    size: 20.sp,
                                                    color: AppColors
                                                        .PrimaryMainColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10.h,
                                                  ),
                                                  Text(
                                                    "${universitydetails[index].timeFrom} To ${universitydetails[index].timeTo}",
                                                    style: batchtext2(AppColors
                                                        .PrimaryBlackColor),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  // final Uri url = Uri.parse(
                                                  //     data[index]
                                                  //         .venueLocation);
                                                  // if (!await launchUrl(url,
                                                  //     mode: LaunchMode
                                                  //         .externalApplication)) {
                                                  //   throw Exception(
                                                  //       'Could not launch $url');
                                                  // }
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 20.sp,
                                                      color: AppColors
                                                          .PrimaryMainColor,
                                                    ),
                                                    SizedBox(
                                                      width: 10.h,
                                                    ),
                                                    SizedBox(
                                                      width: 280.w,
                                                      child: Text(
                                                        universitydetails[index]
                                                            .venue
                                                            .toString(),
                                                        style: location(AppColors
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
                                );
                              }),

                      data.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 100.h,
                                ),
                                Center(
                                    child: Image.asset(
                                  "assets/images/noevent.png",
                                  height: 230.h,
                                  width: 250.w,
                                  fit: BoxFit.contain,
                                )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text("Event Coming soon...👨‍💻",
                                    style: H2TextStyle(
                                        AppColors.PrimaryMainColor)),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 5,
                                          top: 5)
                                      .r,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.PrimaryWhiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(
                                                3,
                                                3,
                                              ),
                                              color: Colors.black12,
                                              blurRadius: 1.0,
                                              spreadRadius: 0.0),
                                        ]),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.r),
                                          child: Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.topRight,
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    height: 120.h,
                                                    width: 320.w,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                "assets/images/evh.png"
                                                                    .toString()))),
                                                  ),
                                                  Positioned(
                                                    left: 175.h,
                                                    top: 5.h,
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                        maxHeight:
                                                            double.infinity,
                                                      ),
                                                      width: 120.w,
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .PrimaryWhiteColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.r),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.r),
                                                        child: Text(
                                                          data[index]
                                                              .branch
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FieldTextStyle(
                                                              AppColors
                                                                  .PrimaryMainColor),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.r),
                                          child: Container(
                                            height: 1.h,
                                            width: 300.w,
                                            color: AppColors.PrimaryGreyColor,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.r,
                                              right: 8.r,
                                              bottom: 8.r,
                                              top: 8.r),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 320.w,
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: 'Date :- ',
                                                    style: batchtext2(AppColors
                                                        .PrimaryBlackColor),
                                                    children: [
                                                      TextSpan(
                                                        text: data[index]
                                                            .date
                                                            .toString()
                                                            .split(" ")[0],
                                                        style: batchtext1(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.watch_later,
                                                    size: 20.sp,
                                                    color: AppColors
                                                        .PrimaryMainColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10.h,
                                                  ),
                                                  Text(
                                                    data[index].time.toString(),
                                                    style: batchtext1(AppColors
                                                        .PrimaryBlackColor),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  final Uri url = Uri.parse(
                                                      data[index]
                                                          .venueLocation);
                                                  if (!await launchUrl(url,
                                                      mode: LaunchMode
                                                          .externalApplication)) {
                                                    throw Exception(
                                                        'Could not launch $url');
                                                  }
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 20.sp,
                                                      color: AppColors
                                                          .PrimaryMainColor,
                                                    ),
                                                    SizedBox(
                                                      width: 10.h,
                                                    ),
                                                    SizedBox(
                                                      width: 290.w,
                                                      child: Text(
                                                        data[index]
                                                            .venue
                                                            .toString(),
                                                        style: location(AppColors
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
                                );
                              }),
                    ]),
                  )
                ],
              ),
            ),
    );
  }
}
