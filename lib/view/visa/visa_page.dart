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
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['pdf', 'docx'],
      type: FileType.custom,
    );

    if (result != null) {
      PlatformFile files = result.files.single;
      if (files.extension == 'pdf' || files.extension == 'docx') {
        if (files.size <= 8 * 1024 * 1024) {
          setState(() {
            file = File(result.files.single.path!);
          });

          String spselcected = selectedItems.join(",");

          if (selectedItems.isEmpty || file == null) {
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Please Select Document",
                style: batchtext2(AppColors.PrimaryWhiteColor),
              ),
            );
          } else {
            setState(() {
              adcamibloading = false;
            });
            calluploadVisa(spselcected, file);
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
                actions: [
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
                'Invalid File Type',
                style: batchtext2(AppColors.PrimaryBlackColor),
              ),
              content: Text(
                'Please select a PDF or DOCX file.',
                style: batchtext2(Colors.red),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryMainColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void selectWorkFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['pdf', 'docx'],
      type: FileType.custom,
    );

    if (result != null) {
      PlatformFile files = result.files.single;
      if (files.extension == 'pdf' || files.extension == 'docx') {
        if (files.size <= 8 * 1024 * 1024) {
          setState(() {
            workfile = File(result.files.single.path!);
          });
          if (selectedWork.isEmpty || workfile == null) {
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Please Select Document",
                style: batchtext2(AppColors.PrimaryWhiteColor),
              ),
            );
          } else {
            setState(() {
              workloading = false;
            });
            String spselcectedwork = selectedWork.join(",");
            calluploadVisa(spselcectedwork, workfile);
            callfinalCanadsVisa();
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
      } else {
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
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryMainColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void selectfundsFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['pdf', 'docx'],
      type: FileType.custom,
    );

    if (result != null) {
      PlatformFile files = result.files.single;
      if (files.extension == 'pdf' || files.extension == 'docx') {
        if (files.size <= 8 * 1024 * 1024) {
          setState(() {
            fundsfile = File(result.files.single.path!);
          });

          String spselcectfund = selectedFunds.join(",");

          if (selectedFunds.isEmpty || fundsfile == null) {
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Please Select Document",
                style: batchtext2(AppColors.PrimaryWhiteColor),
              ),
            );
          } else {
            setState(() {
              fundsDocumentsloading = false;
            });
            calluploadVisa(spselcectfund, fundsfile!);
            callfinalCanadsVisa();
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
      } else {
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
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryMainColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void selectFincialFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['pdf', 'docx'],
      type: FileType.custom,
    );

    if (result != null) {
      PlatformFile files = result.files.single;
      if (files.extension == 'pdf' || files.extension == 'docx') {
        if (files.size <= 8 * 1024 * 1024) {
          setState(() {
            financialfile = File(result.files.single.path!);
          });
          String spselcectfincial = selectedFinancial.join(",");

          if (selectedFinancial.isEmpty || financialfile == null) {
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Please Select Document",
                style: batchtext2(AppColors.PrimaryWhiteColor),
              ),
            );
          } else {
            setState(() {
              financialDocumentsloading = false;
            });
            calluploadVisa(spselcectfincial, financialfile!);
            callfinalCanadsVisa();
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
      } else {
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
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryMainColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void selectSponsorFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['pdf', 'docx'],
      type: FileType.custom,
    );

    if (result != null) {
      PlatformFile files = result.files.single;
      if (files.extension == 'pdf' || files.extension == 'docx') {
        if (files.size <= 8 * 1024 * 1024) {
          setState(() {
            sponsorfile = File(result.files.single.path!);
          });
          String spselcectsponser = selectedSponsor.join(",");

          if (selectedSponsor.isEmpty || sponsorfile == null) {
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Please Select Document",
                style: batchtext2(AppColors.PrimaryWhiteColor),
              ),
            );
          } else {
            setState(() {
              sponsorDocumentsloading = false;
            });
            calluploadVisa(spselcectsponser, sponsorfile!);
            callfinalCanadsVisa();
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
      } else {
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
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryMainColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void selectAlldocumenntFiles(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['pdf', 'docx'],
      type: FileType.custom,
    );

    if (result != null) {
      PlatformFile files = result.files.single;
      if (files.extension == 'pdf' || files.extension == 'docx') {
        if (files.size <= 8 * 1024 * 1024) {
          setState(() {
            alldocumentfile = File(result.files.single.path!);
            selectedIndex = index;
          });
          if (alldocumentfile == null) {
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Please Select Document",
                style: batchtext2(AppColors.PrimaryWhiteColor),
              ),
            );
          } else {
            setState(() {
              // ignore: unrelated_type_equality_checks
              alldocumentfile == "";
              if (cart.contains(allDocuments[index].fDocumentName)) {
                cart.remove(allDocuments[index].fDocumentName);
              } else {
                cart.add(allDocuments[index].fDocumentName);
              }
            });
            calluploadVisa(
                allDocuments[index].fVisaFileRequiredDocumentId.toString(),
                alldocumentfile!);
            callfinalCanadsVisa();
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
      } else {
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
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryMainColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  getVisaDetails() async {
    dashBoardBloc.getvisadetailscontrollerStream.listen((event) {
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
      "f_countryid": "3",
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

    Map data = {
      "studentid": data2[4].toString(),
      "CourseId": data2[3].toString(),
      "CountryId": data2[0].toString(),
      "DocumentId": documentid.toString(),
      "IsStarted": basichit.toString(),
    };

    dashBoardBloc.visaUploadApi(
      data,
      filedata!,
    );
  }

  void callfinalVisa() {
    Map<String, dynamic> finalvisa = {
      "CourseId": data2[3].toString(),
      "CountryId": data2[0].toString(),
      "CountryStream": ""
    };

    dashBoardBloc.callFianlvisasubmit(finalvisa);
  }

  void callfinalCanadsVisa() {
    Map<String, dynamic> finalvisa = {
      "CourseId": data2[3].toString(),
      "CountryId": data2[0].toString(),
      "CountryStream": selectedvalue.toString(),
    };

    dashBoardBloc.callFianlvisasubmit(finalvisa);
  }

  getfinnalvisasubmit() async {
    dashBoardBloc.finalvisasubmitcontrollerStream.listen((event) {
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true) {
        VisaresponseModel visaGetModel = VisaresponseModel.fromJson(event.data);
        requiredDocuments.clear();
        setState(() {
          requiredDocuments.addAll(visaGetModel.requiredDocuments);
        });
      }
    });
  }

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
                child: Padding(
                padding: EdgeInsets.all(15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Note:- First, Make sure to choose correct Document.",
                        style: batchtext2(
                            const Color.fromARGB(255, 224, 105, 96))),
                    SizedBox(
                      height: 5.h,
                    ),
                    data2[0] == "3"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 50.h,
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColors.PrimaryWhiteColor),
                                  child: Center(
                                      child: Text(
                                    data2[1].toString(),
                                    style: FieldTextStyle(
                                        AppColors.PrimaryMainColor),
                                  ))),
                              Container(
                                height: 50.h,
                                width: 160.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: AppColors.PrimaryGreyColor,
                                          width: 1),
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
                                        padding: EdgeInsets.only(left: 10.r),
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
                                    });
                                  },
                                ),
                              )
                            ],
                          )
                        : Container(
                            height: 50.h,
                            width: 360.w,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.PrimaryWhiteColor),
                            child: Center(
                                child: Text(
                              data2[1].toString(),
                              style: batchtext2(AppColors.PrimaryMainColor),
                            ))),
                    academicDocuments.isEmpty
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(" All Academic Documents",
                                      style: batchtext2(
                                        AppColors.PrimaryMainColor,
                                      )),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Text(
                                      'Please Select Academic Documents',
                                      style: batchtext2(AppColors.hintcolor),
                                    ),
                                    items: academicDocuments.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item.fVisaFileRequiredDocumentId,
                                        enabled: false,
                                        child: StatefulBuilder(
                                          builder: (context, menuSetState) {
                                            final isSelected =
                                                selectedItems.contains(item
                                                    .fVisaFileRequiredDocumentId);
                                            return InkWell(
                                              onTap: () {
                                                isSelected
                                                    ? selectedItems.remove(item
                                                        .fVisaFileRequiredDocumentId)
                                                    : selectedItems.add(item
                                                        .fVisaFileRequiredDocumentId);

                                                setState(() {});

                                                menuSetState(() {});
                                              },
                                              child: Container(
                                                height: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
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
                                                    const SizedBox(width: 16),
                                                    item.fIsRequired
                                                        ? Flexible(
                                                            child: RichText(
                                                            text: TextSpan(
                                                              text: item
                                                                  .fDocumentName,
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              children: [
                                                                TextSpan(
                                                                    text: ' * ',
                                                                    style: batchtext2(
                                                                        Colors
                                                                            .red)),
                                                              ],
                                                            ),
                                                          ))
                                                        : Flexible(
                                                            child: Text(
                                                              item.fDocumentName,
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
                                      return academicDocuments.map(
                                        (item) {
                                          return Container(
                                            alignment:
                                                AlignmentDirectional.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              "Selected ${selectedItems.length}",
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              maxLines: 1,
                                            ),
                                          );
                                        },
                                      ).toList();
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
                                            color: AppColors.PrimaryWhiteColor,
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
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    adcamibloading == false
                                        ? Container(
                                            height: 50.h,
                                            width: 220.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                ),
                                                border: Border.all()),
                                            child: file == null
                                                ? Center(
                                                    child: Text(
                                                      "Plese select file",
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                  )
                                                : Center(
                                                    child: Text(
                                                      "Uploaded succesfully"
                                                          .toString(),
                                                      style: batchtext2(AppColors
                                                          .PrimaryBlackColor),
                                                    ),
                                                  ))
                                        : InkWell(
                                            onTap: () {
                                              if (selectedItems.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Please Select Document",
                                                    style: batchtext2(AppColors
                                                        .PrimaryWhiteColor),
                                                  ),
                                                ));
                                              } else {
                                                selectFiles();
                                              }
                                            },
                                            child: Container(
                                                height: 50.h,
                                                width: 300.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
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
                                                        child: Text(file!.path
                                                            .split("/")
                                                            .last
                                                            .toString()),
                                                      )),
                                          ),
                                    adcamibloading == false
                                        ? Container(
                                            width: 80.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                ),
                                                border: Border.all()),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: const LinearBorder(),
                                                  side: const BorderSide(),
                                                  backgroundColor: Colors.green,
                                                  elevation: 3),
                                              onPressed: () {},
                                              child: const Icon(Icons.check),
                                            ),
                                          )
                                        : Container()
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
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style: batchtext2(AppColors.hintcolor),
                                    ),
                                    items: workExperience.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item.fVisaFileRequiredDocumentId,
                                        enabled: false,
                                        child: StatefulBuilder(
                                          builder: (context, menuSetState) {
                                            final isSelected0 =
                                                selectedWork.contains(item
                                                    .fVisaFileRequiredDocumentId);
                                            return InkWell(
                                              onTap: () {
                                                isSelected0
                                                    ? selectedWork.remove(item
                                                        .fVisaFileRequiredDocumentId)
                                                    : selectedWork.add(item
                                                        .fVisaFileRequiredDocumentId);

                                                setState(() {});

                                                menuSetState(() {});
                                              },
                                              child: Container(
                                                height: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
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
                                                    SizedBox(width: 16.w),
                                                    item.fIsRequired
                                                        ? Flexible(
                                                            child: RichText(
                                                            text: TextSpan(
                                                              text: item
                                                                  .fDocumentName,
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              children: [
                                                                TextSpan(
                                                                    text: ' * ',
                                                                    style: batchtext2(
                                                                        Colors
                                                                            .red)),
                                                              ],
                                                            ),
                                                          ))
                                                        : Flexible(
                                                            child: Text(
                                                              item.fDocumentName,
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
                                                AlignmentDirectional.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              "Selected ${selectedWork.length}",
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              maxLines: 1,
                                            ),
                                          );
                                        },
                                      ).toList();
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
                                            color: AppColors.PrimaryWhiteColor,
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
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    workloading == false
                                        ? Container(
                                            height: 50.h,
                                            width: 220.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                ),
                                                border: Border.all()),
                                            child: workfile == null
                                                ? Center(
                                                    child: Text(
                                                      "Plese select file",
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                  )
                                                : Center(
                                                    child: Text(
                                                      "Uploaded succesfully"
                                                          .toString(),
                                                      style: batchtext2(AppColors
                                                          .PrimaryBlackColor),
                                                    ),
                                                  ))
                                        : InkWell(
                                            onTap: () {
                                              if (selectedWork.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Please Select Document",
                                                    style: batchtext2(AppColors
                                                        .PrimaryWhiteColor),
                                                  ),
                                                ));
                                              } else {
                                                selectWorkFiles();
                                              }
                                            },
                                            child: Container(
                                                height: 50.h,
                                                width: 300.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.sp),
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
                                            width: 80.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                ),
                                                border: Border.all()),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: const LinearBorder(),
                                                  side: const BorderSide(),
                                                  backgroundColor: Colors.green,
                                                  elevation: 3),
                                              onPressed: () {},
                                              child: const Icon(Icons.check),
                                            ),
                                          )
                                        : Container()
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
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style: batchtext2(AppColors.hintcolor),
                                    ),
                                    items: fundsDocuments.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item.fVisaFileRequiredDocumentId,
                                        enabled: false,
                                        child: StatefulBuilder(
                                          builder: (context, menuSetState) {
                                            final isSelected1 =
                                                selectedFunds.contains(item
                                                    .fVisaFileRequiredDocumentId);
                                            return InkWell(
                                              onTap: () {
                                                isSelected1
                                                    ? selectedFunds.remove(item
                                                        .fVisaFileRequiredDocumentId)
                                                    : selectedFunds.add(item
                                                        .fVisaFileRequiredDocumentId);
                                                setState(() {});
                                                menuSetState(() {});
                                              },
                                              child: Container(
                                                height: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
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
                                                    const SizedBox(width: 16),
                                                    item.fIsRequired
                                                        ? Flexible(
                                                            child: RichText(
                                                            text: TextSpan(
                                                              text: item
                                                                  .fDocumentName,
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              children: [
                                                                TextSpan(
                                                                    text: ' * ',
                                                                    style: batchtext2(
                                                                        Colors
                                                                            .red)),
                                                              ],
                                                            ),
                                                          ))
                                                        : Flexible(
                                                            child: Text(
                                                              item.fDocumentName,
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
                                                AlignmentDirectional.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              "Selected ${selectedFunds.length}",
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              maxLines: 1,
                                            ),
                                          );
                                        },
                                      ).toList();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 55.h,
                                      width: 450.w,
                                      padding: EdgeInsets.all(10.r),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                        isOverButton: true,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                            color: AppColors.PrimaryWhiteColor,
                                            border: Border.all()),
                                        maxHeight: 200.h,
                                        elevation: 10),
                                    menuItemStyleData: const MenuItemStyleData(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      height: 90,
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
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    fundsDocumentsloading == false
                                        ? Container(
                                            height: 50.h,
                                            width: 220.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                ),
                                                border: Border.all()),
                                            child: fundsfile == null
                                                ? Center(
                                                    child: Text(
                                                      "Plese select file",
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                  )
                                                : Center(
                                                    child: Text(
                                                      "Uploaded succesfully"
                                                          .toString(),
                                                      style: batchtext2(AppColors
                                                          .PrimaryBlackColor),
                                                    ),
                                                  ))
                                        : InkWell(
                                            onTap: () {
                                              if (selectedFunds.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Please Select Document",
                                                    style: batchtext2(AppColors
                                                        .PrimaryWhiteColor),
                                                  ),
                                                ));
                                              } else {
                                                selectfundsFiles();
                                              }
                                            },
                                            child: Container(
                                                height: 50.h,
                                                width: 300.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.sp),
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
                                                        child: Text(fundsfile!
                                                            .path
                                                            .split("/")
                                                            .last
                                                            .toString()),
                                                      )),
                                          ),
                                    fundsDocumentsloading == false
                                        ? Container(
                                            width: 80.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                ),
                                                border: Border.all()),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: const LinearBorder(),
                                                  side: const BorderSide(),
                                                  backgroundColor: Colors.green,
                                                  elevation: 3),
                                              onPressed: () {},
                                              child: const Icon(Icons.check),
                                            ),
                                          )
                                        : Container()
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
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(" All financial Documents",
                                      style: batchtext2(
                                        AppColors.PrimaryMainColor,
                                      )),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Text(
                                      'Please Select financial Documents',
                                      style: batchtext2(AppColors.hintcolor),
                                    ),
                                    items: financialDocuments.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item.fVisaFileRequiredDocumentId,
                                        enabled: false,
                                        child: StatefulBuilder(
                                          builder: (context, menuSetState) {
                                            final isSelected3 =
                                                selectedFinancial.contains(item
                                                    .fVisaFileRequiredDocumentId);
                                            return InkWell(
                                              onTap: () {
                                                isSelected3
                                                    ? selectedFinancial.remove(item
                                                        .fVisaFileRequiredDocumentId)
                                                    : selectedFinancial.add(item
                                                        .fVisaFileRequiredDocumentId);
                                                setState(() {});
                                                menuSetState(() {});
                                              },
                                              child: Container(
                                                height: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
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
                                                    const SizedBox(width: 16),
                                                    item.fIsRequired
                                                        ? Flexible(
                                                            child: RichText(
                                                            text: TextSpan(
                                                              text: item
                                                                  .fDocumentName,
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              children: [
                                                                TextSpan(
                                                                    text: ' * ',
                                                                    style: batchtext2(
                                                                        Colors
                                                                            .red)),
                                                              ],
                                                            ),
                                                          ))
                                                        : Flexible(
                                                            child: Text(
                                                              item.fDocumentName,
                                                              maxLines: 3,
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
                                    value: selectedFinancial.isEmpty
                                        ? null
                                        : selectedFinancial.last,
                                    onChanged: (value) {
                                      selectedFinancial.last = value!;

                                      setState(() {});
                                    },
                                    selectedItemBuilder: (context) {
                                      return financialDocuments.map(
                                        (item) {
                                          return Container(
                                            alignment:
                                                AlignmentDirectional.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              "Selected ${selectedFinancial.length}",
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              maxLines: 1,
                                            ),
                                          );
                                        },
                                      ).toList();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 55.h,
                                      width: 450.w,
                                      padding: EdgeInsets.all(10.r),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                        isOverButton: true,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                            color: AppColors.PrimaryWhiteColor,
                                            border: Border.all()),
                                        maxHeight: 200.h,
                                        elevation: 10),
                                    menuItemStyleData: MenuItemStyleData(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      height: 45.h,
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
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    financialDocumentsloading == false
                                        ? Container(
                                            height: 50.h,
                                            width: 220.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                ),
                                                border: Border.all()),
                                            child: financialfile == null
                                                ? Center(
                                                    child: Text(
                                                      "Plese select file",
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                  )
                                                : Center(
                                                    child: Text(
                                                      "Uploaded succesfully"
                                                          .toString(),
                                                      style: batchtext2(AppColors
                                                          .PrimaryBlackColor),
                                                    ),
                                                  ))
                                        : InkWell(
                                            onTap: () {
                                              if (selectedFinancial.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Please Select Document",
                                                    style: batchtext2(AppColors
                                                        .PrimaryWhiteColor),
                                                  ),
                                                ));
                                              } else {
                                                selectFincialFiles();
                                              }
                                            },
                                            child: Container(
                                                height: 50.h,
                                                width: 300.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.sp),
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
                                                            financialfile!.path
                                                                .split("/")
                                                                .last
                                                                .toString()),
                                                      )),
                                          ),
                                    financialDocumentsloading == false
                                        ? Container(
                                            width: 80.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                ),
                                                border: Border.all()),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: const LinearBorder(),
                                                  side: const BorderSide(),
                                                  backgroundColor: Colors.green,
                                                  elevation: 3),
                                              onPressed: () {},
                                              child: const Icon(Icons.check),
                                            ),
                                          )
                                        : Container()
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
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(" All Sponsor Documents",
                                      style: batchtext2(
                                        AppColors.PrimaryMainColor,
                                      )),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Text(
                                      'Please Select Sponsor Documents',
                                      style: batchtext2(AppColors.hintcolor),
                                    ),
                                    items: sponsorDocuments.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item.fVisaFileRequiredDocumentId,
                                        enabled: false,
                                        child: StatefulBuilder(
                                          builder: (context, menuSetState) {
                                            final isSelected2 =
                                                selectedSponsor.contains(item
                                                    .fVisaFileRequiredDocumentId);
                                            return InkWell(
                                              onTap: () {
                                                isSelected2
                                                    ? selectedSponsor.remove(item
                                                        .fVisaFileRequiredDocumentId)
                                                    : selectedSponsor.add(item
                                                        .fVisaFileRequiredDocumentId);
                                                setState(() {});
                                                menuSetState(() {});
                                              },
                                              child: Container(
                                                height: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
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
                                                    const SizedBox(width: 16),
                                                    item.fIsRequired
                                                        ? Flexible(
                                                            child: RichText(
                                                            text: TextSpan(
                                                              text: item
                                                                  .fDocumentName,
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryMainColor),
                                                              children: [
                                                                TextSpan(
                                                                    text: ' * ',
                                                                    style: batchtext2(
                                                                        Colors
                                                                            .red)),
                                                              ],
                                                            ),
                                                          ))
                                                        : Flexible(
                                                            child: Text(
                                                              item.fDocumentName,
                                                              maxLines: 3,
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
                                                AlignmentDirectional.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              "Selected ${selectedSponsor.length}",
                                              style: batchtext2(
                                                  AppColors.PrimaryMainColor),
                                              maxLines: 1,
                                            ),
                                          );
                                        },
                                      ).toList();
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
                                            color: AppColors.PrimaryWhiteColor,
                                            border: Border.all()),
                                        maxHeight: 200.h,
                                        elevation: 10),
                                    menuItemStyleData: MenuItemStyleData(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      height: 45.h,
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
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    sponsorDocumentsloading == false
                                        ? Container(
                                            height: 50.h,
                                            width: 220.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                ),
                                                border: Border.all()),
                                            child: sponsorfile == null
                                                ? Center(
                                                    child: Text(
                                                      "Plese select file",
                                                      style: batchtext2(
                                                          AppColors.hintcolor),
                                                    ),
                                                  )
                                                : Center(
                                                    child: Text(
                                                      "Uploaded succesfully"
                                                          .toString(),
                                                      style: batchtext2(AppColors
                                                          .PrimaryBlackColor),
                                                    ),
                                                  ))
                                        : InkWell(
                                            onTap: () {
                                              if (selectedFinancial.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Please Select Document",
                                                    style: batchtext2(AppColors
                                                        .PrimaryWhiteColor),
                                                  ),
                                                ));
                                              } else {
                                                selectSponsorFiles();
                                              }
                                            },
                                            child: Container(
                                                height: 50.h,
                                                width: 300.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.sp),
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
                                                        child: Text(sponsorfile!
                                                            .path
                                                            .split("/")
                                                            .last
                                                            .toString()),
                                                      )),
                                          ),
                                    sponsorDocumentsloading == false
                                        ? Container(
                                            width: 80.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                ),
                                                border: Border.all()),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: const LinearBorder(),
                                                  side: const BorderSide(),
                                                  backgroundColor: Colors.green,
                                                  elevation: 3),
                                              onPressed: () {},
                                              child: const Icon(Icons.check),
                                            ),
                                          )
                                        : Container()
                                  ],
                                )
                              ],
                            ),
                          ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allDocuments.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.PrimaryWhiteColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  allDocuments[index].fIsRequired == true
                                      ? RichText(
                                          text: TextSpan(
                                            text: allDocuments[index]
                                                .fDocumentName,
                                            style: batchtext2(
                                                AppColors.PrimaryMainColor),
                                            children: [
                                              TextSpan(
                                                  text: ' * ',
                                                  style:
                                                      batchtext2(Colors.red)),
                                            ],
                                          ),
                                        )
                                      : Text(
                                          allDocuments[index]
                                              .fDocumentName
                                              .toString(),
                                          style: batchtext2(
                                              AppColors.PrimaryMainColor),
                                        ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      cart.contains(
                                              allDocuments[index].fDocumentName)
                                          ? Container(
                                              height: 50.h,
                                              width: 220.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                  border: Border.all()),
                                              child: alldocumentfile == null
                                                  ? Center(
                                                      child: cart.contains(
                                                              allDocuments[
                                                                      index]
                                                                  .fDocumentName)
                                                          ? Text(
                                                              "Uploaded succesfully",
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .PrimaryBlackColor),
                                                            )
                                                          : Text(
                                                              "Plese Select File",
                                                              style: batchtext2(
                                                                  AppColors
                                                                      .hintcolor)),
                                                    )
                                                  : selectedIndex == index
                                                      ? Center(
                                                          child: Text(
                                                              alldocumentfile!
                                                                  .path
                                                                  .split("/")
                                                                  .last
                                                                  .toString()),
                                                        )
                                                      : const Text(""),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                selectAlldocumenntFiles(index);
                                              },
                                              child: Container(
                                                height: 50.h,
                                                width: 300.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.sp),
                                                    border: Border.all()),
                                                child: alldocumentfile == null
                                                    ? Center(
                                                        child: cart.contains(
                                                                allDocuments[
                                                                        index]
                                                                    .fDocumentName)
                                                            ? Text(
                                                                "Uploaded succesfully",
                                                                style: batchtext2(
                                                                    AppColors
                                                                        .PrimaryBlackColor),
                                                              )
                                                            : Text(
                                                                "Plese Select File",
                                                                style: batchtext2(
                                                                    AppColors
                                                                        .hintcolor)),
                                                      )
                                                    : selectedIndex == index
                                                        ? Center(
                                                            child: Text(
                                                                alldocumentfile!
                                                                    .path
                                                                    .split("/")
                                                                    .last
                                                                    .toString()),
                                                          )
                                                        : const Text(""),
                                              ),
                                            ),
                                      cart.contains(
                                              allDocuments[index].fDocumentName)
                                          ? Container(
                                              width: 80.w,
                                              height: 50.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                  ),
                                                  border: Border.all()),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape: const LinearBorder(),
                                                    side: const BorderSide(),
                                                    backgroundColor:
                                                        Colors.green,
                                                    elevation: 3),
                                                onPressed: () {},
                                                child: const Icon(Icons.check),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                ],
                              ));
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                    basichit == 0
                        ? Container()
                        : Column(
                            children: [
                              Text(
                                  "Note:- Upload Required Document and click to Submit Button.",
                                  style: batchtext2(
                                      const Color.fromARGB(255, 224, 105, 96))),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 15.r, left: 15.r, right: 15.r),
                                child: ButtonPrimary(
                                  title: "Submit",
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialog(
                                            countid: data2[0].toString(),
                                            courseid: data2[3].toString(),
                                            selectsds:
                                                selectedvalue.toString());
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                  ],
                ),
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
  }

  var data2 = Get.arguments;

  void callfinalVisa() {
    Map<String, dynamic> finalvisa = {
      "CourseId": courseid,
      "CountryId": countid,
      "CountryStream": selectsds
    };

    dashBoardBloc.callFianlvisasubmit(finalvisa);
  }

  getfinnalvisasubmit() async {
    dashBoardBloc.finalvisasubmitcontrollerStream.listen((event) {
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true) {
        VisaresponseModel visaGetModel = VisaresponseModel.fromJson(event.data);

        setState(() {
          requiredDocuments.addAll(visaGetModel.requiredDocuments);
        });
      }
      if (response == true && event.data["Status"] == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
          content: Text(
            "Document Uploaded Succesfully",
            style: batchtext1(AppColors.PrimaryWhiteColor),
          ),
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
