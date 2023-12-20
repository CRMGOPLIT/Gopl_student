import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/gofairbloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/getappointmentmodel.dart';
import '../../model/getpendintAppointment.dart';
import '../../utils/color.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';
import '../widget/app_bar.dart';

class AppointmentHistory extends StatefulWidget {
  const AppointmentHistory({super.key});

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  late GoFairBloc goFairBloc;

  List<GetAppointmentModel> getAppointmentModel = [];

  List<GetPendingAppointment> getAppointmentpending = [];

  List<GetAppointmentModel> getAppointmentdenied = [];

  List<Color> colors = [];

  List appointmentdata = [];

  List appointmentdatapending = [];
  List appointmentdatadenied = [];

  String? studentid;
  bool? loading = true;
  bool? loading2 = true;

  num? completelength;
  num? deniedlength;
  num? totallen;
  List<Color> generateRandomColors() {
    List<Color> colorList = [
      const Color(0xffEEF5FF),
      const Color(0xffFFEEF0),
      const Color(0xffF4F3FF),
      const Color(0xffF2F9F6),
      const Color(0xffF9F2F6),
      const Color(0xffFFEEF9),
      const Color(0xffFFF6EE),
      const Color(0xffF3FCFF),
    ];

    colorList.shuffle(Random());
    return colorList;
  }

  Color getRandomColor() {
    if (colors.isEmpty) {
      colors = generateRandomColors();
    }
    return colors.removeLast();
  }

  List combinedList = [];
  @override
  void initState() {
    goFairBloc = GoFairBloc();
    getAppointmentData();
    getAppointmentPendingData();
    callAppointmentDetails();
    callAppointmentpending();
    super.initState();
  }

  void getAppointmentData() async {
    goFairBloc.gofairappointmentStream.listen((event) async {
      if (event != null) {
        appointmentdata = event;

        for (int i = 0; i < appointmentdata.length; i++) {
          GetAppointmentModel courseDetails =
              GetAppointmentModel.fromJson(event[i]);
          getAppointmentModel.add(courseDetails);
        }

        setState(() {
          loading2 = false;
        });
      }
    });
  }

  void getAppointmentPendingData() async {
    goFairBloc.gofairappointmentpendingStream.listen((event) async {
      if (event != null) {
        appointmentdatapending = event;
        for (int i = 0; i < appointmentdatapending.length; i++) {
          GetPendingAppointment getpendingappointment =
              GetPendingAppointment.fromJson(event[i]);
          getAppointmentpending.add(getpendingappointment);
        }

        setState(() {
          loading = false;
        });
      }
    });
  }

  callAppointmentDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");
    Map<String, dynamic> data = {
      "f_student_id": studentid.toString(),
      "f_appointment_status": "Visited"
    };
    goFairBloc.callAppointmentDetails(data);
  }

  callAppointmentpending() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");
    Map<String, dynamic> data = {
      "f_student_id": studentid.toString(),
      "f_appointment_status": "NotUpdated"
    };

    goFairBloc.callAppointmentPendingDetails(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Appointment History",
            onpress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.gofair,
                (routes) => false,
              );
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8).r,
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20).r),
                        child: TabBar(
                          labelColor: AppColors.PrimaryWhiteColor,
                          indicatorColor: AppColors.PrimaryBlackColor,
                          unselectedLabelColor: AppColors.PrimaryMainColor,
                          padding: EdgeInsets.only(
                              left: 10.r, right: 10.r, bottom: 10.r),
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50).r,
                              color: AppColors.PrimaryMainColor),
                          tabs: const [
                            Tab(
                              child: Text(
                                "Upcoming",
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Completed",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        loading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                strokeWidth: 2.w,
                                color: AppColors.PrimaryMainColor,
                              ))
                            : getAppointmentpending.isNotEmpty
                                ? ListView.builder(
                                    itemCount: getAppointmentpending.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8).r,
                                        child: Card(
                                          elevation: 10,
                                          color: getRandomColor(),
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color:
                                                    AppColors.PrimaryMainColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10).r),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 20.h,
                                                decoration: BoxDecoration(
                                                    //color: AppColors.PrimaryMainColor,

                                                    borderRadius:
                                                        BorderRadius.only(
                                                  topRight:
                                                      const Radius.circular(10)
                                                          .r,
                                                  topLeft:
                                                      const Radius.circular(10)
                                                          .r,
                                                )),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    top: 5)
                                                                .r,
                                                        child: Icon(
                                                          Icons.circle_rounded,
                                                          color: Colors.green,
                                                          size: 15.sp,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 90.w,
                                                      ),
                                                      Text(
                                                        "Appointment Details",
                                                        style: FieldTextStyle(
                                                            AppColors
                                                                .PrimaryBlackColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Container(
                                                height: 0.5.h,
                                                color:
                                                    AppColors.PrimaryBlackColor,
                                              ),
                                              ListTile(
                                                dense: true,
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: 0,
                                                        vertical: -4),
                                                leading: const Icon(
                                                  Icons.school,
                                                  color: AppColors
                                                      .PrimaryMainColor,
                                                ),
                                                title: Text(
                                                  getAppointmentpending[index]
                                                      .universityVisit
                                                      .toString(),
                                                  style: batchtext2(AppColors
                                                      .PrimaryBlackColor),
                                                ),
                                              ),
                                              ListTile(
                                                  dense: true,
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: 0,
                                                          vertical: -4),
                                                  leading: const Icon(
                                                    Icons.person_2_outlined,
                                                    color: AppColors
                                                        .PrimaryMainColor,
                                                  ),
                                                  title: Text(
                                                    getAppointmentpending[index]
                                                        .studentName
                                                        .toString(),
                                                    style: batchtext2(AppColors
                                                        .PrimaryBlackColor),
                                                  )),
                                              ListTile(
                                                  dense: true,
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: 0,
                                                          vertical: -4),
                                                  leading: const Icon(
                                                    Icons.date_range,
                                                    color: AppColors
                                                        .PrimaryMainColor,
                                                  ),
                                                  title: Text(
                                                    getAppointmentpending[index]
                                                        .appointmentDate
                                                        .toString(),
                                                    style: batchtext2(AppColors
                                                        .PrimaryBlackColor),
                                                  )),
                                              ListTile(
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: 0,
                                                        vertical: -4),
                                                dense: true,
                                                leading: const Icon(
                                                  Icons.watch_later_rounded,
                                                  color: AppColors
                                                      .PrimaryMainColor,
                                                ),
                                                title: Text(
                                                  getAppointmentpending[index]
                                                      .appointmentTime
                                                      .toString(),
                                                  style: batchtext2(AppColors
                                                      .PrimaryBlackColor),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Image.asset(
                                                  "assets/images/nofair.png",
                                                  height: 70.h,
                                                  width: 180.w,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/notcomlete.png",
                                        height: 200.h,
                                        width: 400.w,
                                      ),
                                      Text(
                                        "Please Book your Appointment...",
                                        style: batchtext2(
                                            AppColors.PrimaryMainColor),
                                      )
                                    ],
                                  ),
                        loading2 == true
                            ? Center(
                                child: CircularProgressIndicator(
                                strokeWidth: 2.w,
                                color: AppColors.PrimaryMainColor,
                              ))
                            : getAppointmentModel.isNotEmpty
                                ? ListView.builder(
                                    itemCount: getAppointmentModel.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Column(
                                          children: [
                                            // getAppointmentdenied.isEmpty
                                            //     ? Stack(
                                            //         children: [
                                            //           Card(
                                            //             elevation: 10,
                                            //             color: getRandomColor(),
                                            //             shape:
                                            //                 RoundedRectangleBorder(
                                            //                     side:
                                            //                         const BorderSide(
                                            //                       color: AppColors
                                            //                           .PrimaryMainColor,
                                            //                     ),
                                            //                     borderRadius:
                                            //                         BorderRadius
                                            //                             .circular(
                                            //                                 10)),
                                            //             child: Column(
                                            //               crossAxisAlignment:
                                            //                   CrossAxisAlignment
                                            //                       .start,
                                            //               children: [
                                            //                 Container(
                                            //                   width: double
                                            //                       .infinity,
                                            //                   height: 20.h,
                                            //                   decoration:
                                            //                       BoxDecoration(
                                            //                           borderRadius:
                                            //                               BorderRadius
                                            //                                   .only(
                                            //                     topRight:
                                            //                         const Radius
                                            //                                 .circular(10)
                                            //                             .r,
                                            //                     topLeft:
                                            //                         const Radius
                                            //                                 .circular(10)
                                            //                             .r,
                                            //                   )),
                                            //                   child: Center(
                                            //                     child: Row(
                                            //                       children: [
                                            //                         Padding(
                                            //                           padding: EdgeInsets.only(
                                            //                                   left: 10.h,
                                            //                                   top: 5.h)
                                            //                               .r,
                                            //                           child:
                                            //                               Icon(
                                            //                             Icons
                                            //                                 .circle_rounded,
                                            //                             color: Colors
                                            //                                 .red,
                                            //                             size: 15
                                            //                                 .sp,
                                            //                           ),
                                            //                         ),
                                            //                         SizedBox(
                                            //                           width:
                                            //                               90.w,
                                            //                         ),
                                            //                         Text(
                                            //                             "ejnwkjn ke"),
                                            //                         Text(
                                            //                           "Appointment Details",
                                            //                           style: FieldTextStyle(
                                            //                               AppColors
                                            //                                   .PrimaryBlackColor),
                                            //                         ),
                                            //                       ],
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //                 SizedBox(
                                            //                   height: 5.h,
                                            //                 ),
                                            //                 Container(
                                            //                   height: 0.5.h,
                                            //                   color: AppColors
                                            //                       .PrimaryBlackColor,
                                            //                 ),
                                            //                 ListTile(
                                            //                   dense: true,
                                            //                   visualDensity:
                                            //                       const VisualDensity(
                                            //                           horizontal:
                                            //                               0,
                                            //                           vertical:
                                            //                               -4),
                                            //                   leading:
                                            //                       const Icon(
                                            //                     Icons.school,
                                            //                     color: AppColors
                                            //                         .PrimaryMainColor,
                                            //                   ),
                                            //                   title: Text(
                                            //                     getAppointmentModel[
                                            //                             index]
                                            //                         .universityVisit,
                                            //                     style: batchtext2(
                                            //                         AppColors
                                            //                             .PrimaryBlackColor),
                                            //                   ),
                                            //                 ),
                                            //                 ListTile(
                                            //                     dense: true,
                                            //                     visualDensity:
                                            //                         const VisualDensity(
                                            //                             horizontal:
                                            //                                 0,
                                            //                             vertical:
                                            //                                 -4),
                                            //                     leading:
                                            //                         const Icon(
                                            //                       Icons
                                            //                           .person_2_outlined,
                                            //                       color: AppColors
                                            //                           .PrimaryMainColor,
                                            //                     ),
                                            //                     title: Text(
                                            //                       getAppointmentModel[
                                            //                               index]
                                            //                           .studentName,
                                            //                       style: batchtext2(
                                            //                           AppColors
                                            //                               .PrimaryBlackColor),
                                            //                     )),
                                            //                 ListTile(
                                            //                     dense: true,
                                            //                     visualDensity:
                                            //                         const VisualDensity(
                                            //                             horizontal:
                                            //                                 0,
                                            //                             vertical:
                                            //                                 -4),
                                            //                     leading:
                                            //                         const Icon(
                                            //                       Icons
                                            //                           .date_range,
                                            //                       color: AppColors
                                            //                           .PrimaryMainColor,
                                            //                     ),
                                            //                     title: Text(
                                            //                       getAppointmentModel[
                                            //                               index]
                                            //                           .appointmentDate,
                                            //                       style: batchtext2(
                                            //                           AppColors
                                            //                               .PrimaryBlackColor),
                                            //                     )),
                                            //                 ListTile(
                                            //                   visualDensity:
                                            //                       const VisualDensity(
                                            //                           horizontal:
                                            //                               0,
                                            //                           vertical:
                                            //                               -4),
                                            //                   dense: true,
                                            //                   leading:
                                            //                       const Icon(
                                            //                     Icons
                                            //                         .watch_later_rounded,
                                            //                     color: AppColors
                                            //                         .PrimaryMainColor,
                                            //                   ),
                                            //                   title: Text(
                                            //                     getAppointmentModel[
                                            //                             index]
                                            //                         .appointmentTime,
                                            //                     style: batchtext2(
                                            //                         AppColors
                                            //                             .PrimaryBlackColor),
                                            //                   ),
                                            //                 ),
                                            //                 SizedBox(
                                            //                   width: 10.w,
                                            //                 ),
                                            //                 Align(
                                            //                   alignment: Alignment
                                            //                       .bottomRight,
                                            //                   child: getAppointmentModel[
                                            //                                   index]
                                            //                               .reConfirmStatus ==
                                            //                           "Visited"
                                            //                       ? Image.asset(
                                            //                           "assets/images/thankyou1.png",
                                            //                           height:
                                            //                               70.h,
                                            //                           width:
                                            //                               180.w,
                                            //                           fit: BoxFit
                                            //                               .fill,
                                            //                         )
                                            //                       : Image.asset(
                                            //                           "assets/images/deniedimg.png",
                                            //                           height:
                                            //                               70.h,
                                            //                           width:
                                            //                               100.w,
                                            //                           fit: BoxFit
                                            //                               .fill,
                                            //                         ),
                                            //                 ),
                                            //               ],
                                            //             ),
                                            //           ),
                                            //           Positioned(
                                            //               left: 170.w,
                                            //               top: 40.h,
                                            //               child: getAppointmentModel[
                                            //                               index]
                                            //                           .reConfirmStatus ==
                                            //                       "Visited"
                                            //                   ? Image.asset(
                                            //                       "assets/images/completed.png",
                                            //                       height: 100.h,
                                            //                       width: 180.w,
                                            //                     )
                                            //                   : Image.asset(
                                            //                       "assets/images/denied.png",
                                            //                       height: 140.h,
                                            //                       width: 200.w,
                                            //                     )),
                                            //         ],
                                            //       )
                                            //     : Container(),
                                            Stack(
                                              children: [
                                                Card(
                                                  elevation: 10,
                                                  color: getRandomColor(),
                                                  shape: RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        height: 20.h,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                          topRight: const Radius
                                                                  .circular(10)
                                                              .r,
                                                          topLeft: const Radius
                                                                  .circular(10)
                                                              .r,
                                                        )),
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        top: 5)
                                                                    .r,
                                                                child: Icon(
                                                                  Icons
                                                                      .circle_rounded,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 15.sp,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 90.w,
                                                              ),
                                                              Text(
                                                                "Appointment Details",
                                                                style: FieldTextStyle(
                                                                    AppColors
                                                                        .PrimaryBlackColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Container(
                                                        height: 0.5.h,
                                                        color: AppColors
                                                            .PrimaryBlackColor,
                                                      ),
                                                      ListTile(
                                                        dense: true,
                                                        visualDensity:
                                                            const VisualDensity(
                                                                horizontal: 0,
                                                                vertical: -4),
                                                        leading: const Icon(
                                                          Icons.school,
                                                          color: AppColors
                                                              .PrimaryMainColor,
                                                        ),
                                                        title: Text(
                                                          getAppointmentModel[
                                                                  index]
                                                              .universityVisit
                                                              .toString(),
                                                          style: batchtext2(
                                                              AppColors
                                                                  .PrimaryBlackColor),
                                                        ),
                                                      ),
                                                      ListTile(
                                                          dense: true,
                                                          visualDensity:
                                                              const VisualDensity(
                                                                  horizontal: 0,
                                                                  vertical: -4),
                                                          leading: const Icon(
                                                            Icons
                                                                .person_2_outlined,
                                                            color: AppColors
                                                                .PrimaryMainColor,
                                                          ),
                                                          title: Text(
                                                            getAppointmentModel[
                                                                    index]
                                                                .studentName
                                                                .toString(),
                                                            style: batchtext2(
                                                                AppColors
                                                                    .PrimaryBlackColor),
                                                          )),
                                                      ListTile(
                                                          dense: true,
                                                          visualDensity:
                                                              const VisualDensity(
                                                                  horizontal: 0,
                                                                  vertical: -4),
                                                          leading: const Icon(
                                                            Icons.date_range,
                                                            color: AppColors
                                                                .PrimaryMainColor,
                                                          ),
                                                          title: Text(
                                                            getAppointmentModel[
                                                                    index]
                                                                .appointmentDate
                                                                .toString(),
                                                            style: batchtext2(
                                                                AppColors
                                                                    .PrimaryBlackColor),
                                                          )),
                                                      ListTile(
                                                        visualDensity:
                                                            const VisualDensity(
                                                                horizontal: 0,
                                                                vertical: -4),
                                                        dense: true,
                                                        leading: const Icon(
                                                          Icons
                                                              .watch_later_rounded,
                                                          color: AppColors
                                                              .PrimaryMainColor,
                                                        ),
                                                        title: Text(
                                                          getAppointmentModel[
                                                                  index]
                                                              .appointmentTime
                                                              .toString(),
                                                          style: batchtext2(
                                                              AppColors
                                                                  .PrimaryBlackColor),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: getAppointmentModel[
                                                                        index]
                                                                    .reConfirmStatus ==
                                                                "Visited"
                                                            ? Image.asset(
                                                                "assets/images/thankyou1.png",
                                                                height: 70.h,
                                                                width: 180.w,
                                                                fit:
                                                                    BoxFit.fill,
                                                              )
                                                            : Image.asset(
                                                                "assets/images/deniedimg.png",
                                                                height: 70.h,
                                                                width: 100.w,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                    left: 170.w,
                                                    top: 40.h,
                                                    child: getAppointmentModel[
                                                                    index]
                                                                .reConfirmStatus ==
                                                            "Visited"
                                                        ? Image.asset(
                                                            "assets/images/completed.png",
                                                            height: 100.h,
                                                            width: 180.w,
                                                          )
                                                        : getAppointmentModel[
                                                                        index]
                                                                    .reConfirmStatus ==
                                                                "Denied"
                                                            ? Container()
                                                            : Image.asset(
                                                                "assets/images/denied.png",
                                                                height: 140.h,
                                                                width: 200.w,
                                                              )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    })
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/notcomlete.png",
                                        height: 200.h,
                                        width: 400.w,
                                      ),
                                      Text(
                                        "Visit Global Opportunities Education Fair",
                                        style: batchtext2(
                                            AppColors.PrimaryMainColor),
                                      )
                                    ],
                                  ),
                      ]),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
