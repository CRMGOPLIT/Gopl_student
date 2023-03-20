import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/EventDetailsModel.dart';
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
  late DashBoardBloc dashBoardBloc;
  List<EvenetDetailsModel> data = [];
  List EventData = [];

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getEventsDetails();
    _gethomeData();
    // TODO: implement initState
    super.initState();
  }

  getEventsDetails() async {
    await dashBoardBloc.getEventDetailsStream.listen((event) {
      if (event != null) {
        // debugger();
        // print(event);
        EventData = event;

        for (int i = 0; i < EventData.length; i++) {
          EvenetDetailsModel evenetDetailsModel =
              EvenetDetailsModel.fromJson(event[i]);
          data.add(evenetDetailsModel);
        }

        setState(() {
          loanding = false;
          //print(location);
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callGetEventDetailsApi();
  }

  TabController? _tabController;

  dynamic listImagesnotFound = [
    "assets/images/evh.png",
    "assets/images/net.png",
    "assets/images/evh.png",
    "assets/images/evh.png",
    "assets/images/evh.png",
  ];
  Random? rnd;

  Widget buildImage(BuildContext context) {
    int min = 0;
    int max = listImagesnotFound.length - 1;
    rnd = new Random();
    int r = min + rnd!.nextInt(max - min);
    String image_name = listImagesnotFound[r].toString();
    return Image.asset(image_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h), // here the desired height
        child: AppBarCustom(
          title: "Event Details",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.bottomnav);
          },
        ),
      ),
      body: loanding == true
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.PrimaryMainColor,
            ))
          : DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      // padding: EdgeInsets.all(10),
                      height: 40,
                      decoration: BoxDecoration(

                          //color: AppColors.PrimaryWhiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: TabBar(
                        //isScrollable: true,
                        // labelColor:
                        //    AppColors.PrimaryWhiteColor, //<-- selected text color
                        // unselectedLabelColor: AppColors.PrimaryWhiteColor,

                        labelColor: AppColors.PrimaryWhiteColor,
                        // indicatorColor: AppColors.PrimaryMainColor,
                        unselectedLabelColor: AppColors.PrimaryMainColor,
                        //indicatorWeight: 2.h,

                        padding: EdgeInsets.only(left: 10.r, right: 10.r),

                        //indicatorSize: TabBarIndicatorSize.label,

                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.PrimaryMainColor,
                          // border: Border.all(color: AppColors.PrimaryMainColor)
                        ),
                        tabs: const [
                          Tab(
                            child: Text(
                              "Upcoming Events",
                              // style: Text2Regular(AppColors.PrimaryWhiteColor),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "University Visit",
                              //  style: Text2Regular(AppColors.PrimaryMainColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Container(
                              // height: 350.h,
                              // width: 390.w,
                              decoration: BoxDecoration(
                                  color: AppColors.PrimaryWhiteColor,
                                  borderRadius: BorderRadius.circular(10.r),
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
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
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
                                                      BorderRadius.circular(
                                                          5.r),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          listImagesnotFound[
                                                                  index]
                                                              .toString()))),
                                            ),
                                            Positioned(
                                              left: 175.h,
                                              top: 5.h,
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  maxHeight: double.infinity,
                                                ),
                                                width: 120.w,
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .PrimaryWhiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.r),
                                                  child: Text(
                                                    data[index]
                                                        .branch
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: FieldTextStyle(
                                                        AppColors
                                                            .PrimaryMainColor),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.only(left: 10.r),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     mainAxisAlignment: MainAxisAlignment.start,
                                        //     children: [
                                        //       RichText(
                                        //         text: TextSpan(
                                        //           text: 'Date :- ',
                                        //           style: batchtext1(
                                        //               AppColors.PrimaryBlackColor),
                                        //           children: [
                                        //             TextSpan(
                                        //               text: '29/01/2023',
                                        //               style: batchtext2(
                                        //                   AppColors.PrimaryBlackColor),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //       SizedBox(
                                        //         height: 10.h,
                                        //       ),
                                        //       RichText(
                                        //         text: TextSpan(
                                        //           text: 'Time :- ',
                                        //           style: batchtext1(
                                        //               AppColors.PrimaryBlackColor),
                                        //           children: [
                                        //             TextSpan(
                                        //               text: '11:00 AM To 5:00 PM',
                                        //               style: batchtext2(
                                        //                   AppColors.PrimaryBlackColor),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //       SizedBox(
                                        //         height: 10.h,
                                        //       ),
                                        //       SizedBox(
                                        //         width: 200.w,
                                        //         child: RichText(
                                        //           // overflow: TextOverflow.ellipsis,
                                        //           text: TextSpan(
                                        //             text: 'Venue :- ',
                                        //             style: batchtext1(
                                        //                 AppColors.PrimaryBlackColor),
                                        //             children: [
                                        //               TextSpan(
                                        //                 text:
                                        //                     'Courtyard by Marriott Mumbai',
                                        //                 style: batchtext2(AppColors
                                        //                     .PrimaryBlackColor),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       SizedBox(
                                        //         height: 10.h,
                                        //       ),
                                        //       RichText(
                                        //         // overflow: TextOverflow.ellipsis,
                                        //         text: TextSpan(
                                        //           text: 'Phone :- ',
                                        //           style: batchtext1(
                                        //               AppColors.PrimaryBlackColor),
                                        //           children: [
                                        //             TextSpan(
                                        //               text: '9090909090',
                                        //               style: batchtext2(
                                        //                   AppColors.PrimaryBlackColor),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
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
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 320.w,
                                          child: RichText(
                                            // overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              text: 'Date :- ',
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor),
                                              children: [
                                                TextSpan(
                                                  text: data[index]
                                                      .date
                                                      .toString(),
                                                  style: batchtext2(AppColors
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
                                              Icons.watch_later_outlined,
                                              size: 20.sp,
                                            ),
                                            SizedBox(
                                              width: 10.h,
                                            ),
                                            Text(
                                              data[index].time.toString(),
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            const url =
                                                'https://www.google.com/maps/d/viewer?mid=1T1ZLcwz23FD9CGb7GnBTTtiXfxw&hl=en_US&ll=28.684263000000033%2C77.18702299999997&z=17';
                                            if (await canLaunch(data[index]
                                                .venueLocation
                                                .toString())) {
                                              await launch(data[index]
                                                  .venueLocation
                                                  .toString());
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 20.sp,
                                                color:
                                                    AppColors.PrimaryMainColor,
                                              ),
                                              SizedBox(
                                                width: 10.h,
                                              ),
                                              SizedBox(
                                                width: 290,
                                                child: Text(
                                                  data[index].venue.toString(),
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
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
