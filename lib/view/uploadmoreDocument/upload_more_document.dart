import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/uploadmoredocument.dart';
import 'package:global_student/networking/NetworkConstant.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/button.dart';
import '../widget/loader.dart';

class UploadMoreDocument extends StatefulWidget {
  const UploadMoreDocument({super.key});

  @override
  State<UploadMoreDocument> createState() => _UploadMoreDocumentState();
}

class _UploadMoreDocumentState extends State<UploadMoreDocument> {
  late DashBoardBloc dashBoardBloc;
  List<UploadmoreDocument> documentdata = [];
  List<File> selectedFile = [];
  List<TextEditingController> selectedfiledata = [];
  bool isFileSelected = false;

  List applicationdata = [];

  bool loading = true;
  bool? check1;

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();

    getUserDetails();
    _gethomeData();

    super.initState();
  }

  getUserDetails() {
    dashBoardBloc.getmoredocumentcontrollerStream.listen((event) {
      if (event != null) {
        applicationdata = event;
        for (int i = 0; i < applicationdata.length; i++) {
          UploadmoreDocument applicationStatusModel =
              UploadmoreDocument.fromJson(event[i]);
          documentdata.add(applicationStatusModel);
        }

        setState(() {
          loading = false;
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callUploadmoreDocumentApi();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onbackbuttondoubleClick(context),
      child: Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Upload More Document",
            onpress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.bottomnav,
                (routes) => false,
              );
            },
          ),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: AppColors.PrimaryMainColor,
              ))
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: documentdata.isEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            Center(
                                child: Image.asset(
                              "assets/images/uploadempty.png",
                              height: 230.h,
                              width: 250.w,
                              fit: BoxFit.contain,
                            )),
                            Text("No Need to upload More Document",
                                style: H2TextStyle(AppColors.PrimaryMainColor)),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text("We will Update Soon.",
                                style: batchtext2(AppColors.PrimaryMainColor)),
                            SizedBox(
                              height: 40.h,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: false,
                        itemCount: documentdata.length,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: ListTile(
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 10.sp, top: 5.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10),
                                          width: 360.w,
                                          decoration: BoxDecoration(
                                              color: AppColors.PrimaryGreyColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            documentdata[index]
                                                .universityApplied
                                                .toString(),
                                            style: TextRegular(
                                                AppColors.PrimaryMainColor),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Course Name",
                                              style: batchtext2(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                            Text(
                                              documentdata[index]
                                                  .courseName
                                                  .toString(),
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Application Stage",
                                              style: batchtext2(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                            Text(
                                              documentdata[index]
                                                  .fApplicationStage
                                                  .toString(),
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        SizedBox(
                                          width: 110.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Intake",
                                                style: batchtext2(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                              Text(
                                                documentdata[index]
                                                    .fIntake
                                                    .toString(),
                                                style: batchtext1(AppColors
                                                    .PrimaryBlackColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "List of Document to Upload ",
                                          style: FieldTextStyle(
                                              AppColors.PrimaryMainColor),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: documentdata[index]
                                                .studentMorDocument
                                                .length,
                                            itemBuilder: ((context, index1) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    alignment: Alignment.center,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10),
                                                            width: 195.w,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "${index1 + 1}.${documentdata[index].studentMorDocument[index1].fDocumentName}",
                                                                    maxLines: 3,
                                                                    style: batchtext1(
                                                                        AppColors
                                                                            .PrimaryBlackColor)),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                documentdata[index]
                                                                            .studentMorDocument[
                                                                                index1]
                                                                            .fDocumentStatus ==
                                                                        "1"
                                                                    ? Text(
                                                                        "Submitted successfully",
                                                                        maxLines:
                                                                            3,
                                                                        style: batchtext1(
                                                                            Colors.green))
                                                                    : Container()
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          check1 == true
                                                              ? Container()
                                                              : InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      check1 ==
                                                                          false;
                                                                    });
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            backgroundColor:
                                                                                AppColors.backgroungcolor,
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                                            content:
                                                                                UploadmoreDialog(
                                                                              applicationid: documentdata[index].fApplicationId,
                                                                              documentname: documentdata[index].studentMorDocument[index1].fDocumentName,
                                                                              check: check1,
                                                                              documentid: documentdata[index].studentMorDocument[index1].fDocument,
                                                                            ),
                                                                          );
                                                                        });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        40.h,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    width: 70.w,
                                                                    child: Text(
                                                                      "+ Upload",
                                                                      style: location(
                                                                          AppColors
                                                                              .PrimaryMainColor),
                                                                    ),
                                                                  ),
                                                                ),
                                                        ]),
                                                  )
                                                ],
                                              );
                                            })),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }))),
      ),
    );
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

// ignore: must_be_immutable
class UploadmoreDialog extends StatefulWidget {
  String? documentname;
  String? applicationid;
  String? documentid;
  bool? check;

  UploadmoreDialog({
    super.key,
    this.applicationid,
    this.documentname,
    this.documentid,
    this.check,
  });

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _UploadmoreDialogState createState() => _UploadmoreDialogState(
      applicationid: applicationid,
      documentname: documentname,
      check: check,
      documentid: documentid);
}

class _UploadmoreDialogState extends State<UploadmoreDialog> {
  String? documentname;
  String? applicationid;
  String? documentid;
  bool? check = true;

  _UploadmoreDialogState(
      {this.applicationid, this.documentname, this.check, this.documentid});
  late DashBoardBloc dashBoardBloc;
  List<UploadmoreDocument> documentdata = [];
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  File? file;

  List applicationdata = [];

  bool loading = true;

  List<File> selectedFile = [];
  List<TextEditingController> selectedfiledata = [];
  bool isFileSelected = false;

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();

    getUserDetails();

    _gethomeData();
    subimmeted();

    super.initState();
  }

  void subimmeted() async {
    dashBoardBloc.uploadmoredocumentcontrollerStream.listen((event) {
      Navigator.pop(context);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true && event.data["Status"] == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: Duration(milliseconds: 1000),
          content: Text("Document Submmited Succesfully"),
        ));
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.uploadmoredocument,
          (routes) => false,
        );
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

  getUserDetails() {
    dashBoardBloc.getmoredocumentcontrollerStream.listen((event) {
      if (event != null) {
        applicationdata = event;
        for (int i = 0; i < applicationdata.length; i++) {
          UploadmoreDocument applicationStatusModel =
              UploadmoreDocument.fromJson(event[i]);
          documentdata.add(applicationStatusModel);
        }

        setState(() {
          loading = false;
        });
      }
    });
  }

  _gethomeData() {
    dashBoardBloc.callUploadmoreDocumentApi();
  }

  void callUploadDocumentApi(
    String ai,
    String dn,
    String docementid,
  ) {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Map<String, dynamic> data = {
      NetworkConstant.Applicationid: ai,
      NetworkConstant.documentname: dn,
      "documentid": docementid.trim(),
    };

    dashBoardBloc.callUploadmoredocumentApi(
      data,
      selectedFile,
    );
  }

  String inputValue = "";
  final _registerkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return 
    Form(
      key: _registerkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 400.w,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Upload Your Document ",
              textAlign: TextAlign.center,
              style: FieldTextStyle(AppColors.PrimaryBlackColor),
            ),
          ),
          Text(
            documentname.toString(),
            style: batchtext1(AppColors.PrimaryMainColor),
          ),
          selectedFile.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 240,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${selectedFile.length} File ADDED",
                              style: batchtext2(AppColors.PrimaryBlackColor),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 0),
                          child: selectedFile.length <= 4
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        width: 1,
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 0),
                                    child: Column(
                                      children: [
                                        for (int i = 0;
                                            i < selectedFile.length;
                                            i++)
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  bankStatementWidget(i),
                                                  i == selectedFile.length - 1
                                                      ? Container(
                                                          // height: 10,
                                                          )
                                                      : Container()
                                                ],
                                              )
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        width: 1,
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          for (int i = 0;
                                              i < selectedFile.length;
                                              i++)
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    bankStatementWidget(i),
                                                    i == selectedFile.length - 1
                                                        ? Container()
                                                        : Container()
                                                  ],
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    right: 20,
                    left: 20,
                  ),
                  child: InkWell(
                    onTap: () {
                      selectFile();
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/uploadimg.png",
                                height: 80.h,
                                width: 80.w,
                              ),
                              Text(
                                "Supported file format(s): PDF or Dox 8 MB Max",
                                textAlign: TextAlign.center,
                                style: batchtext1(AppColors.hintcolor),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: 10.h,
          ),
          selectedFile.isEmpty
              ? Container()
              : SizedBox(
                  height: 35.h,
                  width: 130.w,
                  child: ButtonPrimary2(
                      title: " Upload ",
                      onPressed: () {
                        setState(() {});

                        callUploadDocumentApi(
                            applicationid.toString(),
                            documentname.toString().trim(),
                            documentid.toString());
                      })),
        ],
      ),
    );
 
  }

  void selectFile() async {
    if (selectedFile.length > 11) {
      // ToastHelper()
      //     .showErrorToast(message: 'File Cannot Select more than 12.');
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );

      if (result != null) {
        PlatformFile file = result.files.single;
        if (file.extension == 'pdf' || file.extension == 'docx') {
          if (file.size <= 8 * 1024 * 1024) {
            List<File> files = result.paths.map((path) => File(path!)).toList();
            if (files.length + selectedFile.length > 12) {
            } else {
              setState(() {
                selectedFile.addAll(files);

                isFileSelected = true;
              });
              for (int i = 0; i < selectedFile.length; i++) {
                TextEditingController controller = TextEditingController();
                selectedfiledata.add(controller);
              }
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
  }

 
  Widget bankStatementWidget(int index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 200.w,
        decoration: BoxDecoration(
            color: AppColors.PrimaryWhiteColor,
            border: Border.all(color: AppColors.hintcolor),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Flexible(
              child: Text(
                selectedFile[index].path.split('/').last,
                textAlign: TextAlign.start,
                style: batchtext1(AppColors.PrimaryBlackColor),
              ),
            ),
            InkWell(
              onTap: () {
                selectedFile.removeAt(index);
                setState(() {});
              },
              child: SizedBox(
                width: 25,
                height: 40,
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.cancel_outlined,
                    color: Colors.red.withOpacity(0.8),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
