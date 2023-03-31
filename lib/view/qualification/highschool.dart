import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/qualificationModel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/button.dart';
import 'package:lottie/lottie.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';

class HighSchool extends StatefulWidget {
  const HighSchool({super.key});

  @override
  State<HighSchool> createState() => _HighSchoolState();
}

class _HighSchoolState extends State<HighSchool> {
  String dropdownvalue = 'Item 1';

  QualificationModel? dropnqualification;

  String? yeardrop;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
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
  // List<File> selectedBankStatements = [];
  PlatformFile? file;
  var _registerkey = GlobalKey<FormState>();

  late DashBoardBloc dashBoardBloc;
  List<QualificationModel> qualificationlist = [];

  List qualificationdata = [];

  bool loading = true;

  @override
  initState() {
    dashBoardBloc = DashBoardBloc();
    getQualificationList();
    _gethomeData();
    showYear();
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

  _gethomeData() {
    dashBoardBloc.callQualificationListApi();
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _registerkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  Text(li_year[i].toString()),
                Text("Qualification",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    )),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2(
                    isDense: false,
                    isExpanded: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: BorderSide(
                            color: AppColors.PrimaryMainColor, width: 1.0),
                      ),
                      errorBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            new BorderSide(color: Colors.red, width: 1.0),
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
                      style: Text2Regular(AppColors.PrimaryMainColor),
                    ),
                    items: qualificationlist
                        .map((QualificationModel item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item.name.toString(),
                                style: batchtext2(AppColors.PrimaryMainColor),
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
                        isOverButton: true,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            color: AppColors.backgroungcolor,
                            border: Border.all()),
                        maxHeight: 500.h,
                        // width: 500.w,
                        elevation: 10),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.only(left: 10, right: 10),
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
                Text("Stream",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    )),
                Container(
                  height: 50.h,
                  width: 480.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: DropdownButtonFormField(
                    style: TextStyle(
                        color: AppColors.PrimaryMainColor,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: AppColors.PrimaryGreyColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                          color: AppColors.PrimaryBlackColor,
                          width: 1,
                        ),
                      ),
                    ),
                    value: dropdownvalue,
                    isExpanded: true,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.r),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.sp,
                        color: AppColors.PrimaryMainColor,
                      ),
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        isSelected = true;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("Board/University",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    )),
                Container(
                  height: 50.h,
                  width: 480.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: DropdownButtonFormField(
                    style: TextStyle(
                        color: AppColors.PrimaryMainColor,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: AppColors.PrimaryGreyColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                          color: AppColors.PrimaryBlackColor,
                          width: 1,
                        ),
                      ),
                    ),
                    value: dropdownvalue,
                    isExpanded: true,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.r),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.sp,
                        color: AppColors.PrimaryMainColor,
                      ),
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.r),
                          child: Text(items),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        isSelected = true;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("Regular/Distance",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    )),
                Container(
                  height: 50.h,
                  width: 480.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: DropdownButtonFormField(
                    style: TextStyle(
                        color: AppColors.PrimaryMainColor,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: AppColors.PrimaryGreyColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                          color: AppColors.PrimaryBlackColor,
                          width: 1,
                        ),
                      ),
                    ),
                    value: dropdownvalue,
                    isExpanded: true,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.r),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.sp,
                        color: AppColors.PrimaryMainColor,
                      ),
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.r),
                          child: Text(items),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        isSelected = true;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("Percentage/CGPA",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    )),
                Container(
                  height: 50.h,
                  width: 480.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: DropdownButtonFormField(
                    style: TextStyle(
                        color: AppColors.PrimaryMainColor,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: AppColors.PrimaryGreyColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                          color: AppColors.PrimaryBlackColor,
                          width: 1,
                        ),
                      ),
                    ),
                    value: dropdownvalue,
                    isExpanded: true,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.r),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.sp,
                        color: AppColors.PrimaryMainColor,
                      ),
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.r),
                          child: Text(items),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        isSelected = true;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("Degree start Year",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    )),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2(
                    isDense: false,
                    isExpanded: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: BorderSide(
                            color: AppColors.PrimaryMainColor, width: 1.0),
                      ),
                      errorBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            new BorderSide(color: Colors.red, width: 1.0),
                      ),
                      isCollapsed: true,
                      border: InputBorder.none,
                    ),
                    // validator: (value) {
                    //   if (value == null || value.yearlis.isEmpty) {
                    //     return 'Please Select Qualification';
                    //   }
                    //   return null;
                    // },
                    hint: Text(
                      'Please select Degree Start Year',
                      style: Text2Regular(AppColors.PrimaryMainColor),
                    ),
                    items: yearList
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item.toString(),
                                style: batchtext2(AppColors.PrimaryMainColor),
                              ),
                            ))
                        .toList(growable: false),
                    value: yeardrop,
                    onChanged: (value) {
                      setState(() {
                        //yeardrop = value as String?;
                        isSelected = true;
                        //  selectedSecurity = value!;
                        // accountTypeValidate = true;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 55,
                      // width: 450,
                      padding: const EdgeInsets.all(10),
                    ),
                    dropdownStyleData: DropdownStyleData(
                        isOverButton: true,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            color: AppColors.backgroungcolor,
                            border: Border.all()),
                        maxHeight: 300.h,
                        // width: 500.w,
                        elevation: 10),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.only(left: 10, right: 10),
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
                SizedBox(
                  height: 10.h,
                ),
                Text("Degree end Year",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    )),
                Container(
                  height: 50.h,
                  width: 480.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: DropdownButtonFormField(
                    style: TextStyle(
                        color: AppColors.PrimaryMainColor,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: AppColors.PrimaryGreyColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                          color: AppColors.PrimaryBlackColor,
                          width: 1,
                        ),
                      ),
                    ),
                    value: dropdownvalue,
                    isExpanded: true,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.r),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.sp,
                        color: AppColors.PrimaryMainColor,
                      ),
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.r),
                          child: Text(items),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        isSelected = true;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("Upload 10th Marks",
                    style: FieldTextStyle(
                      AppColors.PrimaryBlackColor,
                    )),
                Container(
                  height: 50.h,
                  width: 480.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: DropdownButtonFormField(
                    style: TextStyle(
                        color: AppColors.PrimaryMainColor,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: AppColors.PrimaryGreyColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                          color: AppColors.PrimaryBlackColor,
                          width: 1,
                        ),
                      ),
                    ),
                    value: dropdownvalue,
                    isExpanded: true,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.r),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.sp,
                        color: AppColors.PrimaryMainColor,
                      ),
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.r),
                          child: Text(items),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        isSelected = true;
                      });
                    },
                  ),
                ),
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
                          border: Border.all(color: AppColors.PrimaryGreyColor),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: (file == null)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 20.r, right: 0),
                                    child: Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.end,
                                        children: [
                                          Text("Upload File"),
                                          Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10.r),
                                                  width: 220.w,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 1,
                                                        color: AppColors
                                                            .PrimaryGreyColor,
                                                      ),
                                                      Container(
                                                        height: 50.h,
                                                        width: 100.w,
                                                        decoration: BoxDecoration(
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
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(Icons
                                                                .attach_file),
                                                            Text(
                                                              "Attach",
                                                              style: btntext(
                                                                  AppColors
                                                                      .PrimaryBlackColor),
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
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 20.r, right: 0),
                                    child: (file!.extension == "pdf")
                                        ? Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.end,
                                            children: [
                                                const Icon(
                                                  Icons.picture_as_pdf,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(file!.path!
                                                    .split('/')
                                                    .last),
                                              ])
                                        : Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/docx.png",
                                                height: 20.h,
                                              ),
                                              Center(
                                                  child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 10.r),
                                                width: 250.w,
                                                child: Text(file!.path!
                                                    .split('/')
                                                    .last),
                                              )),
                                            ],
                                          )),
                              ],
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
              padding: EdgeInsets.only(bottom: 15.r, left: 15.r, right: 15.r),
              child: ButtonPrimary(
                title: "Submit",
                onPressed: () {
                  if (_registerkey.currentState!.validate()) {
                    // use the email provided here
                  }
                },
              ),
            )),
      ),
    );
  }

  void selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['docx', 'pdf'],
    );

    if (result == null) return;

    file = result.files.first;

    setState(() {});
  }
}
