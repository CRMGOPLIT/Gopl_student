import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

  List<Color> colors = [];

  List appointmentdata = [];

  List appointmentdatapending = [];
  // String studentid = Get.arguments;
  String? studentid;
  bool? loading = true;
  bool? loading2 = true;
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
                                            const EdgeInsets.only(bottom: 8),
                                        child: Card(
                                          elevation: 10,
                                          // color: Colors.white,
                                          color: getRandomColor(),
                                          shape: RoundedRectangleBorder(
                                              //<-- SEE HERE
                                              side: const BorderSide(
                                                color:
                                                    AppColors.PrimaryMainColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                                                            EdgeInsets.only(
                                                                    left: 10.h,
                                                                    top: 5.h)
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
                                                      .universityVisit,
                                                  style: batchtext2(AppColors
                                                      .PrimaryBlackColor),
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 8, top: 8),
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(
                                              //         Icons.school,
                                              //         color: AppColors.PrimaryMainColor,
                                              //       ),
                                              //       SizedBox(
                                              //         width: 20.w,
                                              //       ),
                                              //       Text(
                                              //         "Abc university",
                                              //         style: batchtext2(
                                              //             AppColors.PrimaryBlackColor),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),

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
                                                        .studentName,
                                                    style: batchtext2(AppColors
                                                        .PrimaryBlackColor),
                                                  )),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 8, top: 8),
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(
                                              //         Icons.person,
                                              //         color: AppColors.PrimaryMainColor,
                                              //       ),
                                              //       Text(
                                              //         "Mohit Kumar",
                                              //         style: batchtext2(
                                              //             AppColors.PrimaryBlackColor),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),

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
                                                        .appointmentDate,
                                                    style: batchtext2(AppColors
                                                        .PrimaryBlackColor),
                                                  )),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 8, top: 8),
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(
                                              //         Icons.date_range,
                                              //         color: AppColors.PrimaryMainColor,
                                              //       ),
                                              //       SizedBox(
                                              //         width: 20.w,
                                              //       ),

                                              //       Text(
                                              //         "12/24/56",
                                              //         style: batchtext2(
                                              //             AppColors.PrimaryBlackColor),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),

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
                                                      .appointmentTime,
                                                  style: batchtext2(AppColors
                                                      .PrimaryBlackColor),
                                                ),
                                              ),
                                              // Align(
                                              //   alignment: Alignment.center,
                                              //   child: ListTile(
                                              //     visualDensity: VisualDensity(
                                              //         horizontal: 0, vertical: -4),
                                              //     dense: true,
                                              //     leading: Icon(
                                              //       Icons.watch_later_rounded,
                                              //       color: AppColors.PrimaryMainColor,
                                              //     ),
                                              //     title: Text(
                                              //       "Pending",
                                              //       style: batchtext2(
                                              //           AppColors.PrimaryBlackColor),
                                              //     ),
                                              //   ),
                                              // )
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
                                        "Plese Wait... ",
                                        style: batchtext2(
                                            AppColors.PrimaryBlackColor),
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
                                        child: Card(
                                          elevation: 10,
                                          // color: Colors.white,
                                          color: getRandomColor(),
                                          shape: RoundedRectangleBorder(
                                              //<-- SEE HERE
                                              side: const BorderSide(
                                                color:
                                                    AppColors.PrimaryMainColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                                                            EdgeInsets.only(
                                                                    left: 10.h,
                                                                    top: 5.h)
                                                                .r,
                                                        child: Icon(
                                                          Icons.circle_rounded,
                                                          color: Colors.red,
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
                                                  getAppointmentModel[index]
                                                      .universityVisit,
                                                  style: batchtext2(AppColors
                                                      .PrimaryBlackColor),
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 8, top: 8),
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(
                                              //         Icons.school,
                                              //         color: AppColors.PrimaryMainColor,
                                              //       ),
                                              //       SizedBox(
                                              //         width: 20.w,
                                              //       ),
                                              //       Text(
                                              //         "Abc university",
                                              //         style: batchtext2(
                                              //             AppColors.PrimaryBlackColor),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),

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
                                                    getAppointmentModel[index]
                                                        .studentName,
                                                    style: batchtext2(AppColors
                                                        .PrimaryBlackColor),
                                                  )),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 8, top: 8),
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(
                                              //         Icons.person,
                                              //         color: AppColors.PrimaryMainColor,
                                              //       ),
                                              //       Text(
                                              //         "Mohit Kumar",
                                              //         style: batchtext2(
                                              //             AppColors.PrimaryBlackColor),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),

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
                                                    getAppointmentModel[index]
                                                        .appointmentDate,
                                                    style: batchtext2(AppColors
                                                        .PrimaryBlackColor),
                                                  )),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 8, top: 8),
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(
                                              //         Icons.date_range,
                                              //         color: AppColors.PrimaryMainColor,
                                              //       ),
                                              //       SizedBox(
                                              //         width: 20.w,
                                              //       ),

                                              //       Text(
                                              //         "12/24/56",
                                              //         style: batchtext2(
                                              //             AppColors.PrimaryBlackColor),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),

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
                                                  getAppointmentModel[index]
                                                      .appointmentTime,
                                                  style: batchtext2(AppColors
                                                      .PrimaryBlackColor),
                                                ),
                                              ),
                                              // Align(
                                              //   alignment: Alignment.center,
                                              //   child: ListTile(
                                              //     visualDensity: VisualDensity(
                                              //         horizontal: 0, vertical: -4),
                                              //     dense: true,
                                              //     leading: Icon(
                                              //       Icons.watch_later_rounded,
                                              //       color: AppColors.PrimaryMainColor,
                                              //     ),
                                              //     title: Text(
                                              //       "Pending",
                                              //       style: batchtext2(
                                              //           AppColors.PrimaryBlackColor),
                                              //     ),
                                              //   ),
                                              // )
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Image.asset(
                                                  "assets/images/thankyou.png",
                                                  height: 60.h,
                                                  width: 150.w,
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
                                        "Please Wait... ",
                                        style: batchtext2(
                                            AppColors.PrimaryBlackColor),
                                      )
                                    ],
                                  ),

                        // ListView.builder(
                        //     itemCount: getAppointmentModel.length,
                        //     itemBuilder: (context, index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.only(bottom: 8),
                        //         child: Card(
                        //           elevation: 10,
                        //           color: getRandomColor(),
                        //           shape: RoundedRectangleBorder(
                        //               //<-- SEE HERE
                        //               // side: const BorderSide(
                        //               //   color: AppColors.PrimaryMainColor,
                        //               // ),
                        //               borderRadius: BorderRadius.circular(15)),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 width: double.infinity,
                        //                 height: 20.h,
                        //                 decoration: BoxDecoration(
                        //                     //color: AppColors.PrimaryMainColor,
                        //                     borderRadius: BorderRadius.only(
                        //                   topRight: const Radius.circular(10).r,
                        //                   topLeft: const Radius.circular(10).r,
                        //                 )),
                        //                 child: Center(
                        //                   child: Text(
                        //                     getAppointmentModel[index]
                        //                         .universityVisit,
                        //                     style: batchtext2(
                        //                         AppColors.PrimaryBlackColor),
                        //                   ),
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 height: 5.h,
                        //               ),
                        //               Container(
                        //                 height: 0.5.h,
                        //                 color: AppColors.PrimaryBlackColor,
                        //               ),
                        //               ListTile(
                        //                 dense: true,
                        //                 visualDensity: const VisualDensity(
                        //                     horizontal: 0, vertical: -4),
                        //                 leading: const Icon(
                        //                   Icons.school,
                        //                   color: AppColors.PrimaryMainColor,
                        //                 ),
                        //                 title: Text(
                        //                   getAppointmentModel[index]
                        //                       .description,
                        //                   style: batchtext2(
                        //                       AppColors.PrimaryBlackColor),
                        //                 ),
                        //               ),
                        //               // Padding(
                        //               //   padding: const EdgeInsets.only(
                        //               //       left: 8, top: 8),
                        //               //   child: Row(
                        //               //     children: [
                        //               //       Icon(
                        //               //         Icons.school,
                        //               //         color: AppColors.PrimaryMainColor,
                        //               //       ),
                        //               //       SizedBox(
                        //               //         width: 20.w,
                        //               //       ),
                        //               //       Text(
                        //               //         "Abc university",
                        //               //         style: batchtext2(
                        //               //             AppColors.PrimaryBlackColor),
                        //               //       )
                        //               //     ],
                        //               //   ),
                        //               // ),

                        //               ListTile(
                        //                   dense: true,
                        //                   visualDensity: const VisualDensity(
                        //                       horizontal: 0, vertical: -4),
                        //                   leading: const Icon(
                        //                     Icons.person_2_outlined,
                        //                     color: AppColors.PrimaryMainColor,
                        //                   ),
                        //                   title: Text(
                        //                     getAppointmentModel[index]
                        //                         .studentName,
                        //                     style: batchtext2(
                        //                         AppColors.PrimaryBlackColor),
                        //                   )),
                        //               // Padding(
                        //               //   padding: const EdgeInsets.only(
                        //               //       left: 8, top: 8),
                        //               //   child: Row(
                        //               //     children: [
                        //               //       Icon(
                        //               //         Icons.person,
                        //               //         color: AppColors.PrimaryMainColor,
                        //               //       ),
                        //               //       Text(
                        //               //         "Mohit Kumar",
                        //               //         style: batchtext2(
                        //               //             AppColors.PrimaryBlackColor),
                        //               //       )
                        //               //     ],
                        //               //   ),
                        //               // ),

                        //               ListTile(
                        //                   dense: true,
                        //                   visualDensity: const VisualDensity(
                        //                       horizontal: 0, vertical: -4),
                        //                   leading: const Icon(
                        //                     Icons.date_range,
                        //                     color: AppColors.PrimaryMainColor,
                        //                   ),
                        //                   title: Text(
                        //                     getAppointmentModel[index]
                        //                         .appointmentDate,
                        //                     style: batchtext2(
                        //                         AppColors.PrimaryBlackColor),
                        //                   )),
                        //               // Padding(
                        //               //   padding: const EdgeInsets.only(
                        //               //       left: 8, top: 8),
                        //               //   child: Row(
                        //               //     children: [
                        //               //       Icon(
                        //               //         Icons.date_range,
                        //               //         color: AppColors.PrimaryMainColor,
                        //               //       ),
                        //               //       SizedBox(
                        //               //         width: 20.w,
                        //               //       ),

                        //               //       Text(
                        //               //         "12/24/56",
                        //               //         style: batchtext2(
                        //               //             AppColors.PrimaryBlackColor),
                        //               //       )
                        //               //     ],
                        //               //   ),
                        //               // ),

                        //               ListTile(
                        //                 visualDensity: const VisualDensity(
                        //                     horizontal: 0, vertical: -4),
                        //                 dense: true,
                        //                 leading: const Icon(
                        //                   Icons.watch_later_rounded,
                        //                   color: AppColors.PrimaryMainColor,
                        //                 ),
                        //                 title: Text(
                        //                   getAppointmentModel[index]
                        //                       .appointmentTime,
                        //                   style: batchtext2(
                        //                       AppColors.PrimaryBlackColor),
                        //                 ),
                        //               ),

                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   const Icon(
                        //                       Icons.directions_walk_rounded,
                        //                       color:
                        //                           AppColors.PrimaryBlackColor),
                        //                   SizedBox(
                        //                     width: 10.w,
                        //                   ),
                        //                   Text(
                        //                     "Completed",
                        //                     style: batchtext2(Colors.green),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 40.h,
                        //                   )
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     })

                        // Text(
                        //   "denkljnej;rknoi",
                        //   style: batchtext2(AppColors.PrimaryBlackColor),
                        // )
                        // ListView.builder(
                        //     itemCount: 1,
                        //     itemBuilder: (context, index) {
                        //       return Container(
                        //         decoration: BoxDecoration(
                        //             //  color: Color(0xffF0CED2),
                        //             border: Border.all(
                        //                 color:
                        //                     AppColors.PrimaryMainColor),
                        //             borderRadius:
                        //                 BorderRadius.circular(10)
                        //             // borderRadius: BorderRadius.only(
                        //             //   bottomLeft: Radius.circular(20),
                        //             //   bottomRight: Radius.circular(20),
                        //             // )
                        //             ),
                        //         child: Card(
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 height: 80.h,
                        //                 width: 400.w,
                        //                 decoration: BoxDecoration(
                        //                     //color: AppColors.PrimaryGreyColor,
                        //                     borderRadius:
                        //                         BorderRadius.circular(10)
                        //                             .r
                        //                     // borderRadius: BorderRadius.only(
                        //                     //   bottomLeft: Radius.circular(20),
                        //                     //   bottomRight: Radius.circular(20),
                        //                     // )
                        //                     ),
                        //                 child: Padding(
                        //                   padding:
                        //                       const EdgeInsets.all(8.0).r,
                        //                   child: Row(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       Column(
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment
                        //                                   .start,
                        //                           children: [
                        //                             // SizedBox(
                        //                             //   height: 5.h,
                        //                             // ),

                        //                             // AnimatedTextKit(
                        //                             //   isRepeatingAnimation: true,
                        //                             //   repeatForever: true,
                        //                             //   animatedTexts: [
                        //                             //     TyperAnimatedText(
                        //                             //         'Current Priority Pass :-  G O L D',
                        //                             //         textStyle: batchtext2(
                        //                             //             AppColors.PrimaryWhiteColor)),
                        //                             //   ],
                        //                             //   pause: const Duration(milliseconds: 2000),
                        //                             //   displayFullTextOnTap: true,
                        //                             //   stopPauseOnTap: true,
                        //                             // ),
                        //                             // Text(
                        //                             //   "Current Priority Pass :- Gold",
                        //                             //   style:
                        //                             //       batchtext2(AppColors.PrimaryWhiteColor),
                        //                             // ),
                        //                             SizedBox(
                        //                               height: 5.h,
                        //                             ),
                        //                             Text(
                        //                               "Student :- Mohit Kumar",
                        //                               style: batchtext2(
                        //                                   AppColors
                        //                                       .PrimaryBlackColor),
                        //                             ),
                        //                             SizedBox(
                        //                               height: 5.h,
                        //                             ),
                        //                             Text(
                        //                               "Branch :- South Delhi",
                        //                               style: batchtext2(
                        //                                   AppColors
                        //                                       .PrimaryBlackColor),
                        //                             ),
                        //                             SizedBox(
                        //                               height: 5.h,
                        //                             ),
                        //                             Text(
                        //                               "Counselor :-  Global opportunities Pvt. Ltd.",
                        //                               style: batchtext2(
                        //                                   AppColors
                        //                                       .PrimaryBlackColor),
                        //                             ),
                        //                           ]),
                        //                       const Spacer(),
                        //                       Column(
                        //                         children: [
                        //                           Image.network(
                        //                             "https://icon-library.com/images/platinum-icon/platinum-icon-27.jpg",
                        //                             height: 50.h,
                        //                           ),
                        //                           Text(
                        //                             "342345",
                        //                             style: batchtext2(
                        //                                 AppColors
                        //                                     .PrimaryMainColor),
                        //                           )
                        //                         ],
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //               Container(
                        //                 height: 1.h,
                        //                 color:
                        //                     AppColors.PrimaryBlackColor,
                        //               ),
                        //               Padding(
                        //                 padding:
                        //                     const EdgeInsets.all(8.0).r,
                        //                 child: Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     RichText(
                        //                       overflow: TextOverflow.clip,
                        //                       textAlign: TextAlign.end,
                        //                       textDirection:
                        //                           TextDirection.rtl,
                        //                       softWrap: true,
                        //                       maxLines: 1,
                        //                       textScaleFactor: 1,
                        //                       text: TextSpan(
                        //                         text: 'Email :- ',
                        //                         style: batchtext2(AppColors
                        //                             .PrimaryBlackColor),
                        //                         children: <TextSpan>[
                        //                           TextSpan(
                        //                               text:
                        //                                   'Email@gmail.com',
                        //                               style: batchtext1(
                        //                                   AppColors
                        //                                       .PrimaryBlackColor)),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 5.h,
                        //                     ),
                        //                     RichText(
                        //                       overflow: TextOverflow.clip,
                        //                       textAlign: TextAlign.end,
                        //                       textDirection:
                        //                           TextDirection.rtl,
                        //                       softWrap: true,
                        //                       maxLines: 1,
                        //                       textScaleFactor: 1,
                        //                       text: TextSpan(
                        //                         text: 'Mobile :- ',
                        //                         style: batchtext2(AppColors
                        //                             .PrimaryBlackColor),
                        //                         children: <TextSpan>[
                        //                           TextSpan(
                        //                               text: '9090909090',
                        //                               style: batchtext1(
                        //                                   AppColors
                        //                                       .PrimaryBlackColor)),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 5.h,
                        //                     ),
                        //                     RichText(
                        //                       overflow: TextOverflow.clip,
                        //                       textAlign: TextAlign.end,
                        //                       textDirection:
                        //                           TextDirection.rtl,
                        //                       softWrap: true,
                        //                       maxLines: 1,
                        //                       textScaleFactor: 1,
                        //                       text: TextSpan(
                        //                         text: 'Intake :- ',
                        //                         style: batchtext2(AppColors
                        //                             .PrimaryBlackColor),
                        //                         children: <TextSpan>[
                        //                           TextSpan(
                        //                               text: '2024',
                        //                               style: batchtext1(
                        //                                   AppColors
                        //                                       .PrimaryBlackColor)),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 5.h,
                        //                     ),
                        //                     RichText(
                        //                       overflow: TextOverflow.clip,
                        //                       textAlign: TextAlign.end,
                        //                       textDirection:
                        //                           TextDirection.rtl,
                        //                       softWrap: true,
                        //                       maxLines: 1,
                        //                       textScaleFactor: 1,
                        //                       text: TextSpan(
                        //                         text:
                        //                             'Country to Preference :- ',
                        //                         style: batchtext2(AppColors
                        //                             .PrimaryBlackColor),
                        //                         children: <TextSpan>[
                        //                           TextSpan(
                        //                               text: 'Uk',
                        //                               style: batchtext1(
                        //                                   AppColors
                        //                                       .PrimaryBlackColor)),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 20.h,
                        //                     ),
                        //                     Center(
                        //                       child: SizedBox(
                        //                         height: 30.h,
                        //                         width: 100.w,
                        //                         child: ButtonPrimary2(
                        //                             title: "Go to Fair",
                        //                             onPressed: () {}),
                        //                       ),
                        //                     )
                        //                   ],
                        //                 ),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     }),
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
