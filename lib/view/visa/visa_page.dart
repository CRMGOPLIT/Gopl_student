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

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getVisaDetails();
    datacanada();
    subimmeted();
    getfinnalvisasubmit();

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
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
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
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
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
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
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
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
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
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
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
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // debugger();
    }
  }

  getVisaDetails() async {
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
    if (data2[0] == "3") {
      _gethomeData();
    } else {
      _gethomeDataoyher();
    }
  }

  void subimmeted() async {
    dashBoardBloc.uploadviscontrollerStream.listen((event) {
      Navigator.pop(context);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

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

  _gethomeData() {
    Map<String, dynamic> visadata = {
      "f_countryid": "3", //data2[0].toString(),
      "f_CountryStream": selectedvalue,
    };
    dashBoardBloc.callGetvisadetails(visadata);
  }

  _gethomeDataoyher() {
    Map<String, dynamic> visadata = {
      "f_countryid": data2[0].toString(),
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

    dashBoardBloc.visaUploadApi(
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

    dashBoardBloc.callFianlvisasubmit(finalvisa);
  }

  getfinnalvisasubmit() async {
    dashBoardBloc.finalvisasubmitcontrollerStream.listen((event) {
      //  showloader ? Navigator.pop(context) : "";

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
            title: "Upload Visa Document",
            onpress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.bottomnav,
                (routes) => false,
              );
            },
          ),
        ),
        body: loanding
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: AppColors.PrimaryMainColor,
              ))
            : SingleChildScrollView(
                child: data2[2] == "0"
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100.h,
                          ),
                          Center(
                              child: Image.asset(
                            "assets/images/visastatus.png",
                            height: 230.h,
                            width: 250.w,
                            fit: BoxFit.contain,
                          )),
                          Text("Not applicable.",
                              style: H2TextStyle(AppColors.PrimaryMainColor)),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      )
                    : data2[2] == "1"
                        ? Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(data2[2].toString()),
                                data2[2] == "3"
                                    ? Row(
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
                                                      BorderRadius.circular(
                                                          10.r),
                                                  color: AppColors
                                                      .PrimaryWhiteColor),
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
                                                color: AppColors
                                                    .PrimaryWhiteColor),
                                            child: DropdownButtonFormField(
                                              hint: Text(
                                                "Select",
                                                style: batchtext2(
                                                    AppColors.hintcolor),
                                              ),
                                              style: const TextStyle(
                                                  color: AppColors
                                                      .PrimaryMainColor,
                                                  fontWeight: FontWeight.w600),
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  borderSide: const BorderSide(
                                                      color: AppColors
                                                          .PrimaryGreyColor,
                                                      width: 1),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  borderSide: const BorderSide(
                                                    color: AppColors
                                                        .PrimaryBlackColor,
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
                                                  color: AppColors
                                                      .PrimaryMainColor,
                                                ),
                                              ),
                                              items: items.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.r),
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
                                      )
                                    : Container(
                                        height: 50.h,
                                        width: 360.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: AppColors.PrimaryWhiteColor),
                                        child: Center(
                                            child: Text(
                                          data2[1].toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryMainColor),
                                        ))),

                                // Text(data2[1].toString()),

                                academicDocuments.isEmpty
                                    ? Container()
                                    : Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                items: academicDocuments
                                                    .map((item) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: item
                                                        .fVisaFileRequiredDocumentId,
                                                    //disable default onTap to avoid closing menu when selecting an item
                                                    enabled: false,
                                                    child: StatefulBuilder(
                                                      builder: (context,
                                                          menuSetState) {
                                                        final isSelected =
                                                            selectedItems
                                                                .contains(item
                                                                    .fVisaFileRequiredDocumentId);
                                                        return InkWell(
                                                          onTap: () {
                                                            isSelected
                                                                ? selectedItems
                                                                    .remove(item
                                                                        .fVisaFileRequiredDocumentId)
                                                                : selectedItems
                                                                    .add(item
                                                                        .fVisaFileRequiredDocumentId);

                                                            //This rebuilds the StatefulWidget to update the button's text
                                                            setState(() {
                                                              //  bool sum = item.fIsRequired;
                                                            });

                                                            // countryid();
                                                            //This rebuilds the dropdownMenu Widget to update the check mark
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
                                                                item.fIsRequired
                                                                    ? Flexible(
                                                                        child:
                                                                            RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          text:
                                                                              item.fDocumentName,
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryMainColor),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' * ',
                                                                                style: batchtext2(Colors.red)),
                                                                          ],
                                                                        ),
                                                                      )
                                                                        //     Text(
                                                                        //   "${item.fDocumentName} *",
                                                                        //   style:
                                                                        //       batchtext2(AppColors.PrimaryMainColor),
                                                                        // ),
                                                                        )
                                                                    : Flexible(
                                                                        child:
                                                                            Text(
                                                                          item.fDocumentName,
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryMainColor),
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

                                                  setState(() {});
                                                },
                                                selectedItemBuilder: (context) {
                                                  return academicDocuments.map(
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
                                                    const ButtonStyleData(
                                                  height: 55,
                                                  width: 450,
                                                  padding: EdgeInsets.all(10),
                                                ),
                                                dropdownStyleData: DropdownStyleData(
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
                                            SizedBox(
                                              height: 5.h,
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
                                                              const BorderRadius
                                                                  .only(
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
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
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
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  const LinearBorder(),
                                                              side:
                                                                  const BorderSide(),
                                                              backgroundColor:
                                                                  Colors.green,
                                                              elevation: 3),
                                                          onPressed: () {},
                                                          child: const Icon(
                                                              Icons.check),
                                                        ),
                                                      )
                                                    : Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
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
                                                            style: ElevatedButton.styleFrom(
                                                                shape:
                                                                    const LinearBorder(),
                                                                side:
                                                                    const BorderSide(),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .PrimaryMainColor,
                                                                elevation: 3),
                                                            onPressed: () {
                                                              String
                                                                  spselcected =
                                                                  selectedItems
                                                                      .join(
                                                                          ",");

                                                              if (selectedItems
                                                                      .isEmpty ||
                                                                  file ==
                                                                      null) {
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
                                                                  adcamibloading =
                                                                      false;
                                                                  // callfinalCanadsVisa();
                                                                });
                                                                calluploadVisa(
                                                                    spselcected,
                                                                    file);
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Upload'),
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
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                items:
                                                    workExperience.map((item) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: item
                                                        .fVisaFileRequiredDocumentId,
                                                    //disable default onTap to avoid closing menu when selecting an item
                                                    enabled: false,
                                                    child: StatefulBuilder(
                                                      builder: (context,
                                                          menuSetState) {
                                                        final isSelected0 =
                                                            selectedWork
                                                                .contains(item
                                                                    .fVisaFileRequiredDocumentId);
                                                        return InkWell(
                                                          onTap: () {
                                                            isSelected0
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
                                                                isSelected0
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
                                                                item.fIsRequired
                                                                    ? Flexible(
                                                                        child:
                                                                            RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          text:
                                                                              item.fDocumentName,
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryMainColor),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' * ',
                                                                                style: batchtext2(Colors.red)),
                                                                          ],
                                                                        ),
                                                                      ))
                                                                    : Flexible(
                                                                        child:
                                                                            Text(
                                                                          item.fDocumentName,
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryMainColor),
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

                                                  setState(() {});
                                                },
                                                selectedItemBuilder: (context) {
                                                  return workExperience.map(
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
                                                          "Selected ${selectedWork.length}",
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
                                                    const ButtonStyleData(
                                                  height: 55,
                                                  width: 450,
                                                  padding: EdgeInsets.all(10),
                                                ),
                                                dropdownStyleData: DropdownStyleData(
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
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    selectWorkFiles();
                                                  },
                                                  child: Container(
                                                      height: 45.h,
                                                      width: 220.w,
                                                      //  margin: EdgeInsets.all(10),
                                                      //padding: EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
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
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
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
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  const LinearBorder(),
                                                              side:
                                                                  const BorderSide(),
                                                              backgroundColor:
                                                                  Colors.green,
                                                              elevation: 3),
                                                          onPressed: () {},
                                                          child: const Icon(
                                                              Icons.check),
                                                        ),
                                                      )
                                                    : Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
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
                                                            style: ElevatedButton.styleFrom(
                                                                shape:
                                                                    const LinearBorder(),
                                                                side:
                                                                    const BorderSide(),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .PrimaryMainColor,
                                                                elevation: 3),
                                                            onPressed: () {
                                                              if (selectedWork
                                                                      .isEmpty ||
                                                                  workfile ==
                                                                      null) {
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
                                                            },
                                                            child: const Text(
                                                                'Upload'),
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
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                items:
                                                    fundsDocuments.map((item) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: item
                                                        .fVisaFileRequiredDocumentId,
                                                    //disable default onTap to avoid closing menu when selecting an item
                                                    enabled: false,
                                                    child: StatefulBuilder(
                                                      builder: (context,
                                                          menuSetState) {
                                                        final isSelected1 =
                                                            selectedFunds
                                                                .contains(item
                                                                    .fVisaFileRequiredDocumentId);
                                                        return InkWell(
                                                          onTap: () {
                                                            isSelected1
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
                                                                isSelected1
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
                                                                item.fIsRequired
                                                                    ? Flexible(
                                                                        child:
                                                                            RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          text:
                                                                              item.fDocumentName,
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryMainColor),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' * ',
                                                                                style: batchtext2(Colors.red)),
                                                                          ],
                                                                        ),
                                                                      )
                                                                        //     Text(
                                                                        //   "${item.fDocumentName} *",
                                                                        //   style:
                                                                        //       batchtext2(AppColors.PrimaryMainColor),
                                                                        // ),
                                                                        )
                                                                    : Flexible(
                                                                        child:
                                                                            Text(
                                                                          item.fDocumentName,
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryMainColor),
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

                                                  setState(() {});
                                                },
                                                selectedItemBuilder: (context) {
                                                  return fundsDocuments.map(
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
                                                          "Selected ${selectedFunds.length}",
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
                                                    const ButtonStyleData(
                                                  height: 55,
                                                  width: 450,
                                                  padding: EdgeInsets.all(10),
                                                ),
                                                dropdownStyleData: DropdownStyleData(
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
                                            SizedBox(
                                              height: 5.h,
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
                                                              const BorderRadius
                                                                  .only(
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
                                                                  fundsfile!
                                                                      .path
                                                                      .split(
                                                                          "/")
                                                                      .last
                                                                      .toString()),
                                                            )),
                                                ),
                                                fundsDocumentsloading == false
                                                    ? Container(
                                                        width: 80,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
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
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  const LinearBorder(),
                                                              side:
                                                                  const BorderSide(),
                                                              backgroundColor:
                                                                  Colors.green,
                                                              elevation: 3),
                                                          onPressed: () {},
                                                          child: const Icon(
                                                              Icons.check),
                                                        ),
                                                      )
                                                    : Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
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
                                                            style: ElevatedButton.styleFrom(
                                                                shape:
                                                                    const LinearBorder(),
                                                                side:
                                                                    const BorderSide(),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .PrimaryMainColor,
                                                                elevation: 3),
                                                            onPressed: () {
                                                              String
                                                                  spselcectfund =
                                                                  selectedFunds
                                                                      .join(
                                                                          ",");

                                                              if (selectedFunds
                                                                      .isEmpty ||
                                                                  fundsfile ==
                                                                      null) {
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
                                                                  fundsDocumentsloading =
                                                                      false;
                                                                });
                                                                calluploadVisa(
                                                                    spselcectfund,
                                                                    fundsfile!);
                                                                callfinalCanadsVisa();
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Upload'),
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
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: item
                                                        .fVisaFileRequiredDocumentId,
                                                    //disable default onTap to avoid closing menu when selecting an item
                                                    enabled: false,
                                                    child: StatefulBuilder(
                                                      builder: (context,
                                                          menuSetState) {
                                                        final isSelected3 =
                                                            selectedFinancial
                                                                .contains(item
                                                                    .fVisaFileRequiredDocumentId);
                                                        return InkWell(
                                                          onTap: () {
                                                            isSelected3
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
                                                                isSelected3
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
                                                                item.fIsRequired
                                                                    ? Flexible(
                                                                        child:
                                                                            RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          text:
                                                                              item.fDocumentName,
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryMainColor),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' * ',
                                                                                style: batchtext2(Colors.red)),
                                                                          ],
                                                                        ),
                                                                      ))
                                                                    : Flexible(
                                                                        child:
                                                                            Text(
                                                                          item.fDocumentName,
                                                                          maxLines:
                                                                              3,
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryMainColor),
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
                                                  selectedFinancial.last =
                                                      value!;

                                                  setState(() {});
                                                },
                                                selectedItemBuilder: (context) {
                                                  return financialDocuments.map(
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
                                                          "Selected ${selectedFinancial.length}",
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
                                                    const ButtonStyleData(
                                                  height: 55,
                                                  width: 450,
                                                  padding: EdgeInsets.all(10),
                                                ),
                                                dropdownStyleData: DropdownStyleData(
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  height: 45.h,
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
                                            SizedBox(
                                              height: 5.h,
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
                                                              const BorderRadius
                                                                  .only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          border: Border.all()),
                                                      child:
                                                          financialfile == null
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
                                                                          .split(
                                                                              "/")
                                                                          .last
                                                                          .toString()),
                                                                )),
                                                ),
                                                financialDocumentsloading ==
                                                        false
                                                    ? Container(
                                                        width: 80,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
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
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  const LinearBorder(),
                                                              side:
                                                                  const BorderSide(),
                                                              backgroundColor:
                                                                  Colors.green,
                                                              elevation: 3),
                                                          onPressed: () {},
                                                          child: const Icon(
                                                              Icons.check),
                                                        ),
                                                      )
                                                    : Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
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
                                                            style: ElevatedButton.styleFrom(
                                                                shape:
                                                                    const LinearBorder(),
                                                                side:
                                                                    const BorderSide(),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .PrimaryMainColor,
                                                                elevation: 3),
                                                            onPressed: () {
                                                              String
                                                                  spselcectfincial =
                                                                  selectedFinancial
                                                                      .join(
                                                                          ",");

                                                              if (selectedFinancial
                                                                      .isEmpty ||
                                                                  financialfile ==
                                                                      null) {
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
                                                                  financialDocumentsloading =
                                                                      false;
                                                                });
                                                                calluploadVisa(
                                                                    spselcectfincial,
                                                                    financialfile!);
                                                                callfinalCanadsVisa();
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Upload'),
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
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                items: sponsorDocuments
                                                    .map((item) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: item
                                                        .fVisaFileRequiredDocumentId,
                                                    //disable default onTap to avoid closing menu when selecting an item
                                                    enabled: false,
                                                    child: StatefulBuilder(
                                                      builder: (context,
                                                          menuSetState) {
                                                        final isSelected2 =
                                                            selectedSponsor
                                                                .contains(item
                                                                    .fVisaFileRequiredDocumentId);
                                                        return InkWell(
                                                          onTap: () {
                                                            isSelected2
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
                                                                isSelected2
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
                                                                item.fIsRequired
                                                                    ? Flexible(
                                                                        child:
                                                                            RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          text:
                                                                              item.fDocumentName,
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryMainColor),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' * ',
                                                                                style: batchtext2(Colors.red)),
                                                                          ],
                                                                        ),
                                                                      ))
                                                                    : Flexible(
                                                                        child:
                                                                            Text(
                                                                          item.fDocumentName,
                                                                          maxLines:
                                                                              3,
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryMainColor),
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

                                                  setState(() {});
                                                },
                                                selectedItemBuilder: (context) {
                                                  return sponsorDocuments.map(
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
                                                          "Selected ${selectedSponsor.length}",
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
                                                    const ButtonStyleData(
                                                  height: 55,
                                                  width: 450,
                                                  padding: EdgeInsets.all(10),
                                                ),
                                                dropdownStyleData: DropdownStyleData(
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  height: 45.h,
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
                                            SizedBox(
                                              height: 5.h,
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
                                                              const BorderRadius
                                                                  .only(
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
                                                                      .split(
                                                                          "/")
                                                                      .last
                                                                      .toString()),
                                                            )),
                                                ),
                                                sponsorDocumentsloading == false
                                                    ? Container(
                                                        width: 80,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
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
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  const LinearBorder(),
                                                              side:
                                                                  const BorderSide(),
                                                              backgroundColor:
                                                                  Colors.green,
                                                              elevation: 3),
                                                          onPressed: () {},
                                                          child: const Icon(
                                                              Icons.check),
                                                        ),
                                                      )
                                                    : Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
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
                                                            style: ElevatedButton.styleFrom(
                                                                shape:
                                                                    const LinearBorder(),
                                                                side:
                                                                    const BorderSide(),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .PrimaryMainColor,
                                                                elevation: 3),
                                                            onPressed: () {
                                                              String
                                                                  spselcectsponser =
                                                                  selectedSponsor
                                                                      .join(
                                                                          ",");

                                                              if (selectedSponsor
                                                                      .isEmpty ||
                                                                  sponsorfile ==
                                                                      null) {
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
                                                                  sponsorDocumentsloading =
                                                                      false;
                                                                });
                                                                calluploadVisa(
                                                                    spselcectsponser,
                                                                    sponsorfile!);
                                                              }
                                                              callfinalCanadsVisa();
                                                            },
                                                            child: const Text(
                                                                'Upload'),
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: allDocuments.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  AppColors.PrimaryWhiteColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              allDocuments[index].fIsRequired ==
                                                      true
                                                  ? RichText(
                                                      text: TextSpan(
                                                        text:
                                                            allDocuments[index]
                                                                .fDocumentName,
                                                        style: batchtext2(AppColors
                                                            .PrimaryMainColor),
                                                        children: [
                                                          TextSpan(
                                                              text: ' * ',
                                                              style: batchtext2(
                                                                  Colors.red)),
                                                        ],
                                                      ),
                                                    )
                                                  : Text(
                                                      allDocuments[index]
                                                          .fDocumentName
                                                          .toString(),
                                                      style: batchtext2(AppColors
                                                          .PrimaryMainColor),
                                                    ),
                                              SizedBox(
                                                height: 5.h,
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
                                                              const BorderRadius
                                                                  .only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          border: Border.all()),
                                                      child:
                                                          alldocumentfile ==
                                                                  null
                                                              ? Center(
                                                                  child: cart.contains(
                                                                          allDocuments[index]
                                                                              .fDocumentName)
                                                                      ? Text(
                                                                          "uploaded succesfully",
                                                                          style:
                                                                              batchtext2(AppColors.PrimaryBlackColor),
                                                                        )
                                                                      : Text(
                                                                          "Plese Select File",
                                                                          style:
                                                                              batchtext2(AppColors.hintcolor)),
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
                                                                  : const Text(
                                                                      ""),
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
                                                                      const BorderRadius
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
                                                          child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape:
                                                                    const LinearBorder(),
                                                                side:
                                                                    const BorderSide(),
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                elevation: 3),
                                                            onPressed: () {},
                                                            child: const Icon(
                                                                Icons.check),
                                                          ),
                                                        )
                                                      : Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              5),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              5),
                                                                    ),
                                                                    border: Border
                                                                        .all()),
                                                            width: 80,
                                                            height: 50,
                                                            child:
                                                                ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  shape:
                                                                      const LinearBorder(),
                                                                  side:
                                                                      const BorderSide(),
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .PrimaryMainColor,
                                                                  elevation: 3),
                                                              onPressed: () {
                                                                if (alldocumentfile ==
                                                                    null) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    content:
                                                                        Text(
                                                                      "Please Select Document",
                                                                      style: batchtext2(
                                                                          AppColors
                                                                              .PrimaryWhiteColor),
                                                                    ),
                                                                  ));
                                                                } else {
                                                                  setState(() {
                                                                    // ignore: unrelated_type_equality_checks
                                                                    alldocumentfile ==
                                                                        "";
                                                                    if (cart.contains(
                                                                        allDocuments[index]
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
                                                              child: const Text(
                                                                  'Upload'),
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
                                //
                                //               // selectSponsorFiles();
                                //               selectAlldocumenntFiles(index);
                                //             },
                                //             removePost: () {
                                //
                                //               if (alldocumentfile == null) {
                                //

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
                                                    countid:
                                                        data2[0].toString(),
                                                    courseid:
                                                        data2[3].toString(),
                                                    selectsds: selectedvalue
                                                        .toString());
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
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100.h,
                              ),
                              Center(
                                  child: Image.asset(
                                "assets/images/visastatus.png",
                                height: 230.h,
                                width: 250.w,
                                fit: BoxFit.contain,
                              )),
                              Text("Visa Already Applied.",
                                  style:
                                      H2TextStyle(AppColors.PrimaryMainColor)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("Contact to Your Counsellor.",
                                  style:
                                      batchtext2(AppColors.PrimaryMainColor)),
                            ],
                          )));
  }
}

// ignore: must_be_immutable
class CustomDialog extends StatefulWidget {
  String? countid;
  String? courseid;
  String? selectsds;
  CustomDialog({super.key, this.countid, this.courseid, this.selectsds});

  @override
  // ignore: no_logic_in_create_state
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
    Map<String, dynamic> finalvisa = {
      "CourseId": courseid,
      "CountryId": countid,
      "CountryStream": selectsds
    };

    dashBoardBloc.callFianlvisasubmit(finalvisa);
    // debugger();
    // print(finalvisa);
  }

  getfinnalvisasubmit() async {
    dashBoardBloc.finalvisasubmitcontrollerStream.listen((event) {
      //  showloader ? Navigator.pop(context) : "";
      // debugger();

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
                      Text("Please Upload Required Document".toString(),
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please Upload Required Document *',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.PrimaryMainColor),
            ),
            SizedBox(height: 16.h),
            for (int i = 0; i < requiredDocuments.length; i++)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "${i + 1} .  ${requiredDocuments[i]}*",
                  style: batchtext2(const Color.fromARGB(255, 224, 105, 96)),
                ),
              ),
            SizedBox(height: 16.h),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PrimaryMainColor,
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.normal),
                ),
                child: const Text('Close'),
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
