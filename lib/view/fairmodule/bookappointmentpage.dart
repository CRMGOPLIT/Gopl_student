import 'dart:developer';
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/model/getpendintAppointment.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/loader.dart';
import '../../bloc/gofairbloc.dart';
import '../../model/getfairdocumentmodel.dart';
import '../../model/getfairdropmodel.dart';
import '../../model/monthModel.dart';
import '../../utils/color.dart';
import '../../utils/routes/routes_name.dart';
import '../widget/app_bar.dart';
import '../widget/button.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  List<String> selecteduniversity = [];

  Timeappointment? timedrop;
  GofairdropModel? datedrop;
  GofairdropModel? universitydrop;
  Actiontype? actiondrop;
  List<GetPendingAppointment> getAppointmentpending = [];

  List appointmentdatapending = [];
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  late GoFairBloc goFairBloc;

  List<GofairdropModel> gofairdropmodel = [];

  List gofairdroplist = [];

  List gofairlistdata = [];
  bool loanding = true;
  final _appointmentfrop = GlobalKey<FormState>();

  final appointmentkey = GlobalKey<FormState>();

  DateTime? date;
  int i = 0;

  int check = 0;

  List<Color> colors = [];
  List yearList = [
    "9 To 10",
    "10 To 11",
    "11 To 12",
    "12 To 1",
    "1 To 2",
    "2 To 3",
    "3 To 4",
    "4 To 5",
    "5 To 6",
  ];
  // TimeOfDay? selectedTime;
  // Future<void> _selectTime(BuildContext context) async {
  //   selectedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );

  //   setState(() {});
  // }

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
    gofairdropitem();
    postappointment();
    callAppointmentpending();
    getAppointmentPendingData();

    super.initState();
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
          loanding = false;
        });
      }
    });
  }

  postappointment() async {
    goFairBloc.bookappointmentdataStream.listen((event) {
      Navigator.pop(context);

      if (event.data == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
          content: Text(
            "Appointment Book Successfully",
            style: batchtext1(AppColors.PrimaryWhiteColor),
          ),
        ));
        // setState(() {
        //   check = 1;

        //   getAppointmentPendingData();
        // });
        Navigator.pushNamed(context, RoutesName.bookappointment);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(milliseconds: 1000),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oops Error!',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      event.data == false
                          ? Text("Appointment Already Book",
                              style: batchtext1(
                                AppColors.PrimaryWhiteColor,
                              ))
                          : Text("Appointment Already Book",
                              style: batchtext1(
                                AppColors.PrimaryWhiteColor,
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    });
  }

  callAppointmentpending() {
    Map<String, dynamic> data = {
      "f_student_id": "2002751",
      "f_appointment_status": "NotUpdated"
    };
    goFairBloc.callAppointmentPendingDetails(data);
  }

  getgofairdrop() {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Map<String, String> data = {
      "flag": actiondrop!.name.toString(),
      "userid": "",
      "branchid": "",
      "f_Student_id": "2002751"
    };

    goFairBloc.callgofairdrop(data);
  }

  bookappointmentdata() {
    NetworkDialog.showLoadingDialog(context, _keyLoader);

    Map<String, String> data = {
      "f_Student_id": 2002751.toString(),
      "AppointmentType": actiondrop!.id.toString(),
      "f_university_visit": universitydrop!.id.toString(),
      "f_applointment_time": timedrop!.id.toString()
    };

    goFairBloc.callbookappointmentdata(data);
  }

  gofairdropitem() async {
    goFairBloc.gofairdropStream.listen((event) {
      Navigator.pop(context);

      gofairdroplist = event.data;
      if (gofairdroplist.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
          content: Text(
            "No University Visit Found",
            style: batchtext1(AppColors.PrimaryWhiteColor),
          ),
        ));
      } else {
        for (int i = 0; i < gofairdroplist.length; i++) {
          GofairdropModel filterSeach = GofairdropModel.fromJson(event.data[i]);

          gofairdropmodel.add(filterSeach);
        }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Book Your Appointment",
          onpress: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.gofair,
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
              padding: const EdgeInsets.all(10.0).r,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getAppointmentpending.isEmpty
                        ? Form(
                            key: _appointmentfrop,
                            child: Container(
                              width: 400.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: AppColors.PrimaryMainColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0).r,
                                ),
                                elevation: 5,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Center(
                                        child: Image.asset(
                                          "assets/images/bannerlogo.png",
                                          height: 40.h,
                                          width: 300.w,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text("Action Type",
                                            style: FieldTextStyle(
                                              AppColors.PrimaryBlackColor,
                                            )),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10.r, right: 10.r),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField2(
                                            isDense: false,
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: AppColors.hintcolor,
                                                    width: 1.0),
                                              ),
                                              isCollapsed: true,
                                              border: InputBorder.none,
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please Select Action Type';
                                              }
                                              return null;
                                            },
                                            hint: Text(
                                              'Please Select Action Type',
                                              style: batchtext2(
                                                  AppColors.hintcolor),
                                            ),
                                            items: actiontype
                                                .map((item) => DropdownMenuItem(
                                                      value: item,
                                                      child: Text(
                                                        item.name.toString(),
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                      ),
                                                    ))
                                                .toList(growable: false),
                                            value: actiondrop,
                                            onChanged: (value) {
                                              setState(() {
                                                actiondrop = value;
                                                universitydrop = null;
                                                gofairdropmodel.clear();

                                                getgofairdrop();
                                              });
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: 55.h,
                                              padding: EdgeInsets.all(10.r),
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.sp),
                                                        color: AppColors
                                                            .PrimaryWhiteColor,
                                                        border: Border.all()),
                                                    maxHeight: 300.h,
                                                    elevation: 10),
                                            menuItemStyleData:
                                                MenuItemStyleData(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 40.h,
                                            ),
                                            onMenuStateChange: (isOpen) {
                                              if (isOpen) {
                                                // textEditingController.clear();
                                              }
                                            },
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color:
                                                    AppColors.PrimaryMainColor,
                                              ),
                                              iconSize: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text("University Visit",
                                            style: FieldTextStyle(
                                              AppColors.PrimaryBlackColor,
                                            )),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10.r, right: 10.r),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField2(
                                            isDense: false,
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: AppColors.hintcolor,
                                                    width: 1.0),
                                              ),
                                              isCollapsed: true,
                                              border: InputBorder.none,
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please Select University Visit';
                                              }
                                              return null;
                                            },
                                            hint: Text(
                                              'Please Select University Visit',
                                              style: batchtext2(
                                                  AppColors.hintcolor),
                                            ),
                                            items: gofairdropmodel
                                                .map((item) => DropdownMenuItem(
                                                      value: item,
                                                      child: Text(
                                                        item.name.toString(),
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                      ),
                                                    ))
                                                .toList(growable: false),
                                            value: universitydrop,
                                            onChanged: (value) {
                                              setState(() {
                                                universitydrop = value;

                                                // print(
                                                //     universitydrop?.name.toString());
                                                // print(gofairlistdata.length);

                                                // isSelected = true;
                                              });
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: 55.h,
                                              padding: EdgeInsets.all(10.r),
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.sp),
                                                        color: AppColors
                                                            .PrimaryWhiteColor,
                                                        border: Border.all()),
                                                    maxHeight: 300.h,
                                                    elevation: 10),
                                            menuItemStyleData:
                                                MenuItemStyleData(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 40.h,
                                            ),
                                            onMenuStateChange: (isOpen) {
                                              if (isOpen) {
                                                // textEditingController.clear();
                                              }
                                            },
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color:
                                                    AppColors.PrimaryMainColor,
                                              ),
                                              iconSize: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text("Appointment Date",
                                            style: FieldTextStyle(
                                              AppColors.PrimaryBlackColor,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10.r, right: 10.r),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField2(
                                            isDense: false,
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: AppColors.hintcolor,
                                                    width: 1.0),
                                              ),
                                              isCollapsed: true,
                                              border: InputBorder.none,
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please Select year';
                                              }
                                              return null;
                                            },
                                            hint: Text(
                                              'Please Select Appointment Date',
                                              style: batchtext2(
                                                  AppColors.hintcolor),
                                            ),
                                            items: gofairdropmodel
                                                .map((item) => DropdownMenuItem(
                                                      value: item,
                                                      child: Text(
                                                        item.dateOfVisit
                                                            .toString()
                                                            .split(" ")[0]
                                                            .toString(),
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                      ),
                                                    ))
                                                .toList(growable: false),
                                            value: datedrop,
                                            onChanged: (value) {
                                              setState(() {
                                                datedrop = value;
                                                // isSelected = true;
                                              });
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: 55.h,
                                              padding: EdgeInsets.all(10.r),
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.sp),
                                                        color: AppColors
                                                            .PrimaryWhiteColor,
                                                        border: Border.all()),
                                                    maxHeight: 300.h,
                                                    elevation: 10),
                                            menuItemStyleData:
                                                MenuItemStyleData(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 40.h,
                                            ),
                                            onMenuStateChange: (isOpen) {
                                              if (isOpen) {
                                                // textEditingController.clear();
                                              }
                                            },
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color:
                                                    AppColors.PrimaryMainColor,
                                              ),
                                              iconSize: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text("Appointment Time",
                                            style: FieldTextStyle(
                                              AppColors.PrimaryBlackColor,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                                left: 10, right: 10)
                                            .r,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField2(
                                            isDense: false,
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: AppColors.hintcolor,
                                                    width: 1.0),
                                              ),
                                              isCollapsed: true,
                                              border: InputBorder.none,
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please Select Appointment Time';
                                              }
                                              return null;
                                            },
                                            hint: Text(
                                              'Please Select Appointment Time',
                                              style: batchtext2(
                                                  AppColors.hintcolor),
                                            ),
                                            items: timeappointment
                                                .map((item) => DropdownMenuItem(
                                                      value: item,
                                                      child: Text(
                                                        "${item.name}  ⏰",
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                      ),
                                                    ))
                                                .toList(growable: false),
                                            value: timedrop,
                                            onChanged: (value) {
                                              setState(() {
                                                timedrop = value;
                                                // isSelected = true;
                                              });
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: 55.h,
                                              padding: EdgeInsets.all(10.r),
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.sp),
                                                        color: AppColors
                                                            .PrimaryWhiteColor,
                                                        border: Border.all()),
                                                    maxHeight: 150.h,
                                                    elevation: 10),
                                            menuItemStyleData:
                                                MenuItemStyleData(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 40.h,
                                            ),
                                            onMenuStateChange: (isOpen) {
                                              if (isOpen) {
                                                // textEditingController.clear();
                                              }
                                            },
                                            iconStyleData: IconStyleData(
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color:
                                                    AppColors.PrimaryMainColor,
                                              ),
                                              iconSize: 30.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Center(
                                          child: SizedBox(
                                        height: 40.h,
                                        width: 150.w,
                                        child: ButtonPrimary(
                                          onPressed: () {
                                            if (_appointmentfrop.currentState!
                                                .validate()) {
                                              bookappointmentdata();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                  "Please select year and Country",
                                                  style: batchtext2(AppColors
                                                      .PrimaryWhiteColor),
                                                ),
                                              ));
                                            }
                                          },
                                          title: "Book Now",
                                        ),
                                      )),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ]),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Card(
                              elevation: 10,
                              color: getRandomColor(),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i < getAppointmentpending.length;
                                      i++)
                                    Container(
                                      width: double.infinity,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          //color: AppColors.PrimaryMainColor,
                                          borderRadius: BorderRadius.only(
                                        topRight: const Radius.circular(10).r,
                                        topLeft: const Radius.circular(10).r,
                                      )),
                                      child: Center(
                                        child: Text(
                                          "Appointment Details",
                                          style: batchtext2(
                                              AppColors.PrimaryBlackColor),
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    height: 0.5.h,
                                    color: AppColors.PrimaryBlackColor,
                                  ),
                                  ListTile(
                                    dense: true,
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    leading: const Icon(
                                      Icons.school,
                                      color: AppColors.PrimaryMainColor,
                                    ),
                                    title: Text(
                                      getAppointmentpending[i].universityVisit,
                                      style: batchtext2(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                  ),
                                  ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      leading: const Icon(
                                        Icons.person_2_outlined,
                                        color: AppColors.PrimaryMainColor,
                                      ),
                                      title: Text(
                                        getAppointmentpending[i].studentName,
                                        style: batchtext2(
                                            AppColors.PrimaryBlackColor),
                                      )),
                                  ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      leading: const Icon(
                                        Icons.date_range,
                                        color: AppColors.PrimaryMainColor,
                                      ),
                                      title: Text(
                                        getAppointmentpending[i]
                                            .appointmentDate,
                                        style: batchtext2(
                                            AppColors.PrimaryBlackColor),
                                      )),
                                  ListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    dense: true,
                                    leading: const Icon(
                                      Icons.watch_later_rounded,
                                      color: AppColors.PrimaryMainColor,
                                    ),
                                    title: Text(
                                      getAppointmentpending[i].appointmentTime,
                                      style: batchtext2(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.directions_walk_rounded,
                                          color: AppColors.PrimaryBlackColor),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Active",
                                          style: batchtext2(Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
