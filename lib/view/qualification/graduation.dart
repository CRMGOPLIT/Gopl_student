
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/boarduniversity.dart';
import 'package:global_student/model/monthModel.dart';
import 'package:global_student/model/qualificationModel.dart';
import 'package:global_student/model/qualificationsubmitModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/button.dart';
import 'package:global_student/view/widget/loader.dart';
import 'package:global_student/view/widget/text_field.dart';
import '../../networking/NetworkConstant.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';
import '../helper/apiResponseHelper.dart';

class Graduation extends StatefulWidget {
  const Graduation({super.key});

  @override
  State<Graduation> createState() => _GraduationState();
}

class _GraduationState extends State<Graduation> {
  String dropdownvalue = 'Item 1';

  QualificationModel? dropnqualification;
  BoardUniversityModel? dropboard;
  MonthModel? dropmonth;
  int? yeardrop;
  int? droppassyear;
  MonthModel? droppassmonth;

  TextEditingController textEditingController = TextEditingController();
  TextEditingController streamEditingController = TextEditingController();
  TextEditingController percentageEditingController = TextEditingController();
  TextEditingController courseStudiedEditingController =
      TextEditingController();
  // TextEditingController textEditingController = TextEditingController();
  //   TextEditingController textEditingController = TextEditingController();
  //     TextEditingController textEditingController = TextEditingController();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  // List of items in our dropdown menu
  var course = [
    'Regular',
    'Distance',
  ];
  String? dropcourse;
  List yearList = [];

  showYear() {
    int year = DateTime.now().year;
    int yearfrom = year - 30;
    int yearto = year + 5;
    for (int i = yearfrom; i <= yearto; i++) {
      yearList.add(i);
    }
  }

  bool isSelected = false;
  bool isFileSelected = false;
  bool done = true;
  // List<File> selectedBankStatements = [];
  File? file;
  var _registerkey = GlobalKey<FormState>();

  late DashBoardBloc dashBoardBloc;
  List<QualificationModel> qualificationlist = [];
  List<BoardUniversityModel> boarduniversity = [];

  List<QualificationSubmitModel> qualificationdatasubmit = [];

  List qualificationdata = [];
  List boarddata = [];

  bool loading = true;
  bool loading1 = true;

  List qualidata = [];

  bool loading2 = true;

  // @override
  // void initState() {
  //   dashBoardBloc = DashBoardBloc();

  //   // SaveName();
  //   super.initState();
  // }

  getUserDetails() {
    dashBoardBloc.getqualificationcontrollerStream.listen((event) {
      if (event != null) {
        // debugger();
        // print(event);
        qualidata = event;
        for (int i = 0; i < qualidata.length; i++) {
          QualificationSubmitModel qualificationSubmitModel =
              QualificationSubmitModel.fromJson(event[i]);
          qualificationdatasubmit.add(qualificationSubmitModel);
        }
        // Application.add(userData1);
        setState(() {
          loading2 = false;
        });
      }
    });
  }

  @override
  initState() {
    dashBoardBloc = DashBoardBloc();
    getQualificationList();
    getBoardUniversityList();

    getUserDetails();

    //userData1 = "" as UsersDetailsModel;
    _gethomeData();
    //  callGetPromotersDetailsApi();
    _gethomeData();
    showYear();

    dashBoardBloc.documentuploadControllerStream.listen((event) {
      Navigator.pop(context);

      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);
      // debugger();
      // print(event);
      if (response == true && event.data["success"] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Document Submmited Succesfully"),
        ));
        // Navigator.pushNamed(context, RoutesName.interschool);
        setState(() {
          done = false;
        });

        //IF Anything going wrong

        // showDialog<void>(
        //     context: context,
        //     barrierColor: AppColors.PrimaryMainColor,
        //     barrierDismissible: false,
        //     builder: (BuildContext context) {
        //       return ApiErrorDialog(
        //           btnText: "Back To Home",
        //           image: "assets/images/batch.png",
        //           description: event.data['massage'].toString(),
        //           onPressed: () {
        //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //               content: Text(event.data['massage'].toString()),
        //             ));
        //             // Navigator.pop(context);
        //             // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //             //   content: Text(event.data['massage'].toString()),
        //             // ));
        //             // NavigationUtils().navigateOffAll(fileName: HomePage());
        //             return false;
        //           });
        //     });
      } else {
        setState(() {
          done = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(milliseconds: 1000),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
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
                      Text("Failed".toString(),
                          style: batchtext1(
                            AppColors.PrimaryWhiteColor,
                          )),
                      //         TextStyle(fontSize: 15.sp, color: Colors.white),
                      //     maxLines: 2,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
        // showDialog<void>(
        //     context: context,
        //     barrierColor: AppColors.PrimaryMainColor.withOpacity(0.1),
        //     barrierDismissible: false,
        //     builder: (BuildContext context) {
        //       return ApiErrorDialog(
        //           btnText: 'Retry',
        //           image: "assets/images/batch.png",
        //           description: event.data['massage'].toString(),
        //           onPressed: () {
        //             Navigator.pop(context);
        //             //  getMaxAMountLoanDetails();

        //             // Navigator.pushNamed(context, RoutesName.register);
        //           });
        //     });
      }
    });
    super.initState();
  }

  getQualificationList() {
    dashBoardBloc.qualificationControllerStream.listen((event) {
      if (event != null) {
        qualificationdata = event;
        for (int i = 0; i < qualificationdata.length; i++) {
          QualificationModel applicationStatusModel =
              QualificationModel.fromJson(event[i]);
          qualificationlist.add(applicationStatusModel);
        }
        setState(() {
          loading = false;
        });
      }
    });
  }

  getBoardUniversityList() {
    dashBoardBloc.boarduniversityControllerStream.listen((event) {
      if (event != null) {
        // debugger();
        // print(event);
        boarddata = event;
        for (int i = 0; i < boarddata.length; i++) {
          BoardUniversityModel boardUniversityModel =
              BoardUniversityModel.fromJson(event[i]);
          boarduniversity.add(boardUniversityModel);
        }
        setState(() {
          loading = false;
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callBoardListApi();
    dashBoardBloc.callQualificationApi();
    dashBoardBloc.callQualificationListApi();
  }

  void callUploadDocumentApi() {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Map data = {
      NetworkConstant.qualification: dropnqualification!.id,
      NetworkConstant.stream: streamEditingController.text,
      NetworkConstant.uboard: dropboard!.id,
      NetworkConstant.cstudied: streamEditingController.text,
      NetworkConstant.grade: percentageEditingController.text,
      NetworkConstant.syear: yeardrop.toString(),
      NetworkConstant.smonth: dropmonth!.id.toString(),
      NetworkConstant.pmonth: droppassmonth!.id.toString(),
      NetworkConstant.pyear: droppassyear!.toString(),
      NetworkConstant.rdistance: dropcourse,
      NetworkConstant.dtype: NetworkConstant.bachelor,
      // NetworkConstant.image: file!,
    };

    dashBoardBloc.callUploadDocumentApi(
      data,
      file!,
    );

    // debugger();
    // print(data);
  }

  @override
  void dispose() {
    streamEditingController.dispose();
    percentageEditingController.dispose();
    textEditingController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h), // here the desired height
          child: AppBarCustom(
            title: "Qualification",
            onpress: () {
              Navigator.pushNamed(context, RoutesName.bottomnav);
            },
          ),
        ),
        body: loading || qualificationdatasubmit.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: AppColors.PrimaryMainColor,
              ))
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: qualificationdatasubmit.isNotEmpty
                        ? Container(
                            height: 550.h,
                            child: ListView.builder(
                                itemCount: qualificationdatasubmit.length,
                                itemBuilder: (context, index) {
                                  return DonePage(
                                    count: qualificationdatasubmit.length,
                                    qualification:
                                        qualificationdatasubmit[index]
                                            .fQualification
                                            .toString(),
                                    stream: qualificationdatasubmit[index]
                                        .fCoursesStudied
                                        .toString(),
                                    coursetype: qualificationdatasubmit[index]
                                        .fRegularDistance
                                        .toString(),
                                    university: qualificationdatasubmit[index]
                                        .fUniversityBoard
                                        .toString(),
                                    percentage: qualificationdatasubmit[index]
                                        .fAvgGrade
                                        .toString(),
                                    startyear: qualificationdatasubmit[index]
                                        .fStartingYear
                                        .toString(),
                                    startmonth: qualificationdatasubmit[index]
                                        .startingMonth
                                        .toString(),
                                    passyear: qualificationdatasubmit[index]
                                        .fPassingYear
                                        .toString(),
                                    passmonth: qualificationdatasubmit[index]
                                        .passingMonth
                                        .toString(),
                                  );
                                }),
                          )
                        : Form(
                            key: _registerkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text("Qualification",
                                //     style: FieldTextStyle(
                                //       AppColors.PrimaryBlackColor,
                                //     )),
                                // Container(
                                //   height: 55,
                                //   width: 450,
                                //   decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(10)),
                                //   child: Padding(
                                //     padding: EdgeInsets.all(20.sp),
                                //     child: Text(
                                //       "10th",
                                //       // textAlign: TextAlign.center,
                                //       style: batchtext2(AppColors.PrimaryMainColor),
                                //     ),
                                //   ),
                                // ),
                                //  Text(li_year[i].toString()),
                                Text("Qualification",
                                    style: FieldTextStyle(
                                      AppColors.PrimaryBlackColor,
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      isDense: false,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        // enabledBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   // width: 0.0 produces a thin "hairline" border
                                        //   borderSide: BorderSide(
                                        //       color: AppColors.PrimaryMainColor, width: 1.0),
                                        // ),
                                        // errorBorder: new OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   borderSide:
                                        //       new BorderSide(color: Colors.red, width: 1.0),
                                        // ),
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.name.isEmpty) {
                                          return 'Please Select Qualification';
                                        }
                                        return null;
                                      },
                                      hint: Text(
                                        'Please select Qualification',
                                        style: batchtext2(AppColors.hintcolor),
                                      ),
                                      items: qualificationlist
                                          .map((QualificationModel item) =>
                                              DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.name.toString(),
                                                  style: batchtext2(AppColors
                                                      .PrimaryMainColor),
                                                ),
                                              ))
                                          .toList(growable: false),
                                      value: dropnqualification,
                                      onChanged: (QualificationModel? value) {
                                        setState(() {
                                          dropnqualification = value;
                                          isSelected = true;
                                          //  selectedSecurity = value!;
                                          // accountTypeValidate = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 55,
                                        // width: 450,
                                        padding: EdgeInsets.all(10.r),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                          // isOverButton: true,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color: AppColors.backgroungcolor,
                                              border: Border.all()),
                                          maxHeight: 300.h,
                                          // width: 500.w,
                                          elevation: 10),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData<
                                          QualificationModel>(
                                        searchController: textEditingController,
                                        searchInnerWidgetHeight: 200.h,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            style: batchtext2(
                                                AppColors.PrimaryMainColor),
                                            //expands: true,
                                            maxLines: 1,
                                            controller: textEditingController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 15,
                                              ),
                                              hintText: 'Search here...',
                                              hintStyle: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          // final myItem = qualificationlist.firstWhere((element) =>
                                          //     element.name.toString() == item.value.toString());
                                          return item.value!.name
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue);
                                        },
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (isOpen) {
                                          textEditingController.clear();
                                        }
                                      },
                                      iconStyleData: IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                        iconSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   height: 50.h,
                                //   width: 480.w,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(10.r)),
                                //   child: DropdownButtonFormField(
                                //     dropdownColor: AppColors.PrimaryGreyColor,
                                //     elevation: 5,
                                //     style: TextStyle(
                                //         color: AppColors.PrimaryMainColor,
                                //         fontWeight: FontWeight.w600),
                                //     decoration: InputDecoration(
                                //       enabledBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.r),
                                //         borderSide: const BorderSide(
                                //             color: AppColors.PrimaryGreyColor, width: 1),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.r),
                                //         borderSide: const BorderSide(
                                //           color: AppColors.PrimaryBlackColor,
                                //           width: 1,
                                //         ),
                                //       ),
                                //     ),
                                //     value: dropdownvalue,
                                //     isExpanded: false,
                                //     icon: Padding(
                                //       padding: EdgeInsets.only(right: 10.r),
                                //       child: Icon(
                                //         Icons.keyboard_arrow_down,
                                //         size: 30.sp,
                                //         color: AppColors.PrimaryMainColor,
                                //       ),
                                //     ),
                                //     items: items.map((String items) {
                                //       return DropdownMenuItem(
                                //         alignment: AlignmentDirectional.centerStart,
                                //         value: items,
                                //         child: Text(items),
                                //       );
                                //     }).toList(),
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         isSelected = true;
                                //       });
                                //     },
                                //   ),
                                // ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormWidget(
                                  hint: "Enter Your stream",
                                  title: "Stream",
                                  controller: streamEditingController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Your email';
                                    }
                                    return null;
                                  },
                                ),

                                // TextFormWidget(
                                //   hint: "Enter Your Course Studied",
                                //   title: "Course Studied",
                                //   controller: courseStudiedEditingController,
                                //   keyboardType: TextInputType.emailAddress,
                                //   validator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return 'Please enter Your email';
                                //     }
                                //     return null;
                                //   },
                                // ),

                                Text("Course Type",
                                    style: FieldTextStyle(
                                      AppColors.PrimaryBlackColor,
                                    )),
                                Container(
                                  height: 55,
                                  width: 450,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      isDense: false,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        // enabledBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   // width: 0.0 produces a thin "hairline" border
                                        //   // borderSide: BorderSide(
                                        //   //     color: AppColors.PrimaryMainColor,
                                        //   //     width: 1.0),
                                        // ),
                                        // errorBorder: new OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   borderSide: new BorderSide(
                                        //       color: Colors.red, width: 1.0),
                                        // ),
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      // validator: (value) {
                                      //   if (value == null || value.LocationName.isEmpty) {
                                      //     return 'Please Select Branch';
                                      //   }
                                      //   return null;
                                      // },
                                      hint: Text(
                                        'Please select',
                                        style: batchtext2(AppColors.hintcolor),
                                      ),
                                      items: course
                                          .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: batchtext2(AppColors
                                                      .PrimaryMainColor),
                                                ),
                                              ))
                                          .toList(),
                                      value: dropcourse,
                                      onChanged: (value) {
                                        setState(() {
                                          dropcourse = value;
                                          isSelected = true;
                                          //  selectedSecurity = value!;
                                          // accountTypeValidate = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 55,
                                        width: 450,
                                        padding: const EdgeInsets.all(10),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                          isOverButton: true,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color: AppColors.backgroungcolor,
                                              border: Border.all()),
                                          maxHeight: 200.h,
                                          elevation: 10),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40,
                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                        iconSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text("University/Board",
                                    style: FieldTextStyle(
                                      AppColors.PrimaryBlackColor,
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      isDense: false,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        // enabledBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   // width: 0.0 produces a thin "hairline" border
                                        //   borderSide: BorderSide(
                                        //       color: AppColors.PrimaryMainColor, width: 1.0),
                                        // ),
                                        errorBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: new BorderSide(
                                              color: Colors.red, width: 1.0),
                                        ),
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      // validator: (value) {
                                      //   if (value == null || value.name.isEmpty) {
                                      //     return 'Please Select Qualification';
                                      //   }
                                      //   return null;
                                      // },
                                      hint: Text(
                                        'Please select Qualification',
                                        style: batchtext2(AppColors.hintcolor),
                                      ),
                                      items: boarduniversity
                                          .map((BoardUniversityModel item) =>
                                              DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.name.toString(),
                                                  style: batchtext2(AppColors
                                                      .PrimaryMainColor),
                                                ),
                                              ))
                                          .toList(growable: false),
                                      value: dropboard,
                                      onChanged: (BoardUniversityModel? value) {
                                        setState(() {
                                          dropboard = value;
                                          isSelected = true;
                                          //  selectedSecurity = value!;
                                          // accountTypeValidate = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 55,
                                        // width: 450,
                                        padding: EdgeInsets.all(10.r),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                          // isOverButton: true,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color: AppColors.backgroungcolor,
                                              border: Border.all()),
                                          maxHeight: 300.h,
                                          // width: 500.w,
                                          elevation: 10),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData<
                                          BoardUniversityModel>(
                                        searchController: textEditingController,
                                        searchInnerWidgetHeight: 200.h,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            style: batchtext2(
                                                AppColors.PrimaryMainColor),
                                            //expands: true,
                                            maxLines: 1,
                                            controller: textEditingController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 15,
                                              ),
                                              hintText: 'Search here...',
                                              hintStyle: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          // final myItem = qualificationlist.firstWhere((element) =>
                                          //     element.name.toString() == item.value.toString());
                                          return item.value!.name
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue);
                                        },
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (isOpen) {
                                          textEditingController.clear();
                                        }
                                      },
                                      iconStyleData: IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                        iconSize: 30,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),

                                TextFormWidget(
                                  hint: "Enter Your percentage",
                                  title: "Percentage/Grade/%",
                                  controller: percentageEditingController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Your email';
                                    }
                                    return null;
                                  },
                                ),

                                Text("Starting Year",
                                    style: FieldTextStyle(
                                      AppColors.PrimaryBlackColor,
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      isDense: false,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        // enabledBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   // width: 0.0 produces a thin "hairline" border
                                        //   borderSide: BorderSide(
                                        //       color: AppColors.PrimaryMainColor, width: 1.0),
                                        // ),
                                        errorBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: new BorderSide(
                                              color: Colors.red, width: 1.0),
                                        ),
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      // validator: (value) {
                                      //   if (value == null || value.name.isEmpty) {
                                      //     return 'Please Select Qualification';
                                      //   }
                                      //   return null;
                                      // },
                                      hint: Text(
                                        'Starting Year',
                                        style: batchtext2(AppColors.hintcolor),
                                      ),
                                      items: yearList
                                          .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.toString(),
                                                  style: batchtext2(AppColors
                                                      .PrimaryMainColor),
                                                ),
                                              ))
                                          .toList(growable: false),
                                      value: yeardrop,
                                      onChanged: (value) {
                                        setState(() {
                                          yeardrop = value as int?;
                                          isSelected = true;
                                          //  selectedSecurity = value!;
                                          // accountTypeValidate = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 55,
                                        // width: 450,
                                        padding: EdgeInsets.all(10.r),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                          // isOverButton: true,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color: AppColors.backgroungcolor,
                                              border: Border.all()),
                                          maxHeight: 300.h,
                                          // width: 500.w,
                                          elevation: 10),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: textEditingController,
                                        searchInnerWidgetHeight: 200.h,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            style: batchtext2(
                                                AppColors.PrimaryMainColor),
                                            //expands: true,
                                            maxLines: 1,
                                            controller: textEditingController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 15,
                                              ),
                                              hintText: 'Search here...',
                                              hintStyle: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          // final myItem = qualificationlist.firstWhere((element) =>
                                          //     element.name.toString() == item.value.toString());
                                          return item.value!
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue);
                                        },
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (isOpen) {
                                          textEditingController.clear();
                                        }
                                      },
                                      iconStyleData: IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                        iconSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text("Starting Month",
                                    style: FieldTextStyle(
                                      AppColors.PrimaryBlackColor,
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      isDense: false,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        // enabledBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   // width: 0.0 produces a thin "hairline" border
                                        //   borderSide: BorderSide(
                                        //       color: AppColors.PrimaryMainColor, width: 1.0),
                                        // ),
                                        errorBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: new BorderSide(
                                              color: Colors.red, width: 1.0),
                                        ),
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      // validator: (value) {
                                      //   if (value == null || value.name.isEmpty) {
                                      //     return 'Please Select Qualification';
                                      //   }
                                      //   return null;
                                      // },
                                      hint: Text(
                                        'Starting Month',
                                        style: batchtext2(AppColors.hintcolor),
                                      ),
                                      items: months
                                          .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.name.toString(),
                                                  style: batchtext2(AppColors
                                                      .PrimaryMainColor),
                                                ),
                                              ))
                                          .toList(growable: false),
                                      value: dropmonth,
                                      onChanged: (value) {
                                        setState(() {
                                          dropmonth = value as MonthModel?;
                                          isSelected = true;
                                          //  selectedSecurity = value!;
                                          // accountTypeValidate = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 55,
                                        // width: 450,
                                        padding: EdgeInsets.all(10.r),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                          // isOverButton: true,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color: AppColors.backgroungcolor,
                                              border: Border.all()),
                                          maxHeight: 300.h,
                                          // width: 500.w,
                                          elevation: 10),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40,
                                      ),
                                      dropdownSearchData:
                                          DropdownSearchData<MonthModel>(
                                        searchController: textEditingController,
                                        searchInnerWidgetHeight: 200.h,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            style: batchtext2(
                                                AppColors.PrimaryMainColor),
                                            //expands: true,
                                            maxLines: 1,
                                            controller: textEditingController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 15,
                                              ),
                                              hintText: 'Search here...',
                                              hintStyle: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          // final myItem = qualificationlist.firstWhere((element) =>
                                          //     element.name.toString() == item.value.toString());
                                          return item.value!.name
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue);
                                        },
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (isOpen) {
                                          textEditingController.clear();
                                        }
                                      },
                                      iconStyleData: IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                        iconSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Passing Year",
                                    style: FieldTextStyle(
                                      AppColors.PrimaryBlackColor,
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      isDense: false,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        // enabledBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   // width: 0.0 produces a thin "hairline" border
                                        //   borderSide: BorderSide(
                                        //       color: AppColors.PrimaryMainColor, width: 1.0),
                                        // ),
                                        errorBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: new BorderSide(
                                              color: Colors.red, width: 1.0),
                                        ),
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      // validator: (value) {
                                      //   if (value == null || value.name.isEmpty) {
                                      //     return 'Please Select Qualification';
                                      //   }
                                      //   return null;
                                      // },
                                      hint: Text(
                                        'Passing Year',
                                        style: batchtext2(AppColors.hintcolor),
                                      ),
                                      items: yearList
                                          .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.toString(),
                                                  style: batchtext2(AppColors
                                                      .PrimaryMainColor),
                                                ),
                                              ))
                                          .toList(growable: false),
                                      value: droppassyear,
                                      onChanged: (value) {
                                        setState(() {
                                          droppassyear = value as int?;
                                          isSelected = true;
                                          //  selectedSecurity = value!;
                                          // accountTypeValidate = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 55,
                                        // width: 450,
                                        padding: EdgeInsets.all(10.r),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                          // isOverButton: true,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color: AppColors.backgroungcolor,
                                              border: Border.all()),
                                          maxHeight: 300.h,
                                          // width: 500.w,
                                          elevation: 10),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: textEditingController,
                                        searchInnerWidgetHeight: 200.h,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            style: batchtext2(
                                                AppColors.PrimaryMainColor),
                                            //expands: true,
                                            maxLines: 1,
                                            controller: textEditingController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 15,
                                              ),
                                              hintText: 'Search here...',
                                              hintStyle: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          // final myItem = qualificationlist.firstWhere((element) =>
                                          //     element.name.toString() == item.value.toString());
                                          return item.value!
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue);
                                        },
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (isOpen) {
                                          textEditingController.clear();
                                        }
                                      },
                                      iconStyleData: IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                        iconSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text("Passing Month",
                                    style: FieldTextStyle(
                                      AppColors.PrimaryBlackColor,
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      isDense: false,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        // enabledBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   // width: 0.0 produces a thin "hairline" border
                                        //   borderSide: BorderSide(
                                        //       color: AppColors.PrimaryMainColor, width: 1.0),
                                        // ),
                                        errorBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: new BorderSide(
                                              color: Colors.red, width: 1.0),
                                        ),
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      // validator: (value) {
                                      //   if (value == null || value.name.isEmpty) {
                                      //     return 'Please Select Qualification';
                                      //   }
                                      //   return null;
                                      // },
                                      hint: Text(
                                        'Passing Month',
                                        style: batchtext2(AppColors.hintcolor),
                                      ),
                                      items: months
                                          .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.name.toString(),
                                                  style: batchtext2(AppColors
                                                      .PrimaryMainColor),
                                                ),
                                              ))
                                          .toList(growable: false),
                                      value: droppassmonth,
                                      onChanged: (value) {
                                        setState(() {
                                          droppassmonth = value as MonthModel?;
                                          isSelected = true;

                                          // accountTypeValidate = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 55,
                                        // width: 450,
                                        padding: EdgeInsets.all(10.r),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                          // isOverButton: true,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color: AppColors.backgroungcolor,
                                              border: Border.all()),
                                          maxHeight: 300.h,
                                          // width: 500.w,
                                          elevation: 10),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 40,
                                      ),
                                      dropdownSearchData:
                                          DropdownSearchData<MonthModel>(
                                        searchController: textEditingController,
                                        searchInnerWidgetHeight: 200.h,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            style: batchtext2(
                                                AppColors.PrimaryMainColor),
                                            //expands: true,
                                            maxLines: 1,
                                            controller: textEditingController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 15,
                                              ),
                                              hintText: 'Search here...',
                                              hintStyle: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          // final myItem = qualificationlist.firstWhere((element) =>
                                          //     element.name.toString() == item.value.toString());
                                          return item.value!.name
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue);
                                        },
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (isOpen) {
                                          textEditingController.clear();
                                        }
                                      },
                                      iconStyleData: IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                        iconSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                // Text("Regular/Distance",
                                //     style: FieldTextStyle(
                                //       AppColors.PrimaryBlackColor,
                                //     )),
                                // Container(
                                //   height: 50.h,
                                //   width: 480.w,
                                //   decoration:
                                //       BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                                //   child: DropdownButtonFormField(
                                //     style: TextStyle(
                                //         color: AppColors.PrimaryMainColor,
                                //         fontWeight: FontWeight.w600),
                                //     decoration: InputDecoration(
                                //       enabledBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.r),
                                //         borderSide: const BorderSide(
                                //             color: AppColors.PrimaryGreyColor, width: 1),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.r),
                                //         borderSide: const BorderSide(
                                //           color: AppColors.PrimaryBlackColor,
                                //           width: 1,
                                //         ),
                                //       ),
                                //     ),
                                //     value: dropdownvalue,
                                //     isExpanded: true,
                                //     icon: Padding(
                                //       padding: EdgeInsets.only(right: 10.r),
                                //       child: Icon(
                                //         Icons.keyboard_arrow_down,
                                //         size: 30.sp,
                                //         color: AppColors.PrimaryMainColor,
                                //       ),
                                //     ),
                                //     items: items.map((String items) {
                                //       return DropdownMenuItem(
                                //         value: items,
                                //         child: Padding(
                                //           padding: EdgeInsets.only(left: 10.r),
                                //           child: Text(items),
                                //         ),
                                //       );
                                //     }).toList(),
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         isSelected = true;
                                //       });
                                //     },
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // Text("Percentage/CGPA",
                                //     style: FieldTextStyle(
                                //       AppColors.PrimaryBlackColor,
                                //     )),
                                // Container(
                                //   height: 50.h,
                                //   width: 480.w,
                                //   decoration:
                                //       BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                                //   child: DropdownButtonFormField(
                                //     style: TextStyle(
                                //         color: AppColors.PrimaryMainColor,
                                //         fontWeight: FontWeight.w600),
                                //     decoration: InputDecoration(
                                //       enabledBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.r),
                                //         borderSide: const BorderSide(
                                //             color: AppColors.PrimaryGreyColor, width: 1),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.r),
                                //         borderSide: const BorderSide(
                                //           color: AppColors.PrimaryBlackColor,
                                //           width: 1,
                                //         ),
                                //       ),
                                //     ),
                                //     value: dropdownvalue,
                                //     isExpanded: true,
                                //     icon: Padding(
                                //       padding: EdgeInsets.only(right: 10.r),
                                //       child: Icon(
                                //         Icons.keyboard_arrow_down,
                                //         size: 30.sp,
                                //         color: AppColors.PrimaryMainColor,
                                //       ),
                                //     ),
                                //     items: items.map((String items) {
                                //       return DropdownMenuItem(
                                //         value: items,
                                //         child: Padding(
                                //           padding: EdgeInsets.only(left: 10.r),
                                //           child: Text(items),
                                //         ),
                                //       );
                                //     }).toList(),
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         isSelected = true;
                                //       });
                                //     },
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // Text("Degree start Year",
                                //     style: FieldTextStyle(
                                //       AppColors.PrimaryBlackColor,
                                //     )),
                                // DropdownButtonHideUnderline(
                                //   child: DropdownButtonFormField2(
                                //     isDense: false,
                                //     isExpanded: true,
                                //     decoration: InputDecoration(
                                //       enabledBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10),
                                //         // width: 0.0 produces a thin "hairline" border
                                //         borderSide: BorderSide(
                                //             color: AppColors.PrimaryMainColor, width: 1.0),
                                //       ),
                                //       errorBorder: new OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10),
                                //         borderSide:
                                //             new BorderSide(color: Colors.red, width: 1.0),
                                //       ),
                                //       isCollapsed: true,
                                //       border: InputBorder.none,
                                //     ),
                                //     // validator: (value) {
                                //     //   if (value == null || value.yearlis.isEmpty) {
                                //     //     return 'Please Select Qualification';
                                //     //   }
                                //     //   return null;
                                //     // },
                                //     hint: Text(
                                //       'Please select Degree Start Year',
                                //       style: Text2Regular(AppColors.PrimaryMainColor),
                                //     ),
                                //     items: yearList
                                //         .map((item) => DropdownMenuItem(
                                //               value: item,
                                //               child: Text(
                                //                 item.toString(),
                                //                 style: batchtext2(AppColors.PrimaryMainColor),
                                //               ),
                                //             ))
                                //         .toList(growable: false),
                                //     value: yeardrop,
                                //     onChanged: (value) {
                                //       setState(() {
                                //         //yeardrop = value as String?;
                                //         isSelected = true;
                                //         //  selectedSecurity = value!;
                                //         // accountTypeValidate = true;
                                //       });
                                //     },
                                //     buttonStyleData: ButtonStyleData(
                                //       height: 55,
                                //       // width: 450,
                                //       padding: const EdgeInsets.all(10),
                                //     ),
                                //     dropdownStyleData: DropdownStyleData(
                                //         isOverButton: true,
                                //         decoration: BoxDecoration(
                                //             borderRadius: BorderRadius.circular(10.sp),
                                //             color: AppColors.backgroungcolor,
                                //             border: Border.all()),
                                //         maxHeight: 200.h,
                                //         // width: 500.w,
                                //         elevation: 10),
                                //     menuItemStyleData: const MenuItemStyleData(
                                //       padding: EdgeInsets.only(left: 10, right: 10),
                                //       height: 40,
                                //     ),
                                //     dropdownSearchData: DropdownSearchData(
                                //       searchController: textEditingController,
                                //       searchInnerWidgetHeight: 200.h,
                                //       searchInnerWidget: Container(
                                //         height: 50,
                                //         padding: const EdgeInsets.only(
                                //           top: 8,
                                //           bottom: 4,
                                //           right: 8,
                                //           left: 8,
                                //         ),
                                //         child: TextFormField(
                                //           style: batchtext2(AppColors.PrimaryMainColor),
                                //           //expands: true,
                                //           maxLines: 1,
                                //           controller: textEditingController,
                                //           decoration: InputDecoration(
                                //             isDense: true,
                                //             contentPadding: const EdgeInsets.symmetric(
                                //               horizontal: 15,
                                //               vertical: 15,
                                //             ),
                                //             hintText: 'Search here...',
                                //             hintStyle: TextStyle(
                                //                 fontSize: 12,
                                //                 color: AppColors.PrimaryMainColor),
                                //             border: OutlineInputBorder(
                                //               borderRadius: BorderRadius.circular(8.sp),
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       searchMatchFn: (item, searchValue) {
                                //         // final myItem = qualificationlist.firstWhere((element) =>
                                //         //     element.name.toString() == item.value.toString());
                                //         return item.value
                                //             .toString()
                                //             .toLowerCase()
                                //             .contains(searchValue);
                                //       },
                                //     ),
                                //     onMenuStateChange: (isOpen) {
                                //       if (isOpen) {
                                //         textEditingController.clear();
                                //       }
                                //     },
                                //     iconStyleData: IconStyleData(
                                //       icon: Icon(
                                //         Icons.keyboard_arrow_down,
                                //         color: AppColors.PrimaryMainColor,
                                //       ),
                                //       iconSize: 30,
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // Text("Degree end Year",
                                //     style: FieldTextStyle(
                                //       AppColors.PrimaryBlackColor,
                                //     )),
                                // Container(
                                //   height: 50.h,
                                //   width: 480.w,
                                //   decoration:
                                //       BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                                //   child: DropdownButtonFormField(
                                //     style: TextStyle(
                                //         color: AppColors.PrimaryMainColor,
                                //         fontWeight: FontWeight.w600),
                                //     decoration: InputDecoration(
                                //       enabledBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.r),
                                //         borderSide: const BorderSide(
                                //             color: AppColors.PrimaryGreyColor, width: 1),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.r),
                                //         borderSide: const BorderSide(
                                //           color: AppColors.PrimaryBlackColor,
                                //           width: 1,
                                //         ),
                                //       ),
                                //     ),
                                //     value: dropdownvalue,
                                //     isExpanded: true,
                                //     icon: Padding(
                                //       padding: EdgeInsets.only(right: 10.r),
                                //       child: Icon(
                                //         Icons.keyboard_arrow_down,
                                //         size: 30.sp,
                                //         color: AppColors.PrimaryMainColor,
                                //       ),
                                //     ),
                                //     items: items.map((String items) {
                                //       return DropdownMenuItem(
                                //         value: items,
                                //         child: Padding(
                                //           padding: EdgeInsets.only(left: 10.r),
                                //           child: Text(items),
                                //         ),
                                //       );
                                //     }).toList(),
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         isSelected = true;
                                //       });
                                //     },
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // Text("Upload 10th Marks",
                                //     style: FieldTextStyle(
                                //       AppColors.PrimaryBlackColor,
                                //     )),
                                // Container(
                                //   height: 50.h,
                                //   width: 480.w,
                                //   decoration:
                                //       BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                                //   child: DropdownButtonFormField(
                                //     style: TextStyle(
                                //         color: AppColors.PrimaryMainColor,
                                //         fontWeight: FontWeight.w600),
                                //     decoration: InputDecoration(
                                //       enabledBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.r),
                                //         borderSide: const BorderSide(
                                //             color: AppColors.PrimaryGreyColor, width: 1),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.r),
                                //         borderSide: const BorderSide(
                                //           color: AppColors.PrimaryBlackColor,
                                //           width: 1,
                                //         ),
                                //       ),
                                //     ),
                                //     value: dropdownvalue,
                                //     isExpanded: true,
                                //     icon: Padding(
                                //       padding: EdgeInsets.only(right: 10.r),
                                //       child: Icon(
                                //         Icons.keyboard_arrow_down,
                                //         size: 30.sp,
                                //         color: AppColors.PrimaryMainColor,
                                //       ),
                                //     ),
                                //     items: items.map((String items) {
                                //       return DropdownMenuItem(
                                //         value: items,
                                //         child: Padding(
                                //           padding: EdgeInsets.only(left: 10.r),
                                //           child: Text(items),
                                //         ),
                                //       );
                                //     }).toList(),
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         isSelected = true;
                                //       });
                                //     },
                                //   ),
                                // ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text("Upload 10th Marks",
                                    style: FieldTextStyle(
                                      AppColors.PrimaryBlackColor,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    selectFiles();
                                  },
                                  child: Container(
                                      height: 50.h,
                                      width: 340.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  AppColors.PrimaryWhiteColor),
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: (file == null)
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.r, right: 0),
                                                      child: Row(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment.end,
                                                          children: [
                                                            Text("Upload File"),
                                                            Center(
                                                                child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                    color: Colors
                                                                        .transparent,
                                                                    margin: EdgeInsets.only(
                                                                        left: 10
                                                                            .r),
                                                                    width:
                                                                        220.w,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              2,
                                                                          color:
                                                                              AppColors.PrimaryGreyColor,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              50.h,
                                                                          width:
                                                                              100.w,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white
                                                                              // color: AppColors
                                                                              //     .PrimaryGreyColor,
                                                                              // border: Border.all(
                                                                              //     color: AppColors
                                                                              //         .PrimaryGreyColor),
                                                                              // borderRadius:
                                                                              //     const BorderRadius
                                                                              //             .only(
                                                                              //         topRight: Radius
                                                                              //             .circular(
                                                                              //                 10),
                                                                              //         bottomRight: Radius
                                                                              //             .circular(
                                                                              //                 10))
                                                                              ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(Icons.attach_file),
                                                                              Text(
                                                                                "Attach",
                                                                                style: btntext(AppColors.PrimaryBlackColor),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                    //Text(file!.path!.split('/').last),
                                                                    ),
                                                              ],
                                                            )),
                                                          ])
                                                      // : Row(
                                                      //     children: [
                                                      //       Image.asset(
                                                      //         "assets/images/docx.png",
                                                      //         height: 20.h,
                                                      //       ),
                                                      //       Center(
                                                      //           child: Container(
                                                      //         margin: EdgeInsets.only(
                                                      //             left: 10.r),
                                                      //         width: 250.w,
                                                      //         child: Text(file!.path!
                                                      //             .split('/')
                                                      //             .last),
                                                      //       )),
                                                      //     ],
                                                      //   )
                                                      ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.r, right: 0),
                                                      //
                                                      child:
                                                          //(file!.path.split(".pdf")[0] == "pdf")
                                                          // ? Row(
                                                          //     // mainAxisAlignment:
                                                          //     //     MainAxisAlignment.end,
                                                          //     children: [
                                                          //         const Icon(
                                                          //           Icons.picture_as_pdf,
                                                          //           color: Colors.red,
                                                          //         ),
                                                          //         SizedBox(
                                                          //           width: 10.w,
                                                          //         ),
                                                          //         Text(file!.path
                                                          //             .split('/')
                                                          //             .last),
                                                          //       ])
                                                          Row(
                                                        children: [
                                                          Icon(
                                                            Icons.file_copy,
                                                            color: AppColors
                                                                .PrimaryMainColor,
                                                          ),
                                                          Center(
                                                              child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10.r),
                                                            width: 250.w,
                                                            child: Text(
                                                              file!.path
                                                                  .split('/')
                                                                  .last,
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                            ),
                                                          )),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            )),
                                ),
                              ],
                            ),
                          )),
              ),
        bottomNavigationBar: done || qualificationdatasubmit.isNotEmpty
            ? Text("")
            : Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/bgreg.jpeg",
                        ))),
                child: BottomAppBar(
                    elevation: 0.0,
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 15.r, left: 15.r, right: 15.r),
                      child: ButtonPrimary(
                        title: "Submit",
                        onPressed: () {
                          callUploadDocumentApi();

                          // if (_registerkey.currentState!.validate()) {

                          //   // use the email provided here
                          // }
                        },
                      ),
                    )),
              ));
  }

  // void selectFiles() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: false,
  //     type: FileType.custom,
  //     allowedExtensions: ['docx', 'pdf'],
  //   );
  //   if (result == null) return;

  //   file = result.files

  //   setState(() {});
  // }

  // void selectFiles() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowedExtensions: ['pdf'],
  //       type: FileType.custom,
  //     );

  //     if (result != null) {
  //       setState(() {
  //         file = File(result.files.single.path!);
  //       });
  //     } else {
  //       // User canceled the picker
  //     }
  //   } catch (e) {
  //     // debugger();
  //     //print(e);
  //   }
  // }

  void selectFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['pdf', 'docx'],
        type: FileType.custom,
      );

      if (result != null) {
        setState(() {
          file = File(result.files.single.path!);
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
      //print(e);
    }
  }
}

class DonePage extends StatefulWidget {
  String? stream;
  String? coursetype;
  String? university;
  String? course;
  String? percentage;
  String? startyear;
  String? startmonth;
  String? passyear;
  String? passmonth;
  String? qualification;
  int? count;
  int? index;
  DonePage(
      {this.stream,
      this.course,
      this.coursetype,
      this.passmonth,
      this.passyear,
      this.percentage,
      this.startmonth,
      this.startyear,
      this.university,
      this.qualification,
      this.count,
      this.index});

  @override
  State<DonePage> createState() => _DonePageState(
      course: course,
      coursetype: coursetype,
      startmonth: startmonth,
      passmonth: passmonth,
      stream: stream,
      startyear: startyear,
      passyear: passyear,
      percentage: percentage,
      university: university,
      count: count,
      index: index,
      qualification: qualification);
}

class _DonePageState extends State<DonePage> {
  String? stream;
  String? coursetype;
  String? university;
  String? course;
  String? percentage;
  String? startyear;
  String? startmonth;
  String? passyear;
  String? passmonth;
  String? qualification;
  int? count;
  int? index;
  _DonePageState({
    this.stream,
    this.course,
    this.coursetype,
    this.passmonth,
    this.passyear,
    this.percentage,
    this.startmonth,
    this.startyear,
    this.university,
    this.qualification,
    this.count,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Text(
          //   "Your Education Details",
          //   style: FieldTextStyle(AppColors.PrimaryMainColor),
          // ),
          SizedBox(
            height: 10.h,
          ),
          Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // gradient: LinearGradient(
                //   colors: [
                //     AppColors.PrimaryMainColor,
                //     // Color(0xff72DAF7),
                //     Color(0xff6538A8),
                //   ],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
              ),
              child: ListTile(
                // title: Padding(
                //   padding: EdgeInsets.only(bottom: 1.sp, top: 10.sp),
                //   child: Text(
                //     "Name",
                //     style: FieldTextStyle(AppColors.PrimaryBlackColor),
                //   ),
                // ),
                subtitle: Padding(
                  padding: EdgeInsets.only(bottom: 5.sp, top: 5.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Qualification:- ",
                              style:
                                  FieldTextStyle(AppColors.PrimaryMainColor)),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text("$qualification",
                              style:
                                  FieldTextStyle(AppColors.PrimaryMainColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Stream:-",
                              style: batchtext2(AppColors.PrimaryBlackColor)),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text("$stream",
                              style: batchtext1(AppColors.PrimaryBlackColor)),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Text("Course Type:-",
                              style: batchtext2(AppColors.PrimaryBlackColor)),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text("$coursetype",
                              style: batchtext1(AppColors.PrimaryBlackColor)),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("University/Board :-",
                              style: batchtext2(AppColors.PrimaryBlackColor)),
                          Flexible(
                            child: Text("$university",
                                style: batchtext1(AppColors.PrimaryBlackColor)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Text("Percentage/Grade :-",
                              style: batchtext2(AppColors.PrimaryBlackColor)),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text("$percentage",
                              style: batchtext1(AppColors.PrimaryBlackColor)),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text("Start Year :-",
                                  style:
                                      batchtext2(AppColors.PrimaryBlackColor)),
                              Text("$startyear",
                                  style:
                                      batchtext1(AppColors.PrimaryBlackColor)),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              Text("Start Month :-",
                                  style:
                                      batchtext2(AppColors.PrimaryBlackColor)),
                              Text("$startmonth",
                                  style:
                                      batchtext1(AppColors.PrimaryBlackColor)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text("Pass Year :- ",
                                  style:
                                      batchtext2(AppColors.PrimaryBlackColor)),
                              Text("$passyear",
                                  style:
                                      batchtext1(AppColors.PrimaryBlackColor)),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              Text("Pass Month :-",
                                  style:
                                      batchtext2(AppColors.PrimaryBlackColor)),
                              Text("$passmonth",
                                  style:
                                      batchtext1(AppColors.PrimaryBlackColor)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // SizedBox(
          //   height: 550.h,
          //   child: ListView.builder(
          //       itemCount: count,
          //       shrinkWrap: true,
          //       itemBuilder: ((context, index) {
          //         return

          //       })),
          // ),
        ],
      ),
    );
  }
}
