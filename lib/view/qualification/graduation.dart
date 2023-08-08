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
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

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
  File? file;
  final _registerkey = GlobalKey<FormState>();

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

  getUserDetails() {
    dashBoardBloc.getqualificationcontrollerStream.listen((event) {
      if (event != null) {
        qualidata = event;
        for (int i = 0; i < qualidata.length; i++) {
          QualificationSubmitModel qualificationSubmitModel =
              QualificationSubmitModel.fromJson(event[i]);
          qualificationdatasubmit.add(qualificationSubmitModel);
        }

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
    _gethomeData();
    showYear();

    dashBoardBloc.documentuploadControllerStream.listen((event) {
      Navigator.pop(context);

      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true && event.data["success"] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Document Submmited Succesfully"),
        ));

        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.donepage,
          (routes) => false,
        );

        setState(() {
          done = false;
          getUserDetails();
        });
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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
          setState(() {
            loading = false;
          });
        }
      }
    });
  }

  getBoardUniversityList() {
    dashBoardBloc.boarduniversityControllerStream.listen((event) {
      if (event != null) {
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
    };

    dashBoardBloc.callUploadDocumentApi(
      data,
      file!,
    );
  }

  @override
  void dispose() {
    streamEditingController.dispose();
    percentageEditingController.dispose();
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onbackbuttondoubleClick(context),
      child: Scaffold(
          backgroundColor: AppColors.backgroungcolor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppBar(
              backgroundColor: AppColors.PrimaryMainColor,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0)),
              ),
              leading: const Text(""),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.donepage,
                      (routes) => false,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 80,
                        child: Text(
                          "skip",
                          style: batchtext2(AppColors.PrimaryWhiteColor),
                        ),
                      ),
                    ),
                  ),
                )
              ],
              centerTitle: true,
              title: Text(
                "Qualification",
                style: OtpText(AppColors.PrimaryWhiteColor),
              ),
            ),
          ),
          body: loading
              ? Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  color: AppColors.PrimaryMainColor,
                ))
              : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: _registerkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Qualification",
                                style: FieldTextStyle(
                                  AppColors.PrimaryBlackColor,
                                )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2(
                                  isDense: false,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.hintcolor,
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.name.isEmpty) {
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
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                            ),
                                          ))
                                      .toList(growable: false),
                                  value: dropnqualification,
                                  onChanged: (QualificationModel? value) {
                                    setState(() {
                                      dropnqualification = value;
                                      isSelected = true;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 55,
                                    padding: EdgeInsets.all(10.r),
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          color: AppColors.backgroungcolor,
                                          border: Border.all()),
                                      maxHeight: 300.h,
                                      elevation: 10),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    height: 40,
                                  ),
                                  dropdownSearchData:
                                      DropdownSearchData<QualificationModel>(
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
                                  iconStyleData: const IconStyleData(
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
                              hint: "Enter Your stream",
                              title: "Stream",
                              controller: streamEditingController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Your Stream';
                                }
                                return null;
                              },
                            ),
                            Text("Course Type",
                                style: FieldTextStyle(
                                  AppColors.PrimaryBlackColor,
                                )),
                            SizedBox(
                              height: 5.h,
                            ),
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
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.hintcolor,
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Select Branch';
                                    }
                                    return null;
                                  },
                                  hint: Text(
                                    'Please select',
                                    style: batchtext2(AppColors.hintcolor),
                                  ),
                                  items: course
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                            ),
                                          ))
                                      .toList(),
                                  value: dropcourse,
                                  onChanged: (value) {
                                    setState(() {
                                      dropcourse = value;
                                      isSelected = true;
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    height: 55,
                                    width: 450,
                                    padding: EdgeInsets.all(10),
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
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    height: 40,
                                  ),
                                  iconStyleData: const IconStyleData(
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
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2(
                                  isDense: false,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.hintcolor,
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.name.isEmpty) {
                                      return 'Please Select Qualification';
                                    }
                                    return null;
                                  },
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
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                            ),
                                          ))
                                      .toList(growable: false),
                                  value: dropboard,
                                  onChanged: (BoardUniversityModel? value) {
                                    setState(() {
                                      dropboard = value;
                                      isSelected = true;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 55,
                                    padding: EdgeInsets.all(10.r),
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          color: AppColors.backgroungcolor,
                                          border: Border.all()),
                                      maxHeight: 300.h,
                                      elevation: 10),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    height: 40,
                                  ),
                                  dropdownSearchData:
                                      DropdownSearchData<BoardUniversityModel>(
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
                                  iconStyleData: const IconStyleData(
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
                              title: "Percentage/Grade",
                              controller: percentageEditingController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Your Percentage/Grade';
                                }
                                return null;
                              },
                            ),
                            Text("Starting Year",
                                style: FieldTextStyle(
                                  AppColors.PrimaryBlackColor,
                                )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2(
                                  isDense: false,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.hintcolor,
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Select Starting Year';
                                    }
                                    return null;
                                  },
                                  hint: Text(
                                    'Starting Year',
                                    style: batchtext2(AppColors.hintcolor),
                                  ),
                                  items: yearList
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item.toString(),
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                            ),
                                          ))
                                      .toList(growable: false),
                                  value: yeardrop,
                                  onChanged: (value) {
                                    setState(() {
                                      yeardrop = value as int?;
                                      isSelected = true;
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
                                          color: AppColors.backgroungcolor,
                                          border: Border.all()),
                                      maxHeight: 300.h,
                                      elevation: 10),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    height: 40,
                                  ),
                                  dropdownSearchData: DropdownSearchData(
                                    searchController: textEditingController,
                                    searchInnerWidgetHeight: 200.h,
                                    searchInnerWidget: Container(
                                      height: 50.h,
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
                                  iconStyleData: const IconStyleData(
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
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2(
                                  isDense: false,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      // width: 0.0 produces a thin "hairline" border
                                      borderSide: const BorderSide(
                                          color: AppColors.hintcolor,
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Select Starting Month';
                                    }
                                    return null;
                                  },
                                  hint: Text(
                                    'Starting Month',
                                    style: batchtext2(AppColors.hintcolor),
                                  ),
                                  items: months
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item.name.toString(),
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                            ),
                                          ))
                                      .toList(growable: false),
                                  value: dropmonth,
                                  onChanged: (value) {
                                    setState(() {
                                      dropmonth = value;
                                      isSelected = true;
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
                                          color: AppColors.backgroungcolor,
                                          border: Border.all()),
                                      maxHeight: 300.h,
                                      // width: 500.w,
                                      elevation: 10),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
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
                                  iconStyleData: const IconStyleData(
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
                            Text("Passing Year",
                                style: FieldTextStyle(
                                  AppColors.PrimaryBlackColor,
                                )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2(
                                  isDense: false,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.hintcolor,
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Select Passing Year';
                                    }
                                    return null;
                                  },
                                  hint: Text(
                                    'Passing Year',
                                    style: batchtext2(AppColors.hintcolor),
                                  ),
                                  items: yearList
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item.toString(),
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                            ),
                                          ))
                                      .toList(growable: false),
                                  value: droppassyear,
                                  onChanged: (value) {
                                    setState(() {
                                      droppassyear = value as int?;
                                      isSelected = true;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 55.h,
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
                                      elevation: 10),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
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
                                  iconStyleData: const IconStyleData(
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
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2(
                                  isDense: false,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.hintcolor,
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Select Passing Month';
                                    }
                                    return null;
                                  },
                                  hint: Text(
                                    'Passing Month',
                                    style: batchtext2(AppColors.hintcolor),
                                  ),
                                  items: months
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item.name.toString(),
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                            ),
                                          ))
                                      .toList(growable: false),
                                  value: droppassmonth,
                                  onChanged: (value) {
                                    setState(() {
                                      droppassmonth = value;
                                      isSelected = true;
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
                                          color: AppColors.backgroungcolor,
                                          border: Border.all()),
                                      maxHeight: 300.h,
                                      elevation: 10),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
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
                                  iconStyleData: const IconStyleData(
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
                            Text("Upload Graduation Marks",
                                style: FieldTextStyle(
                                  AppColors.PrimaryBlackColor,
                                )),
                            SizedBox(
                              height: 5.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectFiles();
                              },
                              child: Container(
                                  height: 50.h,
                                  width: 340.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.hintcolor),
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: (file == null)
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.r, right: 0),
                                                  child: Row(children: [
                                                    const Text("Upload File"),
                                                    Center(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                            color: Colors
                                                                .transparent,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10.r),
                                                            width: 220.w,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  height: 50.h,
                                                                  width: 2,
                                                                  color: AppColors
                                                                      .PrimaryGreyColor,
                                                                ),
                                                                Container(
                                                                  height: 50.h,
                                                                  width: 100.w,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                          color:
                                                                              Colors.white),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .attach_file),
                                                                      Text(
                                                                        "Attach",
                                                                        style: btntext(
                                                                            AppColors.PrimaryBlackColor),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                      ],
                                                    )),
                                                  ])),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.r, right: 0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.file_copy,
                                                        color: AppColors
                                                            .PrimaryMainColor,
                                                      ),
                                                      Center(
                                                          child: Container(
                                                        margin: EdgeInsets.only(
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
          bottomNavigationBar: done == false
              ? const Text("")
              : BottomAppBar(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: 15.r, left: 15.r, right: 15.r),
                    child: ButtonPrimary(
                      title: "Submit",
                      onPressed: () {
                        if (_registerkey.currentState!.validate() &&
                            file != null &&
                            dropnqualification != null &&
                            dropboard != null &&
                            yeardrop != null &&
                            droppassyear != null &&
                            droppassmonth != null &&
                            dropcourse != null) {
                          callUploadDocumentApi();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              "Please Upload file ",
                              style: batchtext2(AppColors.PrimaryWhiteColor),
                            ),
                          ));
                        }
                      },
                    ),
                  ))),
    );
  }

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
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<bool> _onbackbuttondoubleClick(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.bottomnav,
      (routes) => false,
    );
    return false;
  }
}
