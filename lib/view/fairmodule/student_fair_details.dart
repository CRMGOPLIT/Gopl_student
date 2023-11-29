import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/button.dart';
import 'package:global_student/view/widget/loader.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/gofairbloc.dart';
import '../../model/getfairdocumentmodel.dart';
import '../../model/gofairdetails.dart';
import '../../model/monthModel.dart';
import '../../utils/color.dart';
import '../../utils/routes/routes_name.dart';
import '../widget/app_bar.dart';

class StudentFairDetails extends StatefulWidget {
  const StudentFairDetails({super.key});

  @override
  State<StudentFairDetails> createState() => _StudentFairDetailsState();
}

class _StudentFairDetailsState extends State<StudentFairDetails> {
  late GoFairBloc goFairBloc;

  var studentid = Get.arguments;

  Gofairdetails? getfairModel;
  List<Getfairdocumentlist> getfairdocumentlist = [];

  List getfairdocument = [];

  String? token = "";

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  // File? file;

  List applicationdata = [];

  bool loading1 = true;

  List<File> selectedFile = [];
  List<TextEditingController> selectedfiledata = [];
  bool isFileSelected = false;

  bool loading = true;
  int check = 0;
  Timeappointment? timedrop;
  List<String> selectedItems = [];

  String? studentiddata;

  setdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    studentiddata = prefs.getString("studentId");
  }

  List<Timeappointment> timeappointment = [
    Timeappointment(
      id: '9-10',
      name: '10th Markssheet',
    ),
    Timeappointment(
      id: '10-11',
      name: '12th Markssheet',
    ),
    Timeappointment(
      id: '11-12',
      name: 'other',
    ),
  ];

  @override
  void initState() {
    goFairBloc = GoFairBloc();
    setdata();
    getgofairDetails();
    _getgofairData();
    getfairdocumentdata();
    searchFilter();
    updateFairAppointmentdata();
    uploadloadfairdocument();
    super.initState();
  }

  getgofairDetails() {
    goFairBloc.gofairdetailsStream.listen((event) {
      if (event != null) {
        setState(() {
          getfairModel = Gofairdetails.fromJson(event);
          loading1 = false;
        });
      }
    });
  }

  updateFairAppointmentdata() async {
    goFairBloc.updatefairappointmentStream.listen((event) {
      Navigator.pop(context);
      if (event.data == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
          content: Text(
            "Welcome to Global Opportunities Fair",
            style: batchtext2(AppColors.PrimaryWhiteColor),
          ),
        ));
        setState(() {
          check = 1;
        });

        Navigator.pushNamed(context, RoutesName.studentfairdetails);
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
                      event.data == "Failed"
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

  getfairdocumentdata() async {
    goFairBloc.getfairdocumetlistStream.listen((event) {
      if (event != null) {
        getfairdocument = event;
        for (int i = 0; i < getfairdocument.length; i++) {
          Getfairdocumentlist getfairdocumentalldata =
              Getfairdocumentlist.fromJson(event[i]);
          getfairdocumentlist.add(getfairdocumentalldata);
        }
      }

      setState(() {});
    });
  }

  _getgofairData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentiddata = prefs.getString("studentId");
    Map<String, dynamic> data = {
      "f_student_id": studentiddata.toString(),
    };
    goFairBloc.callGofairdetailsDetails(data);
  }

  updateFairAppointment() async {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentiddata = prefs.getString("studentId");
    Map<String, String> data = {
      "f_Student_id": studentiddata.toString(),
      "university_Id": getfairModel!.fUniversityId.toString()
    };

    goFairBloc.callupdatefairappointment(data);
  }

  uploadloadfairdocument() async {
    goFairBloc.uploadfairdocumentcontrollerStream.listen((event) {
      Navigator.pop(context);
      if (event.data["Status"] == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
          content: Text(
            "Document Uploaded Successfully",
            style: batchtext1(AppColors.PrimaryWhiteColor),
          ),
        ));
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.studentfairdetails,
          (routes) => false,
        );
        setState(() {});
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
                      Text("Uploded document Failed",
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

  callUploadDocumentApi() async {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    String spselcected = selectedItems.join(",");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentiddata = prefs.getString("studentId");
    Map<String, dynamic> data = {
      "studentid": studentiddata.toString(),
      "DocumentName": spselcected,
      "DocumentType": selectedItems.length > 1 ? "Combine" : "Individual"
    };
    goFairBloc.callUploadfairdocumentApi(
      data,
      selectedFile,
    );
  }

  searchFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentiddata = prefs.getString("studentId");
    Map<String, String> data = {
      "Studentid": studentiddata.toString(),
    };
    goFairBloc.callfairdocumentlist(data);
  }

  String tok = "1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Your Details",
          onpress: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.gofair,
              (routes) => false,
            );
          },
        ),
      ),
      body: loading1 == true
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 2.w,
              color: AppColors.PrimaryMainColor,
            ))
          : getfairModel?.isTodayFair != "Yes"
              ? Padding(
                  padding: const EdgeInsets.all(10.0).r,
                  child: Column(
                      //  crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/comefair.png"),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Please Come On Fair Date ",
                          style: batchtext2(AppColors.PrimaryBlackColor),
                        )
                      ]),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0).r,
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
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
                                    "Details",
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Upload Documents",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            loading1
                                ? Center(
                                    child: CircularProgressIndicator(
                                    strokeWidth: 2.w,
                                    color: AppColors.PrimaryMainColor,
                                  ))
                                : ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return getfairModel!.token.isEmpty &&
                                              check == 0
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  //  color: Color(0xffF0CED2),
                                                  border: Border.all(
                                                      color: AppColors
                                                          .PrimaryMainColor),
                                                  borderRadius:
                                                      BorderRadius.circular(10)
                                                  // borderRadius: BorderRadius.only(
                                                  //   bottomLeft: Radius.circular(20),
                                                  //   bottomRight: Radius.circular(20),
                                                  // )
                                                  ),
                                              child: Card(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 90.h,
                                                      width: 400.w,
                                                      decoration: BoxDecoration(
                                                          //color: AppColors.PrimaryGreyColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                      .circular(
                                                                          10)
                                                                  .r
                                                          // borderRadius: BorderRadius.only(
                                                          //   bottomLeft: Radius.circular(20),
                                                          //   bottomRight: Radius.circular(20),
                                                          // )
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(8.0)
                                                                .r,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // SizedBox(
                                                                  //   height: 5.h,
                                                                  // ),

                                                                  // AnimatedTextKit(
                                                                  //   isRepeatingAnimation: true,
                                                                  //   repeatForever: true,
                                                                  //   animatedTexts: [
                                                                  //     TyperAnimatedText(
                                                                  //         'Current Priority Pass :-  G O L D',
                                                                  //         textStyle: batchtext2(
                                                                  //             AppColors.PrimaryWhiteColor)),
                                                                  //   ],
                                                                  //   pause: const Duration(milliseconds: 2000),
                                                                  //   displayFullTextOnTap: true,
                                                                  //   stopPauseOnTap: true,
                                                                  // ),
                                                                  // Text(
                                                                  //   "Current Priority Pass :- Gold",
                                                                  //   style:
                                                                  //       batchtext2(AppColors.PrimaryWhiteColor),
                                                                  // ),
                                                                  SizedBox(
                                                                    height: 5.h,
                                                                  ),
                                                                  Text(
                                                                    "Student :- ${getfairModel?.firstName.toString()}",
                                                                    style: batchtext2(
                                                                        AppColors
                                                                            .PrimaryBlackColor),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5.h,
                                                                  ),
                                                                  Text(
                                                                    "Branch :- ${getfairModel?.fBranchName.toString()}",
                                                                    style: batchtext2(
                                                                        AppColors
                                                                            .PrimaryBlackColor),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5.h,
                                                                  ),
                                                                  Text(
                                                                    "Counselor :-  ${getfairModel?.counselorname.toString()}",
                                                                    style: batchtext2(
                                                                        AppColors
                                                                            .PrimaryBlackColor),
                                                                  ),
                                                                ]),
                                                            const Spacer(),
                                                            Column(
                                                              children: [
                                                                getfairModel?.stuCat ==
                                                                        "PLATINUM"
                                                                    ? Image
                                                                        .asset(
                                                                        "assets/images/platinum.png",
                                                                        height:
                                                                            60.h,
                                                                        width:
                                                                            100.w,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      )
                                                                    : getfairModel?.stuCat ==
                                                                            "GOLD"
                                                                        ? Image
                                                                            .asset(
                                                                            "assets/images/gold.png",
                                                                            height:
                                                                                60.h,
                                                                            width:
                                                                                100.w,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          )
                                                                        : getfairModel?.stuCat ==
                                                                                "SILVER"
                                                                            ? Image.asset(
                                                                                "assets/images/silver.png",
                                                                                height: 60.h,
                                                                                width: 100.w,
                                                                                fit: BoxFit.contain,
                                                                              )
                                                                            : Image.asset(
                                                                                "assets/images/bronze.png",
                                                                                height: 60.h,
                                                                                width: 100.w,
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                // getfairModel?.stuCat ==
                                                                //         "BRONZE"
                                                                //     ? Image.asset(
                                                                //         "assets/images/bronze.png",
                                                                //         height: 60.h,
                                                                //         width: 100.w,
                                                                //         fit: BoxFit
                                                                //             .contain,
                                                                //       )
                                                                //     : Container(),
                                                                Text(
                                                                  "342345",
                                                                  style: batchtext2(
                                                                      AppColors
                                                                          .PrimaryMainColor),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 1.h,
                                                      color: AppColors
                                                          .PrimaryBlackColor,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                                  8.0)
                                                              .r,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          RichText(
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            textAlign:
                                                                TextAlign.end,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            softWrap: true,
                                                            maxLines: 1,
                                                            textScaleFactor: 1,
                                                            text: TextSpan(
                                                              text: 'Email :- ',
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryBlackColor),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text: getfairModel
                                                                        ?.email
                                                                        .toString(),
                                                                    style: batchtext1(
                                                                        AppColors
                                                                            .PrimaryBlackColor)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          RichText(
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            textAlign:
                                                                TextAlign.end,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            softWrap: true,
                                                            maxLines: 1,
                                                            textScaleFactor: 1,
                                                            text: TextSpan(
                                                              text:
                                                                  'Mobile :- ',
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryBlackColor),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text: getfairModel
                                                                        ?.mobile
                                                                        .toString(),
                                                                    style: batchtext1(
                                                                        AppColors
                                                                            .PrimaryBlackColor)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          RichText(
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            textAlign:
                                                                TextAlign.end,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            softWrap: true,
                                                            maxLines: 1,
                                                            textScaleFactor: 1,
                                                            text: TextSpan(
                                                              text:
                                                                  'Intake :- ',
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryBlackColor),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text: getfairModel
                                                                        ?.intake
                                                                        .toString(),
                                                                    style: batchtext1(
                                                                        AppColors
                                                                            .PrimaryBlackColor)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          RichText(
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            textAlign:
                                                                TextAlign.end,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            softWrap: true,
                                                            maxLines: 1,
                                                            textScaleFactor: 1,
                                                            text: TextSpan(
                                                              text:
                                                                  'Country to Preference :- ',
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryBlackColor),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text: getfairModel
                                                                        ?.countryName
                                                                        .toString(),
                                                                    style: batchtext1(
                                                                        AppColors
                                                                            .PrimaryBlackColor)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20.h,
                                                          ),
                                                          Center(
                                                            child: SizedBox(
                                                              height: 30.h,
                                                              width: 100.w,
                                                              child:
                                                                  ButtonPrimary2(
                                                                      title:
                                                                          "Go to Fair",
                                                                      onPressed:
                                                                          () async {
                                                                        if (getfairModel!.isTodayFair ==
                                                                                "Yes" &&
                                                                            getfairModel!.fAppointmentStatus ==
                                                                                "") {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(SnackBar(
                                                                            backgroundColor:
                                                                                Colors.red,
                                                                            content:
                                                                                Text(
                                                                              "Please Book Your Appointment First..?",
                                                                              style: batchtext2(AppColors.PrimaryWhiteColor),
                                                                            ),
                                                                          ));
                                                                        } else {
                                                                          updateFairAppointment();
                                                                        }
                                                                      }),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .PrimaryWhiteColor,
                                                  //Color.fromARGB(255, 2, 75, 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                      color: AppColors
                                                          .PrimaryMainColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                10)
                                                            .r),
                                                elevation: 5,
                                                child: ListTile(
                                                  title: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.circle_rounded,
                                                        color: Colors.green,
                                                      )
                                                    ],
                                                  ),
                                                  subtitle: Column(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/tokencoin.png",
                                                        height: 100.h,
                                                        width: 400.w,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              'Token Number :- ',
                                                          style: H2TextStyle(
                                                              AppColors
                                                                  .PrimaryBlackColor),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: getfairModel!
                                                                    .token
                                                                    .toString(),
                                                                style: TextRegular(
                                                                    Colors
                                                                        .green)),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                    }),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 400.w,

                                  // decoration: BoxDecoration(
                                  //     border:
                                  //         Border.all(color: AppColors.PrimaryMainColor)),
                                  padding: const EdgeInsets.all(8.0).r,
                                  child: Text(
                                    "Upload Your Document ",
                                    textAlign: TextAlign.center,
                                    style: FieldTextStyle(
                                        AppColors.PrimaryBlackColor),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 5.r,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColors.PrimaryMainColor),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    // padding: const EdgeInsets.all(8.0),
                                    padding: const EdgeInsets.all(8).r,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors
                                                        .PrimaryMainColor),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                isExpanded: true,
                                                hint: Text(
                                                  'Please Select File Name',
                                                  style: batchtext2(
                                                      AppColors.hintcolor),
                                                ),
                                                items:
                                                    timeappointment.map((item) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: item.name,
                                                    enabled: false,
                                                    child: StatefulBuilder(
                                                      builder: (context,
                                                          menuSetState) {
                                                        final isSelected =
                                                            selectedItems
                                                                .contains(
                                                                    item.name);
                                                        return InkWell(
                                                          onTap: () {
                                                            isSelected
                                                                ? selectedItems
                                                                    .remove(item
                                                                        .name)
                                                                : selectedItems
                                                                    .add(item
                                                                        .name
                                                                        .toString());

                                                            setState(() {});

                                                            menuSetState(() {});
                                                          },
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: Row(
                                                              children: [
                                                                isSelected
                                                                    ? const Icon(
                                                                        Icons
                                                                            .check_box_outlined,
                                                                        color: AppColors
                                                                            .PrimaryMainColor,
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .check_box_outline_blank,
                                                                        color: AppColors
                                                                            .PrimaryMainColor,
                                                                      ),
                                                                const SizedBox(
                                                                    width: 16),
                                                                // item.name != null
                                                                //     ? Flexible(
                                                                //     child: RichText(
                                                                //     text: TextSpan(
                                                                //       text: item.id,
                                                                //       style: batchtext2(
                                                                //           AppColors
                                                                //               .PrimaryMainColor),
                                                                //       children: [
                                                                //         TextSpan(
                                                                //             text:
                                                                //                 ' * ',
                                                                //             style: batchtext2(
                                                                //                 Colors.red)),
                                                                //       ],
                                                                //     ),
                                                                //   ))
                                                                // :
                                                                Flexible(
                                                                  child: Text(
                                                                    item.name
                                                                        .toString(),
                                                                    style: batchtext2(
                                                                        AppColors
                                                                            .PrimaryMainColor),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }).toList(),
                                                value: selectedItems.isEmpty
                                                    ? null
                                                    : selectedItems.last,
                                                onChanged: (value) {
                                                  selectedItems.last = value!;

                                                  setState(() {});
                                                },
                                                selectedItemBuilder: (context) {
                                                  return timeappointment.map(
                                                    (item) {
                                                      return Container(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .center,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    16.0),
                                                        child: Text(
                                                          "Selected ${selectedItems.length}",
                                                          // timedrop.name.toString(),
                                                          style: batchtext2(
                                                              AppColors
                                                                  .PrimaryMainColor),
                                                          maxLines: 1,
                                                        ),
                                                      );
                                                    },
                                                  ).toList();
                                                },
                                                buttonStyleData:
                                                    ButtonStyleData(
                                                  height: 55.h,
                                                  width: 450.w,
                                                  padding:
                                                      const EdgeInsets.all(10)
                                                          .r,
                                                ),
                                                dropdownStyleData: DropdownStyleData(
                                                    isOverButton: true,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.sp),
                                                        color: AppColors
                                                            .PrimaryWhiteColor,
                                                        border: Border.all()),
                                                    maxHeight: 180.h,
                                                    elevation: 10),
                                                menuItemStyleData:
                                                    MenuItemStyleData(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10)
                                                          .r,
                                                  height: 40.h,
                                                ),
                                                iconStyleData:
                                                    const IconStyleData(
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: AppColors
                                                        .PrimaryMainColor,
                                                  ),
                                                  iconSize: 30,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Container
                                          // (
                                          //   //width: 400.w,
                                          //   decoration: BoxDecoration(
                                          //       border: Border.all(),
                                          //       borderRadius:
                                          //           BorderRadius.circular(8.r)),
                                          //   height: 50.h,
                                          //   child: Center(
                                          //       child: Text("Choose file Name")),
                                          // ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          selectedFile.isEmpty
                                              ? InkWell(
                                                  onTap: () {
                                                    selectFile();
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/uploadimg.png",
                                                        height: 80.h,
                                                        width: 80.w,
                                                      ),
                                                      Text(
                                                        "Select File",
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        "Supported file format(s): PDF or Dox 8 MB Max",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: batchtext1(
                                                            AppColors
                                                                .hintcolor),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  width: 400.w,
                                                  height: 150.h,

                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .PrimaryMainColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                                  10)
                                                              .r),
                                                  // padding: const EdgeInsets.all(8.0),
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: SizedBox(
                                                    width: 400.w,
                                                    // height: 150.h,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          for (int i = 0;
                                                              i <
                                                                  selectedFile
                                                                      .length;
                                                              i++)
                                                            selectedFile
                                                                    .isNotEmpty
                                                                ? Container(
                                                                    margin: EdgeInsets
                                                                        .all(5),
                                                                    padding:
                                                                        const EdgeInsets.all(5)
                                                                            .r,
                                                                    height:
                                                                        50.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8).r,
                                                                            border: Border.all(
                                                                              color: AppColors.PrimaryBlackColor,
                                                                            )),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              160.w,
                                                                          child:
                                                                              Text(
                                                                            selectedFile[i].path.split("/").last.toString(),
                                                                            style:
                                                                                batchtext2(AppColors.PrimaryMainColor),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10.w,
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            selectedFile.removeAt(i);
                                                                            setState(() {});
                                                                          },
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                25.w,
                                                                            height:
                                                                                40.h,
                                                                            child:
                                                                                Container(
                                                                              alignment: Alignment.center,
                                                                              child: Icon(
                                                                                Icons.cancel_outlined,
                                                                                size: 30,
                                                                                color: Colors.red.withOpacity(0.8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    "Supported file format(s): PDF or Dox 8 MB Max",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: batchtext1(
                                                                        AppColors
                                                                            .hintcolor),
                                                                  ),
                                                          SizedBox(
                                                            height: 20.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          selectedFile.isNotEmpty
                                              ? SizedBox(
                                                  height: 40.h,
                                                  width: 150.w,
                                                  child: ButtonPrimary2(
                                                      title: " Upload ",
                                                      onPressed: () {
                                                        callUploadDocumentApi();
                                                        setState(() {});

                                                        // callUploadDocumentApi(
                                                        //     applicationid.toString(),
                                                        //     documentname.toString().trim(),
                                                        //     documentid.toString());
                                                      }))
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),

                                //selectedFile.isEmpty
                                // ? Container()
                                // : SizedBox(
                                //     height: 35.h,
                                //     width: 130.w,
                                //     child: ButtonPrimary2(
                                //         title: " Upload ",
                                //         onPressed: () {
                                //           setState(() {});

                                //           // callUploadDocumentApi(
                                //           //     applicationid.toString(),
                                //           //     documentname.toString().trim(),
                                //           //     documentid.toString());
                                //         })),

                                Text(
                                  "Your Uploaded File",
                                  style:
                                      batchtext2(AppColors.PrimaryBlackColor),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (int i = 0;
                                            i < getfairdocumentlist.length;
                                            i++)
                                          InkWell(
                                            onTap: () async {
                                              final Uri url = Uri.parse(
                                                  getfairdocumentlist[i]
                                                      .fDocument
                                                      .toString());
                                              if (!await launchUrl(url,
                                                  mode: LaunchMode
                                                      .externalApplication)) {
                                                throw Exception(
                                                    'Could not launch $url');
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 10)
                                                      .r,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .PrimaryWhiteColor,
                                                      border: Border.all(
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                                  10)
                                                              .r),
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons.file_copy,
                                                      color: AppColors
                                                          .PrimaryMainColor,
                                                      size: 25.sp,
                                                    ),
                                                    // Image.asset(
                                                    //   "assets/images/file.png",
                                                    //   height: 25.h,
                                                    // ),
                                                    title: Text(
                                                      getfairdocumentlist[i]
                                                          .fDocumentName
                                                          .toString(),
                                                      style: batchtext2(AppColors
                                                          .PrimaryBlackColor),
                                                    ),
                                                    trailing: Icon(
                                                      Icons.download,
                                                      color:
                                                          AppColors.hintcolor,
                                                      size: 30.sp,
                                                    ),
                                                    // subtitle:
                                                    //     const Text("upload file name"),
                                                  )),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ]),
                        )
                      ],
                    ),
                  )),
    );
  }

  void selectFile() async {
    if (selectedFile.length == 1) {
      SnackBar(
        content: Text("djnkj"),
      );
      print("wkjnjke");
      // ToastHelper()
      //     .showErrorToast(message: 'File Cannot Select more than 12.');
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );

      if (result != null) {
        //    List<File> files = result.paths.map((path) => File(path!)).toList();
        // PlatformFile file = result.files.single;
        // if (file.extension == 'pdf' || file.extension == 'docx') {
        //   if (file.size <= 8 * 1024 * 1024) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        // List<String> files = result.files
        //     .map((file) => file.path!)
        //     .where((path) =>
        //         path.toLowerCase().endsWith('.pdf') ||
        //         path.toLowerCase().endsWith('.docx'))
        //     .toList();

        setState(() {
          selectedFile.addAll(files);
          isFileSelected = true;
        });
        for (int i = 0; i < selectedFile.length; i++) {
          TextEditingController controller = TextEditingController();
          selectedfiledata.add(controller);
        }

        if (selectedFile.isEmpty) {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Invalid File Type',
                  style: batchtext2(AppColors.PrimaryBlackColor),
                ),
                content: Text(
                  'Please select a PDF or DOCX file.',
                  style: batchtext2(Colors.red),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryMainColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'File Size Limit Exceeded',
                style: batchtext2(AppColors.PrimaryBlackColor),
              ),
              content: Text(
                'Please select a file with size less than 8 MB.',
                style: batchtext2(Colors.red),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.PrimaryMainColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void downloadFile() async {
    var time = DateTime.now().millisecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/image-$time.jpg";
    var file = File(path);
    var res = await get(Uri.parse("https://source.unsplash.com/random"));
    file.writeAsBytes(res.bodyBytes);
  }
}
