import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/visamodelget.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/button.dart';
import 'package:global_student/view/widget/loader.dart';
import '../../model/visaresponseModel.dart';
import '../../utils/routes/routes_name.dart';

class VisaPage extends StatefulWidget {
  const VisaPage({super.key});

  @override
  State<VisaPage> createState() => _VisaPageState();
}

class _VisaPageState extends State<VisaPage> {
  String? dropdownvalue;
  String selectedvalue = "";
  int selectedIndex = -1;
  var data2 = Get.arguments;
  var items = [
    'SDS',
    'Non-SDS',
  ];
  bool isSelected = false;
  File? file;
  File? acdamicfile;
  File? workfile;
  File? fundsfile;
  File? financialfile;
  File? sponsorfile;
  File? alldocumentfile;

  bool loanding = true;
  late DashBoardBloc dashBoardBloc;
  List<AcademicDocument> allDocuments = [];
  List<AcademicDocument> academicDocuments = [];
  List<AcademicDocument> workExperience = [];
  List<AcademicDocument> fundsDocuments = [];
  List<AcademicDocument> financialDocuments = [];
  List<AcademicDocument> sponsorDocuments = [];

  List<String> requiredDocuments = [];
  // List<AcademicDocument> academicDoc = [];
  List batchData = [];
  List<String> selectedFiles = [];
  List<String> selectedItems = [];
  List<String> selectedWork = [];
  List<String> selectedFunds = [];
  List<String> selectedFinancial = [];
  List<String> selectedSponsor = [];

  bool? adcamibloading;

  bool? workloading;
  bool? fundsDocumentsloading;
  bool? financialDocumentsloading;
  bool? sponsorDocumentsloading;

  int basichit = 0;
  List cart = [];

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getBranchDetails();
    datacanada();
    Subimmeted();
    getfinnalvisasubmit();

    // callfinalVisa();

    // _gethomeData();
    super.initState();
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
          print("++++$file");
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
      //print(e);
    }
  }

  void selectWorkFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['pdf', 'docx'],
        type: FileType.custom,
      );

      if (result != null) {
        setState(() {
          workfile = File(result.files.single.path!);
          print("++++$workfile");
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
      //print(e);
    }
  }

  void selectfundsFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['pdf', 'docx'],
        type: FileType.custom,
      );

      if (result != null) {
        setState(() {
          fundsfile = File(result.files.single.path!);
          print("++++$fundsfile");
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
      //print(e);
    }
  }

  void selectFincialFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['pdf', 'docx'],
        type: FileType.custom,
      );

      if (result != null) {
        setState(() {
          financialfile = File(result.files.single.path!);
          print("++++$financialfile");
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
      //print(e);
    }
  }

  void selectSponsorFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['pdf', 'docx'],
        type: FileType.custom,
      );

      if (result != null) {
        setState(() {
          sponsorfile = File(result.files.single.path!);
          print("++++$sponsorfile");
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
      //print(e);
    }
  }

  void selectAlldocumenntFiles(int index) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['pdf', 'docx'],
        type: FileType.custom,
      );

      if (result != null) {
        setState(() {
          alldocumentfile = File(result.files.single.path!);
          selectedIndex = index;
          print("++++$alldocumentfile");
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
      //print(e);
    }
  }

  getBranchDetails() async {
    dashBoardBloc.getvisadetailscontrollerStream.listen((event) {
      // debugger();
      // print(event);
      if (event != null) {
        VisaGetModel visaGetModel = VisaGetModel.fromJson(event);
        allDocuments.addAll(visaGetModel.allDocuments);
        workExperience.addAll(visaGetModel.workExperience);
        academicDocuments.addAll(visaGetModel.academicDocuments);
        fundsDocuments.addAll(visaGetModel.fundsDocuments);
        financialDocuments.addAll(visaGetModel.financialDocuments);
        sponsorDocuments.addAll(visaGetModel.sponsorDocuments);

        setState(() {
          loanding = false;
        });
      }
    });
  }

  int count = 0;

  datacanada() {
    if ("3" == "3") {
      _gethomeData();
    } else {
      _gethomeDataoyher();
    }
  }

  datacanadasds() {
    if (basichit == 0) {
      callfinalVisa();
    } else {
      callfinalCanadsVisa();
    }
  }

  void Subimmeted() async {
    await dashBoardBloc.uploadviscontrollerStream.listen((event) {
      Navigator.pop(context);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);
      // debugger();
      // print(event);
      if (response == true && event.data["Status"] == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Document Submmited Succesfully"),
        ));
        setState(() {
          alldocumentfile = null;
          basichit = 1;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(milliseconds: 1000),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 80,
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
      }
    });
  }

  int countBoolList(List boolList) {
    int count = 0;
    for (int i = 0; i < boolList.length; i++) {
      if (boolList.elementAt(i) == true) {
        count++;
      }
    }
    return count;
  }

  _gethomeData() {
    Map<String, dynamic> visadata = {
      "f_countryid": "3",
      "f_CountryStream": selectedvalue,
    };
    dashBoardBloc.callGetvisadetails(visadata);
  }

  _gethomeDataoyher() {
    Map<String, dynamic> visadata = {
      "f_countryid": "2",
      "f_CountryStream": "",
    };

    dashBoardBloc.callGetvisadetails(visadata);
  }

  void calluploadVisa(String documentid, File? filedata) {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    // String spselcected = selectedItems.join(",");
    Map data = {
      "studentid": data2[4].toString(),
      "CourseId": data2[3].toString(),
      "CountryId": data2[0].toString(),
      "DocumentId": documentid.toString(),
      "IsStarted": basichit.toString(),
    };
    // debugger();
    // print(data);
    dashBoardBloc.VisaUploadApi(
      data,
      filedata!,
    );
  }

  void callfinalVisa() {
    // NetworkDialog.showLoadingDialog(context, _keyLoader);
    // String spselcected = selectedItems.join(",");
    Map<String, dynamic> finalvisa = {
      "CourseId": data2[3].toString(),
      "CountryId": data2[0].toString(),
      "CountryStream": ""
    };
    debugger();
    print(finalvisa);
    dashBoardBloc.callFianlvisasubmit(finalvisa);
  }

  void callfinalCanadsVisa() {
    // NetworkDialog.showLoadingDialog(context, _keyLoader);
    // String spselcected = selectedItems.join(",");
    Map<String, dynamic> finalvisa = {
      "CourseId": data2[3].toString(),
      "CountryId": data2[0].toString(),
      "CountryStream": selectedvalue.toString(),
    };

    // debugger();
    // print(finalvisa);
    dashBoardBloc.callFianlvisasubmit(finalvisa);
  }

  getfinnalvisasubmit() async {
    await dashBoardBloc.finalvisasubmitcontrollerStream.listen((event) {
      //  showloader ? Navigator.pop(context) : "";
      // debugger();
      // print(event.data);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true) {
        VisaresponseModel visaGetModel = VisaresponseModel.fromJson(event.data);
        requiredDocuments.clear();
        setState(() {
          requiredDocuments.addAll(visaGetModel.requiredDocuments);
        });
      }

      //   bool response =
      //     ApiResponseHelper().handleResponse(event: event, context: context);

      // if (event != null) {}
    });
  }

  // void calluploadVisawork() {
  //   // NetworkDialog.showLoadingDialog(context, _keyLoader);
  //   String spselcectedwork = selectedWork.join(",");
  //   Map data = {
  //     "studentid": data2[4].toString(),
  //     "CourseId": data2[3].toString(),
  //     "CountryId": data2[0].toString(),
  //     "DocumentId": spselcectedwork.toString(),
  //     "IsStarted": basichit.toString(),
  //   };
  //   debugger();
  //   print(data);
  //   dashBoardBloc.VisaUploadApi(
  //     data,
  //     file!,
  //   );
  // }
//  _requirementList[6].isSelected
//           ? "1"
//           : _requirementList[8].isSelected
//               ? "0"
//               : "",
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Apply Visa",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.bottomnav);
          },
        ),
      ),
      body: loanding
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.PrimaryMainColor,
              strokeWidth: 3.w,
            ))
          : SingleChildScrollView(
              child: data2[2] == "0"
                  ? Text("Not Applicable")
                  : data2[2] == "1"
                      ? Padding(
                          padding: EdgeInsets.all(15.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data2[2].toString()),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text("State",
                                  //     style: FieldTextStyle(
                                  //       AppColors.PrimaryBlackColor,
                                  //     )),
                                  // data2[0] == "3"
                                  //     ?
                                  Container(
                                      height: 50.h,
                                      width: 160.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: AppColors.PrimaryWhiteColor),
                                      child: Center(
                                          child: Text(
                                        data2[1].toString(),
                                        style: FieldTextStyle(
                                            AppColors.PrimaryMainColor),
                                      ))),
                                  // :
                                  //  Container(
                                  //     height: 50.h,
                                  //     width: 330.w,
                                  //     decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(10.r),
                                  //         color: AppColors.PrimaryWhiteColor),
                                  //     child: Center(
                                  //         child: Text(
                                  //       data2[1].toString(),
                                  //       style: FieldTextStyle(
                                  //           AppColors.PrimaryMainColor),
                                  //     ))),

                                  // data2[0] == "3"
                                  //     ?
                                  Container(
                                    height: 50.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: AppColors.PrimaryWhiteColor),
                                    child: DropdownButtonFormField(
                                      hint: Text(
                                        "Select",
                                        style: batchtext2(AppColors.hintcolor),
                                      ),
                                      style: const TextStyle(
                                          color: AppColors.PrimaryMainColor,
                                          fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                              color: AppColors.PrimaryGreyColor,
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                            color: AppColors.PrimaryBlackColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      value: dropdownvalue,
                                      isExpanded: true,
                                      icon: Padding(
                                        padding: EdgeInsets.only(
                                          right: 10.r,
                                        ),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 25.sp,
                                          color: AppColors.PrimaryMainColor,
                                        ),
                                      ),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.r),
                                            child: Text(items),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedvalue = newValue!;
                                          isSelected = true;
                                          allDocuments.clear();
                                          academicDocuments.clear();
                                          workExperience.clear();
                                          fundsDocuments.clear();
                                          financialDocuments.clear();
                                          sponsorDocuments.clear();
                                          _gethomeData();
                                          // callfinalCanadsVisa();
                                          // selected(dropdownvalue);
                                        });
                                      },
                                    ),
                                  )
                                  // : Container(),
                                ],
                              ),
                              // Text(data2[1].toString()),

                              academicDocuments.isEmpty
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                " All Academic Documents",
                                                style: batchtext2(
                                                  AppColors.PrimaryMainColor,
                                                )),
                                          ),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Text(
                                                'Please Select Academic Documents',
                                                style: batchtext2(
                                                    AppColors.hintcolor),
                                              ),
                                              items:
                                                  academicDocuments.map((item) {
                                                return DropdownMenuItem<String>(
                                                  value: item
                                                      .fVisaFileRequiredDocumentId,
                                                  //disable default onTap to avoid closing menu when selecting an item
                                                  enabled: false,
                                                  child: StatefulBuilder(
                                                    builder: (context,
                                                        menuSetState) {
                                                      final _isSelected =
                                                          selectedItems
                                                              .contains(item
                                                                  .fVisaFileRequiredDocumentId);
                                                      return InkWell(
                                                        onTap: () {
                                                          _isSelected
                                                              ? selectedItems
                                                                  .remove(item
                                                                      .fVisaFileRequiredDocumentId)
                                                              : selectedItems
                                                                  .add(item
                                                                      .fVisaFileRequiredDocumentId);
                                                          print(selectedItems);
                                                          //This rebuilds the StatefulWidget to update the button's text
                                                          setState(() {
                                                            //  bool sum = item.fIsRequired;
                                                          });

                                                          // countryid();
                                                          //This rebuilds the dropdownMenu Widget to update the check mark
                                                          menuSetState(() {
                                                            // print(selectedItems);
                                                          });
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
                                                              _isSelected
                                                                  ? Icon(
                                                                      Icons
                                                                          .check_box_outlined,
                                                                      color: AppColors
                                                                          .PrimaryMainColor,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .check_box_outline_blank,
                                                                      color: AppColors
                                                                          .PrimaryMainColor,
                                                                    ),
                                                              const SizedBox(
                                                                  width: 16),
                                                              item.fIsRequired
                                                                  ? Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.fDocumentName +
                                                                            " *",
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
                                                                      ),
                                                                    )
                                                                  : Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.fDocumentName,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
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
                                              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                              value: selectedItems.isEmpty
                                                  ? null
                                                  : selectedItems.last,
                                              onChanged: (value) {
                                                selectedItems.last = value!;

                                                setState(() {
                                                  log("fekwjqnbkjernb;j$selectedItems");
                                                });
                                              },
                                              selectedItemBuilder: (context) {
                                                return academicDocuments.map(
                                                  (item) {
                                                    return Container(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16.0),
                                                      child: Text(
                                                        "Selected ${selectedItems.length}",
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                        maxLines: 1,
                                                      ),
                                                    );
                                                  },
                                                ).toList();
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 55,
                                                width: 450,
                                                padding:
                                                    const EdgeInsets.all(10),
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                      isOverButton: true,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.sp),
                                                          color: AppColors
                                                              .PrimaryWhiteColor,
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
                                                  color: AppColors
                                                      .PrimaryMainColor,
                                                ),
                                                iconSize: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  selectFiles();
                                                },
                                                child: Container(
                                                    height: 50,
                                                    width: 220,
                                                    //  margin: EdgeInsets.all(10),
                                                    //padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        border: Border.all()),
                                                    child: file == null
                                                        ? Center(
                                                            child: Text(
                                                              "Plese select file",
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .hintcolor),
                                                            ),
                                                          )
                                                        : Center(
                                                            child: Text(file!
                                                                .path
                                                                .split("/")
                                                                .last
                                                                .toString()),
                                                          )),
                                              ),
                                              adcamibloading == false
                                                  ? Container(
                                                      width: 80,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          border: Border.all()),
                                                      child: ElevatedButton(
                                                        child:
                                                            Icon(Icons.check),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                shape:
                                                                    LinearBorder(),
                                                                side:
                                                                    BorderSide(),
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                elevation: 3),
                                                        onPressed: () {
                                                          // print(countBoolList(
                                                          //     academicDocuments[i]
                                                          //         .fIsRequired ));
                                                        },
                                                      ),
                                                    )
                                                  : Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                border: Border
                                                                    .all()),
                                                        width: 80,
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          child: Text('Upload'),
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  LinearBorder(),
                                                              side:
                                                                  BorderSide(),
                                                              backgroundColor:
                                                                  AppColors
                                                                      .PrimaryMainColor,
                                                              elevation: 3),
                                                          onPressed: () {
                                                            String spselcected =
                                                                selectedItems
                                                                    .join(",");

                                                            // print(countBoolList(
                                                            //     academicDocuments[i]
                                                            //         .fIsRequired ));
                                                            // print(len);
                                                            if (selectedItems
                                                                    .isEmpty ||
                                                                file == null) {
                                                              //  print(academicDocuments[i]
                                                              // .fIsRequired);

                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                content: Text(
                                                                  "Please Select Document",
                                                                  style: batchtext2(
                                                                      AppColors
                                                                          .PrimaryWhiteColor),
                                                                ),
                                                              ));
                                                            } else {
                                                              setState(() {
                                                                adcamibloading =
                                                                    false;
                                                                // callfinalCanadsVisa();
                                                              });
                                                              calluploadVisa(
                                                                  spselcected,
                                                                  file);
                                                            }

                                                            print("hrllo");
                                                          },
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                              workExperience.isEmpty
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("All Work Experience",
                                                style: batchtext2(
                                                  AppColors.PrimaryMainColor,
                                                )),
                                          ),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Text(
                                                'Please Select Work Experience',
                                                style: batchtext2(
                                                    AppColors.hintcolor),
                                              ),
                                              items: workExperience.map((item) {
                                                return DropdownMenuItem<String>(
                                                  value: item
                                                      .fVisaFileRequiredDocumentId,
                                                  //disable default onTap to avoid closing menu when selecting an item
                                                  enabled: false,
                                                  child: StatefulBuilder(
                                                    builder: (context,
                                                        menuSetState) {
                                                      final _isSelected =
                                                          selectedWork.contains(
                                                              item.fVisaFileRequiredDocumentId);
                                                      return InkWell(
                                                        onTap: () {
                                                          _isSelected
                                                              ? selectedWork
                                                                  .remove(item
                                                                      .fVisaFileRequiredDocumentId)
                                                              : selectedWork
                                                                  .add(item
                                                                      .fVisaFileRequiredDocumentId);
                                                          //This rebuilds the StatefulWidget to update the button's text
                                                          setState(() {});

                                                          // countryid();
                                                          //This rebuilds the dropdownMenu Widget to update the check mark
                                                          menuSetState(() {
                                                            // print(selectedItems);
                                                          });
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
                                                              _isSelected
                                                                  ? Icon(
                                                                      Icons
                                                                          .check_box_outlined,
                                                                      color: AppColors
                                                                          .PrimaryMainColor,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .check_box_outline_blank,
                                                                      color: AppColors
                                                                          .PrimaryMainColor,
                                                                    ),
                                                              const SizedBox(
                                                                  width: 16),
                                                              item.fIsRequired
                                                                  ? Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.fDocumentName +
                                                                            " *",
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
                                                                      ),
                                                                    )
                                                                  : Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.fDocumentName,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
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
                                              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                              value: selectedWork.isEmpty
                                                  ? null
                                                  : selectedWork.last,
                                              onChanged: (value) {
                                                selectedWork.last = value!;

                                                setState(() {
                                                  log("fekwjqnbkjernb;j" +
                                                      selectedWork.toString());
                                                });
                                              },
                                              selectedItemBuilder: (context) {
                                                return workExperience.map(
                                                  (item) {
                                                    return Container(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16.0),
                                                      child: Text(
                                                        "Selected " +
                                                            selectedWork.length
                                                                .toString(),
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                        maxLines: 1,
                                                      ),
                                                    );
                                                  },
                                                ).toList();
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 55,
                                                width: 450,
                                                padding:
                                                    const EdgeInsets.all(10),
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                      isOverButton: true,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.sp),
                                                          color: AppColors
                                                              .PrimaryWhiteColor,
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
                                                  color: AppColors
                                                      .PrimaryMainColor,
                                                ),
                                                iconSize: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  selectWorkFiles();
                                                },
                                                child: Container(
                                                    height: 50,
                                                    width: 220,
                                                    //  margin: EdgeInsets.all(10),
                                                    //padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        border: Border.all()),
                                                    child: workfile == null
                                                        ? Center(
                                                            child: Text(
                                                              "Plese select file",
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .hintcolor),
                                                            ),
                                                          )
                                                        : Center(
                                                            child: Text(workfile!
                                                                .path
                                                                .split("/")
                                                                .last
                                                                .toString()),
                                                          )),
                                              ),
                                              workloading == false
                                                  ? Container(
                                                      width: 80,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          border: Border.all()),
                                                      child: ElevatedButton(
                                                        child:
                                                            Icon(Icons.check),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                shape:
                                                                    LinearBorder(),
                                                                side:
                                                                    BorderSide(),
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                elevation: 3),
                                                        onPressed: () {
                                                          // print(countBoolList(
                                                          //     academicDocuments[i]
                                                          //         .fIsRequired ));
                                                        },
                                                      ),
                                                    )
                                                  : Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                border: Border
                                                                    .all()),
                                                        width: 80,
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          child: Text('Upload'),
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  LinearBorder(),
                                                              side:
                                                                  BorderSide(),
                                                              backgroundColor:
                                                                  AppColors
                                                                      .PrimaryMainColor,
                                                              elevation: 3),
                                                          onPressed: () {
                                                            if (selectedWork
                                                                    .isEmpty ||
                                                                workfile ==
                                                                    null) {
                                                              //  print(academicDocuments[i]
                                                              // .fIsRequired);

                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                content: Text(
                                                                  "Please Select Document",
                                                                  style: batchtext2(
                                                                      AppColors
                                                                          .PrimaryWhiteColor),
                                                                ),
                                                              ));
                                                            } else {
                                                              setState(() {
                                                                workloading =
                                                                    false;
                                                              });
                                                              String
                                                                  spselcectedwork =
                                                                  selectedWork
                                                                      .join(
                                                                          ",");
                                                              calluploadVisa(
                                                                  spselcectedwork,
                                                                  workfile);
                                                              callfinalCanadsVisa();
                                                            }

                                                            print("hello: ");
                                                          },
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                              fundsDocuments.isEmpty
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("All Funds Documents",
                                                style: batchtext2(
                                                  AppColors.PrimaryMainColor,
                                                )),
                                          ),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Text(
                                                'Please Select Funds Documents',
                                                style: batchtext2(
                                                    AppColors.hintcolor),
                                              ),
                                              items: fundsDocuments.map((item) {
                                                return DropdownMenuItem<String>(
                                                  value: item
                                                      .fVisaFileRequiredDocumentId,
                                                  //disable default onTap to avoid closing menu when selecting an item
                                                  enabled: false,
                                                  child: StatefulBuilder(
                                                    builder: (context,
                                                        menuSetState) {
                                                      final _isSelected =
                                                          selectedFunds
                                                              .contains(item
                                                                  .fVisaFileRequiredDocumentId);
                                                      return InkWell(
                                                        onTap: () {
                                                          _isSelected
                                                              ? selectedFunds
                                                                  .remove(item
                                                                      .fVisaFileRequiredDocumentId)
                                                              : selectedFunds
                                                                  .add(item
                                                                      .fVisaFileRequiredDocumentId);
                                                          //This rebuilds the StatefulWidget to update the button's text
                                                          setState(() {});

                                                          // countryid();
                                                          //This rebuilds the dropdownMenu Widget to update the check mark
                                                          menuSetState(() {
                                                            // print(selectedItems);
                                                          });
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
                                                              _isSelected
                                                                  ? Icon(
                                                                      Icons
                                                                          .check_box_outlined,
                                                                      color: AppColors
                                                                          .PrimaryMainColor,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .check_box_outline_blank,
                                                                      color: AppColors
                                                                          .PrimaryMainColor,
                                                                    ),
                                                              const SizedBox(
                                                                  width: 16),
                                                              item.fIsRequired
                                                                  ? Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.fDocumentName +
                                                                            " *",
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
                                                                      ),
                                                                    )
                                                                  : Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.fDocumentName,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
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
                                              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                              value: selectedFunds.isEmpty
                                                  ? null
                                                  : selectedFunds.last,
                                              onChanged: (value) {
                                                selectedFunds.last = value!;

                                                setState(() {
                                                  log("fekwjqnbkjernb;j" +
                                                      selectedFunds.toString());
                                                });
                                              },
                                              selectedItemBuilder: (context) {
                                                return fundsDocuments.map(
                                                  (item) {
                                                    return Container(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16.0),
                                                      child: Text(
                                                        "Selected " +
                                                            selectedFunds.length
                                                                .toString(),
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                        maxLines: 1,
                                                      ),
                                                    );
                                                  },
                                                ).toList();
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 55,
                                                width: 450,
                                                padding:
                                                    const EdgeInsets.all(10),
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                      isOverButton: true,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.sp),
                                                          color: AppColors
                                                              .PrimaryWhiteColor,
                                                          border: Border.all()),
                                                      maxHeight: 200.h,
                                                      elevation: 10),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                height: 90,
                                              ),
                                              iconStyleData: IconStyleData(
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: AppColors
                                                      .PrimaryMainColor,
                                                ),
                                                iconSize: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  selectfundsFiles();
                                                },
                                                child: Container(
                                                    height: 50,
                                                    width: 220,
                                                    //  margin: EdgeInsets.all(10),
                                                    //padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        border: Border.all()),
                                                    child: fundsfile == null
                                                        ? Center(
                                                            child: Text(
                                                            "Please select file",
                                                            style: batchtext2(
                                                                AppColors
                                                                    .hintcolor),
                                                          ))
                                                        : Center(
                                                            child: Text(
                                                                fundsfile!.path
                                                                    .split("/")
                                                                    .last
                                                                    .toString()),
                                                          )),
                                              ),
                                              fundsDocumentsloading == false
                                                  ? Container(
                                                      width: 80,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          border: Border.all()),
                                                      child: ElevatedButton(
                                                        child:
                                                            Icon(Icons.check),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                shape:
                                                                    LinearBorder(),
                                                                side:
                                                                    BorderSide(),
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                elevation: 3),
                                                        onPressed: () {
                                                          // print(countBoolList(
                                                          //     academicDocuments[i]
                                                          //         .fIsRequired ));
                                                        },
                                                      ),
                                                    )
                                                  : Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                border: Border
                                                                    .all()),
                                                        width: 80,
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          child: Text('Upload'),
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  LinearBorder(),
                                                              side:
                                                                  BorderSide(),
                                                              backgroundColor:
                                                                  AppColors
                                                                      .PrimaryMainColor,
                                                              elevation: 3),
                                                          onPressed: () {
                                                            String
                                                                spselcectfund =
                                                                selectedFunds
                                                                    .join(",");

                                                            if (selectedFunds
                                                                    .isEmpty ||
                                                                fundsfile ==
                                                                    null) {
                                                              //  print(academicDocuments[i]
                                                              // .fIsRequired);

                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                content: Text(
                                                                  "Please Select Document",
                                                                  style: batchtext2(
                                                                      AppColors
                                                                          .PrimaryWhiteColor),
                                                                ),
                                                              ));
                                                            } else {
                                                              setState(() {
                                                                fundsDocumentsloading =
                                                                    false;
                                                              });
                                                              calluploadVisa(
                                                                  spselcectfund,
                                                                  fundsfile!);
                                                              callfinalCanadsVisa();
                                                            }

                                                            print("hello: ");
                                                          },
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                              financialDocuments.isEmpty
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                " All financial Documents",
                                                style: batchtext2(
                                                  AppColors.PrimaryMainColor,
                                                )),
                                          ),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Text(
                                                'Please Select financial Documents',
                                                style: batchtext2(
                                                    AppColors.hintcolor),
                                              ),
                                              items: financialDocuments
                                                  .map((item) {
                                                return DropdownMenuItem<String>(
                                                  value: item
                                                      .fVisaFileRequiredDocumentId,
                                                  //disable default onTap to avoid closing menu when selecting an item
                                                  enabled: false,
                                                  child: StatefulBuilder(
                                                    builder: (context,
                                                        menuSetState) {
                                                      final _isSelected =
                                                          selectedFinancial
                                                              .contains(item
                                                                  .fVisaFileRequiredDocumentId);
                                                      return InkWell(
                                                        onTap: () {
                                                          _isSelected
                                                              ? selectedFinancial
                                                                  .remove(item
                                                                      .fVisaFileRequiredDocumentId)
                                                              : selectedFinancial
                                                                  .add(item
                                                                      .fVisaFileRequiredDocumentId);
                                                          //This rebuilds the StatefulWidget to update the button's text
                                                          setState(() {});

                                                          // countryid();
                                                          //This rebuilds the dropdownMenu Widget to update the check mark
                                                          menuSetState(() {
                                                            // print(selectedItems);
                                                          });
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
                                                              _isSelected
                                                                  ? Icon(
                                                                      Icons
                                                                          .check_box_outlined,
                                                                      color: AppColors
                                                                          .PrimaryMainColor,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .check_box_outline_blank,
                                                                      color: AppColors
                                                                          .PrimaryMainColor,
                                                                    ),
                                                              const SizedBox(
                                                                  width: 16),
                                                              item.fIsRequired
                                                                  ? Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.fDocumentName,
                                                                        maxLines:
                                                                            3,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
                                                                      ),
                                                                    )
                                                                  : Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.fDocumentName,
                                                                        maxLines:
                                                                            3,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
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
                                              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                              value: selectedFinancial.isEmpty
                                                  ? null
                                                  : selectedFinancial.last,
                                              onChanged: (value) {
                                                selectedFinancial.last = value!;

                                                setState(() {
                                                  log("fekwjqnbkjernb;j" +
                                                      selectedFinancial
                                                          .toString());
                                                });
                                              },
                                              selectedItemBuilder: (context) {
                                                return financialDocuments.map(
                                                  (item) {
                                                    return Container(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16.0),
                                                      child: Text(
                                                        "Selected " +
                                                            selectedFinancial
                                                                .length
                                                                .toString(),
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                        maxLines: 1,
                                                      ),
                                                    );
                                                  },
                                                ).toList();
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 55,
                                                width: 450,
                                                padding:
                                                    const EdgeInsets.all(10),
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                      isOverButton: true,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.sp),
                                                          color: AppColors
                                                              .PrimaryWhiteColor,
                                                          border: Border.all()),
                                                      maxHeight: 200.h,
                                                      elevation: 10),
                                              menuItemStyleData:
                                                  MenuItemStyleData(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                height: 45.h,
                                              ),
                                              iconStyleData: IconStyleData(
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: AppColors
                                                      .PrimaryMainColor,
                                                ),
                                                iconSize: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  selectFincialFiles();
                                                },
                                                child: Container(
                                                    height: 50,
                                                    width: 220,
                                                    //  margin: EdgeInsets.all(10),
                                                    //padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        border: Border.all()),
                                                    child: financialfile == null
                                                        ? Center(
                                                            child: Text(
                                                            "Please select file",
                                                            style: batchtext2(
                                                                AppColors
                                                                    .hintcolor),
                                                          ))
                                                        : Center(
                                                            child: Text(
                                                                financialfile!
                                                                    .path
                                                                    .split("/")
                                                                    .last
                                                                    .toString()),
                                                          )),
                                              ),
                                              financialDocumentsloading == false
                                                  ? Container(
                                                      width: 80,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          border: Border.all()),
                                                      child: ElevatedButton(
                                                        child:
                                                            Icon(Icons.check),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                shape:
                                                                    LinearBorder(),
                                                                side:
                                                                    BorderSide(),
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                elevation: 3),
                                                        onPressed: () {
                                                          // print(countBoolList(
                                                          //     academicDocuments[i]
                                                          //         .fIsRequired ));
                                                        },
                                                      ),
                                                    )
                                                  : Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                border: Border
                                                                    .all()),
                                                        width: 80,
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          child: Text('Upload'),
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  LinearBorder(),
                                                              side:
                                                                  BorderSide(),
                                                              backgroundColor:
                                                                  AppColors
                                                                      .PrimaryMainColor,
                                                              elevation: 3),
                                                          onPressed: () {
                                                            String
                                                                spselcectfincial =
                                                                selectedFinancial
                                                                    .join(",");

                                                            if (selectedFinancial
                                                                    .isEmpty ||
                                                                financialfile ==
                                                                    null) {
                                                              //  print(academicDocuments[i]
                                                              // .fIsRequired);

                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                content: Text(
                                                                  "Please Select Document",
                                                                  style: batchtext2(
                                                                      AppColors
                                                                          .PrimaryWhiteColor),
                                                                ),
                                                              ));
                                                            } else {
                                                              setState(() {
                                                                financialDocumentsloading =
                                                                    false;
                                                              });
                                                              calluploadVisa(
                                                                  spselcectfincial,
                                                                  financialfile!);
                                                              callfinalCanadsVisa();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                              sponsorDocuments.isEmpty
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                " All Sponsor Documents",
                                                style: batchtext2(
                                                  AppColors.PrimaryMainColor,
                                                )),
                                          ),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Text(
                                                'Please Select Sponsor Documents',
                                                style: batchtext2(
                                                    AppColors.hintcolor),
                                              ),
                                              items:
                                                  sponsorDocuments.map((item) {
                                                return DropdownMenuItem<String>(
                                                  value: item
                                                      .fVisaFileRequiredDocumentId,
                                                  //disable default onTap to avoid closing menu when selecting an item
                                                  enabled: false,
                                                  child: StatefulBuilder(
                                                    builder: (context,
                                                        menuSetState) {
                                                      final _isSelected =
                                                          selectedSponsor
                                                              .contains(item
                                                                  .fVisaFileRequiredDocumentId);
                                                      return InkWell(
                                                        onTap: () {
                                                          _isSelected
                                                              ? selectedSponsor
                                                                  .remove(item
                                                                      .fVisaFileRequiredDocumentId)
                                                              : selectedSponsor
                                                                  .add(item
                                                                      .fVisaFileRequiredDocumentId);
                                                          //This rebuilds the StatefulWidget to update the button's text
                                                          setState(() {});

                                                          // countryid();
                                                          //This rebuilds the dropdownMenu Widget to update the check mark
                                                          menuSetState(() {
                                                            // print(selectedItems);
                                                          });
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
                                                              _isSelected
                                                                  ? Icon(
                                                                      Icons
                                                                          .check_box_outlined,
                                                                      color: AppColors
                                                                          .PrimaryMainColor,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .check_box_outline_blank,
                                                                      color: AppColors
                                                                          .PrimaryMainColor,
                                                                    ),
                                                              const SizedBox(
                                                                  width: 16),
                                                              item.fIsRequired
                                                                  ? Flexible(
                                                                      child:
                                                                          Text(
                                                                        "${item.fDocumentName} *",
                                                                        maxLines:
                                                                            3,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
                                                                      ),
                                                                    )
                                                                  : Flexible(
                                                                      child:
                                                                          Text(
                                                                        item.fDocumentName,
                                                                        maxLines:
                                                                            3,
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryMainColor),
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
                                              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                              value: selectedSponsor.isEmpty
                                                  ? null
                                                  : selectedSponsor.last,
                                              onChanged: (value) {
                                                selectedSponsor.last = value!;

                                                setState(() {
                                                  log("fekwjqnbkjernb;j" +
                                                      selectedFinancial
                                                          .toString());
                                                });
                                              },
                                              selectedItemBuilder: (context) {
                                                return sponsorDocuments.map(
                                                  (item) {
                                                    return Container(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16.0),
                                                      child: Text(
                                                        "Selected " +
                                                            selectedSponsor
                                                                .length
                                                                .toString(),
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                        maxLines: 1,
                                                      ),
                                                    );
                                                  },
                                                ).toList();
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 55,
                                                width: 450,
                                                padding:
                                                    const EdgeInsets.all(10),
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                      isOverButton: true,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.sp),
                                                          color: AppColors
                                                              .PrimaryWhiteColor,
                                                          border: Border.all()),
                                                      maxHeight: 200.h,
                                                      elevation: 10),
                                              menuItemStyleData:
                                                  MenuItemStyleData(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                height: 45.h,
                                              ),
                                              iconStyleData: IconStyleData(
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: AppColors
                                                      .PrimaryMainColor,
                                                ),
                                                iconSize: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  selectSponsorFiles();
                                                },
                                                child: Container(
                                                    height: 50,
                                                    width: 220,
                                                    //  margin: EdgeInsets.all(10),
                                                    //padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        border: Border.all()),
                                                    child: sponsorfile == null
                                                        ? Center(
                                                            child: Text(
                                                            "Please select file",
                                                            style: batchtext2(
                                                                AppColors
                                                                    .hintcolor),
                                                          ))
                                                        : Center(
                                                            child: Text(
                                                                sponsorfile!
                                                                    .path
                                                                    .split("/")
                                                                    .last
                                                                    .toString()),
                                                          )),
                                              ),
                                              sponsorDocumentsloading == false
                                                  ? Container(
                                                      width: 80,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          border: Border.all()),
                                                      child: ElevatedButton(
                                                        child:
                                                            Icon(Icons.check),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                shape:
                                                                    LinearBorder(),
                                                                side:
                                                                    BorderSide(),
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                elevation: 3),
                                                        onPressed: () {
                                                          // print(countBoolList(
                                                          //     academicDocuments[i]
                                                          //         .fIsRequired ));
                                                        },
                                                      ),
                                                    )
                                                  : Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                border: Border
                                                                    .all()),
                                                        width: 80,
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          child: Text('Upload'),
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  LinearBorder(),
                                                              side:
                                                                  BorderSide(),
                                                              backgroundColor:
                                                                  AppColors
                                                                      .PrimaryMainColor,
                                                              elevation: 3),
                                                          onPressed: () {
                                                            String
                                                                spselcectsponser =
                                                                selectedSponsor
                                                                    .join(",");

                                                            if (selectedSponsor
                                                                    .isEmpty ||
                                                                sponsorfile ==
                                                                    null) {
                                                              //  print(academicDocuments[i]
                                                              // .fIsRequired);

                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                content: Text(
                                                                  "Please Select Document",
                                                                  style: batchtext2(
                                                                      AppColors
                                                                          .PrimaryWhiteColor),
                                                                ),
                                                              ));
                                                            } else {
                                                              setState(() {
                                                                sponsorDocumentsloading =
                                                                    false;
                                                              });
                                                              calluploadVisa(
                                                                  spselcectsponser,
                                                                  sponsorfile!);
                                                            }
                                                            callfinalCanadsVisa();
                                                            print("hello: ");
                                                          },
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: allDocuments.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.PrimaryWhiteColor),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            allDocuments[index].fIsRequired ==
                                                    true
                                                ? Text(
                                                    allDocuments[index]
                                                            .fDocumentName +
                                                        " *".toString(),
                                                    style: batchtext2(AppColors
                                                        .PrimaryMainColor),
                                                  )
                                                : Text(
                                                    allDocuments[index]
                                                        .fDocumentName
                                                        .toString(),
                                                    style: batchtext2(AppColors
                                                        .PrimaryMainColor),
                                                  ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    selectAlldocumenntFiles(
                                                        index);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 220,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        border: Border.all()),
                                                    child:
                                                        alldocumentfile == null
                                                            ? Center(
                                                                child: cart.contains(
                                                                        allDocuments[index]
                                                                            .fDocumentName)
                                                                    ? Text(
                                                                        "uploaded succesfully",
                                                                        style: batchtext2(
                                                                            AppColors.PrimaryBlackColor),
                                                                      )
                                                                    : Text(
                                                                        "Plese Select File",
                                                                        style: batchtext2(
                                                                            AppColors.hintcolor)),
                                                              )
                                                            : selectedIndex ==
                                                                    index
                                                                ? Center(
                                                                    child: Text(alldocumentfile!
                                                                        .path
                                                                        .split(
                                                                            "/")
                                                                        .last
                                                                        .toString()),
                                                                  )
                                                                : Text(""),
                                                  ),
                                                ),
                                                cart.contains(
                                                        allDocuments[index]
                                                            .fDocumentName)
                                                    ? Container(
                                                        width: 80,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                border: Border
                                                                    .all()),
                                                        child: ElevatedButton(
                                                          child:
                                                              Icon(Icons.check),
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  LinearBorder(),
                                                              side:
                                                                  BorderSide(),
                                                              backgroundColor:
                                                                  Colors.green,
                                                              elevation: 3),
                                                          onPressed: () {
                                                            // print(countBoolList(
                                                            //     academicDocuments[i]
                                                            //         .fIsRequired ));
                                                          },
                                                        ),
                                                      )
                                                    : Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5),
                                                                  ),
                                                                  border: Border
                                                                      .all()),
                                                          width: 80,
                                                          height: 50,
                                                          child: ElevatedButton(
                                                            child:
                                                                Text('Upload'),
                                                            style: ElevatedButton.styleFrom(
                                                                shape:
                                                                    LinearBorder(),
                                                                side:
                                                                    BorderSide(),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .PrimaryMainColor,
                                                                elevation: 3),
                                                            onPressed: () {
                                                              if (alldocumentfile ==
                                                                  null) {
                                                                //  print(academicDocuments[i]
                                                                // .fIsRequired);

                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  content: Text(
                                                                    "Please Select Document",
                                                                    style: batchtext2(
                                                                        AppColors
                                                                            .PrimaryWhiteColor),
                                                                  ),
                                                                ));
                                                              } else {
                                                                setState(() {
                                                                  alldocumentfile ==
                                                                      "";
                                                                  if (cart.contains(
                                                                      allDocuments[
                                                                              index]
                                                                          .fDocumentName)) {
                                                                    cart.remove(
                                                                        allDocuments[index]
                                                                            .fDocumentName);
                                                                  } else {
                                                                    cart.add(allDocuments[
                                                                            index]
                                                                        .fDocumentName);
                                                                    //temparray.add(sub[index].toString());
                                                                  }
                                                                });
                                                                calluploadVisa(
                                                                    allDocuments[
                                                                            index]
                                                                        .fVisaFileRequiredDocumentId
                                                                        .toString(),
                                                                    alldocumentfile!);
                                                                callfinalCanadsVisa();
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            )
                                          ],
                                        ));
                                  }),

                              // for (int i = 0; i < datavisa.length; i++)
                              //   Post(titled: datavisa[i].fDocumentName)
                              // ListView.builder(
                              //     physics: NeverScrollableScrollPhysics(),
                              //     itemCount: allDocuments.length,
                              //     shrinkWrap: true,
                              //     itemBuilder: (context, index) {
                              //       return Column(
                              //         children: [
                              //           Post(
                              //             titled: allDocuments[index]
                              //                 .fDocumentName
                              //                 .toString(),
                              //             imageUrl: alldocumentfile == null
                              //                 ? ""
                              //                 : alldocumentfile!.path
                              //                     .split("/")
                              //                     .last
                              //                     .toString(),
                              //             selectfile: () {
                              //               print("file");
                              //               // selectSponsorFiles();
                              //               selectAlldocumenntFiles(index);
                              //             },
                              //             removePost: () {
                              //               print("edbljhb;erkj");
                              //               if (alldocumentfile == null) {
                              //                 //  print(academicDocuments[i]
                              //                 // .fIsRequired);

                              //                 ScaffoldMessenger.of(context)
                              //                     .showSnackBar(SnackBar(
                              //                   backgroundColor: Colors.red,
                              //                   content: Text(
                              //                     "Please Select Document",
                              //                     style: batchtext2(
                              //                         AppColors.PrimaryWhiteColor),
                              //                   ),
                              //                 ));
                              //               } else {
                              //                 setState(() {
                              //                   alldocumentfile == "";
                              //                   if (cart.contains(
                              //                       allDocuments[index].fDocumentName)) {
                              //                     cart.remove(
                              //                         allDocuments[index].fDocumentName);
                              //                   } else {
                              //                     cart.add(
                              //                         allDocuments[index].fDocumentName);
                              //                     //temparray.add(sub[index].toString());
                              //                   }
                              //                 });
                              //                 calluploadVisa(
                              //                     allDocuments[index]
                              //                         .fVisaFileRequiredDocumentId
                              //                         .toString(),
                              //                     alldocumentfile!);
                              //               }
                              //             },
                              //           ),
                              //         ],
                              //       );
                              //     }),

                              SizedBox(
                                height: 20.h,
                              ),

                              basichit == 0
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 15.r,
                                          left: 15.r,
                                          right: 15.r),
                                      child: ButtonPrimary(
                                        title: "Submit",
                                        onPressed: () {
                                          // callfinalCanadsVisa();

                                          // calldiagol();
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomDialog(
                                                  countid: data2[0].toString(),
                                                  courseid: data2[3].toString(),
                                                  selectsds:
                                                      selectedvalue.toString());
                                              // Dialog(
                                              //   shape: RoundedRectangleBorder(
                                              //     borderRadius:
                                              //         BorderRadius.circular(16.0),
                                              //   ),
                                              //   child: Container(
                                              //     padding: EdgeInsets.all(16.0),
                                              //     child: Column(
                                              //       crossAxisAlignment:
                                              //           CrossAxisAlignment.start,
                                              //       mainAxisSize: MainAxisSize.min,
                                              //       children: [
                                              //         Text(
                                              //           'Please Upload Required Document *',
                                              //           style: TextStyle(
                                              //               fontSize: 20.0,
                                              //               fontWeight: FontWeight.bold,
                                              //               color: AppColors
                                              //                   .PrimaryMainColor),
                                              //         ),
                                              //         SizedBox(height: 16.0),
                                              //         Container(
                                              //           height: 300,
                                              //           child: ListView.builder(
                                              //               shrinkWrap: true,
                                              //               itemCount:
                                              //                   requiredDocuments.length,
                                              //               itemBuilder:
                                              //                   (context, index) {
                                              //                 return Padding(
                                              //                   padding:
                                              //                       const EdgeInsets.all(
                                              //                           4.0),
                                              //                   child: Text(
                                              //                       "${index + 1} .  " +
                                              //                           requiredDocuments[
                                              //                                   index]
                                              //                               .toString() +
                                              //                           "*",
                                              //                       style: batchtext2(
                                              //                           const Color
                                              //                                   .fromARGB(
                                              //                               255,
                                              //                               224,
                                              //                               105,
                                              //                               96))),
                                              //                 );
                                              //               }),
                                              //         ),

                                              //         // StatefulBuilder(
                                              //         //   builder: (BuildContext context,
                                              //         //       setState) {
                                              //         //     return

                                              //         //   },
                                              //         // ),

                                              //         // for (int i = 0;
                                              //         //     i < requiredDocuments.length;
                                              //         //     i++)
                                              //         //   Padding(
                                              //         //     padding: const EdgeInsets.all(4.0),
                                              //         //     child: Text(
                                              //         //       "${i + 1} .  " +
                                              //         //           requiredDocuments[i]
                                              //         //               .toString() +
                                              //         //           "*",
                                              //         //       style: batchtext2(
                                              //         //           const Color.fromARGB(
                                              //         //               255, 224, 105, 96)),
                                              //         //     ),
                                              //         //   ),
                                              //         SizedBox(height: 16.0),
                                              //         Center(
                                              //           child: ElevatedButton(
                                              //             style: ElevatedButton.styleFrom(
                                              //               backgroundColor: AppColors
                                              //                   .PrimaryMainColor,
                                              //               textStyle: const TextStyle(
                                              //                   color: Colors.white,
                                              //                   fontSize: 10,
                                              //                   fontStyle:
                                              //                       FontStyle.normal),
                                              //             ),
                                              //             child: Text('Close'),
                                              //             onPressed: () {
                                              //               // requiredDocuments.clear();
                                              //               Navigator.of(context).pop();
                                              //             },
                                              //             onFocusChange: (val) {},
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // );
                                            },
                                          );
                                        },
                                      ),
                                    )
                            ],
                          ),
                        )
                      : Center(child: Text("Already Applied"))),
      // bottomNavigationBar: BottomAppBar(
      //     elevation: 0.0,
      //     color: Colors.transparent,
      //     child: Padding(
      //       padding: EdgeInsets.only(bottom: 15.r, left: 15.r, right: 15.r),
      //       child: ButtonPrimary(
      //         title: "Submit",
      //         onPressed: () {},
      //       ),
      //     )),
    );
  }

  // void selectFiles(int index) async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowMultiple: false,
  //       allowedExtensions: ['pdf', 'docx'],
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
}

class Post extends StatefulWidget {
  final int? index;
  final String? titled;
  final String? imageUrl;
  final GestureTapCallback? removePost;
  final Function selectfile;

  const Post(
      {Key? key,
      this.index,
      this.titled,
      this.imageUrl,
      this.removePost,
      required this.selectfile})
      : super(key: key);

//  factory Post.fromDocument(DocumentSnapshot doc) {
//    return Post(
//      title: doc['title'],
//      imageUrl: doc['imageUrl'],
//    );
//  }

  @override
  _PostState createState() => _PostState(
      titled: titled,
      removePost: removePost,
      imageUrl: imageUrl,
      selectfile: selectfile);
}

class _PostState extends State<Post> {
  final int? index;
  final String? titled;
  final String? imageUrl;
  final GestureTapCallback? removePost;
  final Function selectfile;
  _PostState(
      {this.index,
      this.titled,
      this.imageUrl,
      this.removePost,
      required this.selectfile});
  List<String> selectedFiles = [];

  String dropdownvalue = 'SDS';

  String selectedvalue = "";

  var data2 = Get.arguments;

  // List of items in our dropdown menu
  var items = [
    'SDS',
    'Non SDS',
  ];
  bool isSelected = false;
  File? file;

  void selected(value) {
    if (value == "Country") {
    } else if (value == "Item 2") {}
    setState(() {
      dropdownvalue = value;
      isSelected = false;
    });
  }

  Future<void> _pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        selectedFiles = result.paths.map((path) => path!).toList();
        print("selected file ");
      });
    }
  }

  List<String> files = [];
  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          files.add(filePath);
          print(files);
        });
      }
    }
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
          print("++++$file");
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
      //print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Form(
              child: SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.PrimaryWhiteColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " {$titled}",
                            style: batchtext2(AppColors.PrimaryMainColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  selectfile();
                                },
                                child: Container(
                                    height: 50,
                                    width: 220,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          topLeft: Radius.circular(5),
                                        ),
                                        border: Border.all()),
                                    child: Center(
                                      child: Text("$imageUrl"),
                                    )),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        border: Border.all()),
                                    width: 80,
                                    height: 50,
                                    child: GestureDetector(
                                      onTap: removePost,
                                      child: Container(
                                        height: 50,
                                        width: 100,
                                        child: Text("xejb"),
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ))),
            )
          ],
        )
      ],
    );
  }
}

class CustomDialog extends StatefulWidget {
  String? countid;
  String? courseid;
  String? selectsds;
  CustomDialog({this.countid, this.courseid, this.selectsds});

  @override
  State<CustomDialog> createState() => _CustomDialogState(
      countid: countid, courseid: courseid, selectsds: selectsds);
}

class _CustomDialogState extends State<CustomDialog> {
  String? countid;
  String? courseid;
  String? selectsds;
  _CustomDialogState({this.countid, this.courseid, this.selectsds});
  late DashBoardBloc dashBoardBloc;
  List<String> requiredDocuments = [];

  @override
  void initState() {
    super.initState();
    dashBoardBloc = DashBoardBloc();

    getfinnalvisasubmit();
    callfinalVisa();

    // _gethomeData();
    // super.initState();
  }

  var data2 = Get.arguments;

  void callfinalVisa() {
    // NetworkDialog.showLoadingDialog(context, _keyLoader);
    // String spselcected = selectedItems.join(",");
    //  String? countid;
    // String? courseid;
    // String? selectsds;
    Map<String, dynamic> finalvisa = {
      "CourseId": courseid,
      "CountryId": countid,
      "CountryStream": selectsds
    };
    // debugger();
    // print(finalvisa);
    dashBoardBloc.callFianlvisasubmit(finalvisa);
  }

  getfinnalvisasubmit() async {
    await dashBoardBloc.finalvisasubmitcontrollerStream.listen((event) {
      //  showloader ? Navigator.pop(context) : "";
      // debugger();
      // print(event.data);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true) {
        VisaresponseModel visaGetModel = VisaresponseModel.fromJson(event.data);

        setState(() {
          requiredDocuments.addAll(visaGetModel.requiredDocuments);
        });
      }
      if (response == true && event.data["Status"] == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Document Submmited Succesfully"),
        ));
        Navigator.pushNamed(context, RoutesName.bottomnav);

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(milliseconds: 1000),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 80,
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

      //   bool response =
      //     ApiResponseHelper().handleResponse(event: event, context: context);

      // if (event != null) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please Upload Required Document *',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.PrimaryMainColor),
            ),
            SizedBox(height: 16.0),
            for (int i = 0; i < requiredDocuments.length; i++)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "${i + 1} .  " + requiredDocuments[i].toString() + "*",
                  style: batchtext2(const Color.fromARGB(255, 224, 105, 96)),
                ),
              ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PrimaryMainColor,
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.normal),
                ),
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
