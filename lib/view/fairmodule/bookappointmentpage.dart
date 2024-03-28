import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/model/getpendintAppointment.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/gofairbloc.dart';
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
  String? studentid;
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

        Navigator.pushNamed(context, RoutesName.bookappointment);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(milliseconds: 1000),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
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

  callAppointmentpending() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");
    Map<String, dynamic> data = {
      "f_student_id": studentid.toString(),
      "f_appointment_status": "NotUpdated"
    };
    goFairBloc.callAppointmentPendingDetails(data);
  }

  getgofairdrop() async {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");

    Map<String, String> data = {
      "flag": actiondrop!.name.toString(),
      "userid": "",
      "branchid": "",
      "f_Student_id": studentid.toString(),
    };

    goFairBloc.callgofairdrop(data);
  }

  bookappointmentdata() async {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");
    Map<String, String> data = {
      "f_Student_id": studentid.toString(),
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
                    Form(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Action Type ',
                                      style: FieldTextStyle(
                                        AppColors.PrimaryBlackColor,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: ' * ',
                                            style: FieldTextStyle(Colors.red)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.r, right: 10.r),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
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
                                        style: batchtext2(AppColors.hintcolor),
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
                                      dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color:
                                                  AppColors.PrimaryWhiteColor,
                                              border: Border.all()),
                                          maxHeight: 300.h,
                                          elevation: 10),
                                      menuItemStyleData: MenuItemStyleData(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40.h,
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (isOpen) {}
                                      },
                                      iconStyleData: IconStyleData(
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                        iconSize: 30.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'University Visit ',
                                      style: FieldTextStyle(
                                        AppColors.PrimaryBlackColor,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: '*',
                                            style: FieldTextStyle(Colors.red)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.r, right: 10.r),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
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
                                        style: batchtext2(AppColors.hintcolor),
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
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 55.h,
                                        padding: EdgeInsets.all(10.r),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color:
                                                  AppColors.PrimaryWhiteColor,
                                              border: Border.all()),
                                          maxHeight: 300.h,
                                          elevation: 10),
                                      menuItemStyleData: MenuItemStyleData(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40.h,
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (isOpen) {}
                                      },
                                      iconStyleData: IconStyleData(
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                        iconSize: 30.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Appointment Date ',
                                      style: FieldTextStyle(
                                        AppColors.PrimaryBlackColor,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: '*',
                                            style: FieldTextStyle(Colors.red)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.r, right: 10.r),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
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
                                        style: batchtext2(AppColors.hintcolor),
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
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 55.h,
                                        padding: EdgeInsets.all(10.r),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color:
                                                  AppColors.PrimaryWhiteColor,
                                              border: Border.all()),
                                          maxHeight: 300.h,
                                          elevation: 10),
                                      menuItemStyleData: MenuItemStyleData(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40.h,
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (isOpen) {}
                                      },
                                      iconStyleData: IconStyleData(
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                        iconSize: 30.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Appointment Time ',
                                      style: FieldTextStyle(
                                        AppColors.PrimaryBlackColor,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: '*',
                                            style: FieldTextStyle(Colors.red)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 10)
                                          .r,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
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
                                        style: batchtext2(AppColors.hintcolor),
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
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 55.h,
                                        padding: EdgeInsets.all(10.r),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color:
                                                  AppColors.PrimaryWhiteColor,
                                              border: Border.all()),
                                          maxHeight: 300.h,
                                          elevation: 10),
                                      menuItemStyleData: MenuItemStyleData(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40.h,
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (isOpen) {}
                                      },
                                      iconStyleData: IconStyleData(
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
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
                                            "Please select All Fields",
                                            style: batchtext2(
                                                AppColors.PrimaryWhiteColor),
                                          ),
                                        ));
                                      }
                                    },
                                    title: "Book Now ",
                                  ),
                                )),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ]),
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
