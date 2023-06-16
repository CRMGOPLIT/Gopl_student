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
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/button.dart';

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

    //userData1 = "" as UsersDetailsModel;
    _gethomeData();
    // SaveName();
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
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h), // here the desired height
        child: AppBarCustom(
          title: "Upload More Document",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.bottomnav);
          },
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: documentdata.isEmpty
                  ? Column(
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
                                  padding:
                                      EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Column(
                                      //   children: [
                                      //     Row(
                                      //       children: [
                                      //         Text(
                                      //           "Doument Name :- ",
                                      //           style: batchtext2(
                                      //               AppColors.PrimaryBlackColor),
                                      //         ),
                                      //         Text(
                                      //           documentdata[index]
                                      //               .studentMorDocument[index]
                                      //               .fDocumentName
                                      //               .toString(),
                                      //           style: batchtext2(
                                      //               AppColors.PrimaryMainColor),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ],
                                      // ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Text(
                                      //           "Doument Name",
                                      //           style: batchtext2(AppColors
                                      //               .PrimaryBlackColor),
                                      //         ),
                                      //         for (int i = 0;
                                      //             i <
                                      //                 documentdata[index]
                                      //                     .studentMorDocument
                                      //                     .length;
                                      //             i++)
                                      //           Text(
                                      //             documentdata[index]
                                      //                 .studentMorDocument[i]
                                      //                 .fDocumentName
                                      //                 .toString(),
                                      //             style: batchtext1(AppColors
                                      //                 .PrimaryMainColor),
                                      //           ),
                                      //       ],
                                      //     ),
                                      //     // Column(
                                      //     //   crossAxisAlignment:
                                      //     //       CrossAxisAlignment.start,
                                      //     //   children: [
                                      //     //     Text(
                                      //     //       "Doument Remarks",
                                      //     //       style: batchtext2(AppColors
                                      //     //           .PrimaryBlackColor),
                                      //     //     ),
                                      //     //     for (int i = 0;
                                      //     //         i <
                                      //     //             documentdata[index]
                                      //     //                 .studentMorDocument
                                      //     //                 .length;
                                      //     //         i++)
                                      //     //       Text(
                                      //     //         documentdata[index]
                                      //     //             .studentMorDocument[i]
                                      //     //             .fMoreDocRemark
                                      //     //             .toString(),
                                      //     //         style: batchtext1(AppColors
                                      //     //             .PrimaryMainColor),
                                      //     //       ),
                                      //     //   ],
                                      //     // )
                                      //   ],
                                      // ),

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
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Container(
                                      //       width: 170.w,
                                      //       // decoration: BoxDecoration(
                                      //       //     color: AppColors.PrimaryMainColor),
                                      //       child: Column(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: [
                                      //           Text(
                                      //             "Student Id",
                                      //             style: batchtext2(AppColors
                                      //                 .PrimaryBlackColor),
                                      //           ),
                                      //           Text(
                                      //             documentdata[index]
                                      //                 .fStudentId
                                      //                 .toString(),
                                      //             // documentdata[index]
                                      //             //     .studentMorDocument[index]
                                      //             //     .fMoreDocRemark
                                      //             //     .toString(),
                                      //             style: batchtext1(AppColors
                                      //                 .PrimaryBlackColor),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     Container(
                                      //       width: 110.w,
                                      //       // decoration: BoxDecoration(
                                      //       //     color: AppColors.PrimaryMainColor),
                                      //       child: Column(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: [
                                      //           Text(
                                      //             "Application ID",
                                      //             style: batchtext2(AppColors
                                      //                 .PrimaryBlackColor),
                                      //           ),
                                      //           Text(
                                      //             documentdata[index]
                                      //                 .fApplicationId
                                      //                 .toString(),
                                      //             // documentdata[index]
                                      //             //     .studentMorDocument[index]
                                      //             //     .fMoreDocRemark
                                      //             //     .toString(),
                                      //             style: batchtext1(AppColors
                                      //                 .PrimaryBlackColor),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),

                                      SizedBox(
                                        height: 5.h,
                                      ),

                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "Intake :- ",
                                      //       style:
                                      //           batchtext2(AppColors.PrimaryBlackColor),
                                      //     ),
                                      //     Text(
                                      //       documentdata[index].fIntake.toString(),
                                      //       style:
                                      //           batchtext1(AppColors.PrimaryBlackColor),
                                      //     ),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 5.h,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "University Name :- ",
                                      //       style:
                                      //           batchtext2(AppColors.PrimaryBlackColor),
                                      //     ),
                                      //     Text(
                                      //       documentdata[index]
                                      //           .universityApplied
                                      //           .toString(),
                                      //       style:
                                      //           batchtext1(AppColors.PrimaryBlackColor),
                                      //     ),
                                      //   ],
                                      // ),
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
                                      // Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     Text(
                                      //       "Current Position",
                                      //       style: batchtext2(
                                      //           AppColors.PrimaryBlackColor),
                                      //     ),
                                      //     Text(
                                      //       documentdata[index]
                                      //           .currentPosition
                                      //           .toString(),
                                      //       style: batchtext1(
                                      //           AppColors.PrimaryBlackColor),
                                      //     ),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 5.h,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "Course Name :- ",
                                      //       style:
                                      //           batchtext2(AppColors.PrimaryBlackColor),
                                      //     ),
                                      //     Text(
                                      //       documentdata[index].courseName.toString(),
                                      //       style:
                                      //           batchtext1(AppColors.PrimaryBlackColor),
                                      //     ),
                                      //   ],
                                      // ),

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
                                              style: batchtext2(
                                                  AppColors.PrimaryBlackColor),
                                            ),
                                            Text(
                                              documentdata[index]
                                                  .fIntake
                                                  .toString(),
                                              style: batchtext1(
                                                  AppColors.PrimaryBlackColor),
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
                                                          BorderRadius.circular(
                                                              5)),
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
                                                          width: 200,
                                                          child: Text(
                                                              "${index1 + 1}.${documentdata[index].studentMorDocument[index1].fDocumentName}",
                                                              maxLines: 3,
                                                              style: batchtext1(
                                                                  AppColors
                                                                      .PrimaryBlackColor)),
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        check1 == true
                                                            ? Container()
                                                            : InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    check1 ==
                                                                        false;
                                                                  });
                                                                  showDialog(
                                                                      // barrierColor:
                                                                      //     AppColors
                                                                      //         .backgroungcolor,
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
                                                                            applicationid:
                                                                                documentdata[index].fApplicationId,
                                                                            documentname:
                                                                                documentdata[index].studentMorDocument[index1].fDocumentName,
                                                                            check:
                                                                                check1,
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                                child:
                                                                    Container(
                                                                  // color: AppColors
                                                                  //     .PrimaryGreyColor,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width: 70.w,
                                                                  // height: 40,
                                                                  //color: AppColors.PrimaryMainColor,
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

                                      //     style: TextRegular(AppColors.PrimaryBlackColor)),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }))),
    );
  }
}

// ignore: must_be_immutable
class UploadmoreDialog extends StatefulWidget {
  String? documentname;
  String? applicationid;
  bool? check;

  UploadmoreDialog({
    super.key,
    this.applicationid,
    this.documentname,
    this.check,
  });

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _UploadmoreDialogState createState() => _UploadmoreDialogState(
      applicationid: applicationid, documentname: documentname, check: check);
}

class _UploadmoreDialogState extends State<UploadmoreDialog> {
  String? documentname;
  String? applicationid;
  bool? check = true;

  _UploadmoreDialogState({this.applicationid, this.documentname, this.check});
  late DashBoardBloc dashBoardBloc;
  List<UploadmoreDocument> documentdata = [];
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

    //userData1 = "" as UsersDetailsModel;
    _gethomeData();
    // SaveName();
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

  void callUploadDocumentApi(
    String ai,
    String dn,
  ) {
    Map data = {
      NetworkConstant.Applicationid: ai,
      NetworkConstant.documentname: dn,
    };

    dashBoardBloc.callUploadmoredocumentApi(
      data,
      selectedFile,
    );
    // debugger();
    // print(data);
    // }
  }

  final _registerkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 400,
            // color: AppColors.hintcolor,
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
          // Text(applicationid.toString()),
          // Text(check.toString()),
          // Text(
          //   file!.path.split('/').last,
          //   style: batchtext2(AppColors.PrimaryMainColor),
          // ),
          selectedFile.length > 0
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
                            InkWell(
                              onTap: () {
                                selectFile();
                              },
                              child: Text(
                                "+Add File",
                                style: location(AppColors.PrimaryMainColor),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 0),
                          child: selectedFile.length <= 4
                              ? Container(
                                  // height: Get.height / 3.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        width: 1,
                                        // color: AppColors.DividerColor,
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
                                        // color: AppColors.DividerColor,
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
                                "Supported file format(s): PDF or Dox 20 MB Max",
                                textAlign: TextAlign.center,
                                style: batchtext1(AppColors.hintcolor),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),

                              // Icon(
                              //   Icons.add,
                              //   size: 30.sp,
                              //   color: AppColors.PrimaryMainColor,
                              // ),
                              // SvgPicture.asset(
                              //   ImageUtils.Upload_Icon,
                              //   height: Get.height / 12,
                              //   width: Get.width / 10,
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Text(
                              //   "Browse File",
                              // ),
                              // SizedBox(
                              //   height: 8,
                              // ),
                              // Text(
                              //   "Maximum File Size: 20 MB",
                              // ),
                              // SizedBox(
                              //   height: 4,
                              // ),
                              // Text(
                              //   "Supported file format(s): PDF ,",
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: 10,
          ),

          selectedFile.length < 1
              ? Container()
              : SizedBox(
                  // margin: EdgeInsets.all(10),
                  height: 35,
                  width: 130,
                  child: ButtonPrimary2(
                      title: " Upload ",
                      onPressed: () {
                        setState(() {});
                        callUploadDocumentApi(
                          applicationid.toString(),
                          documentname.toString().trim(),
                        );
                      })),
          // selectedfiledata.length > 0
          //     ? Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             selectedfiledata.length.toString() + " FILE(S) ADDED",
          //           ),
          //           InkWell(
          //             onTap: () {
          //               selectFile();
          //             },
          //             child: Text(
          //               "+Add Another",
          //             ),
          //           ),
          //         ],
          //       )
          //     : Container(
          //         height: 100.w,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(4),
          //             border: Border.all(
          //               width: 1,
          //               //color: AppColors.DividerColor,
          //             )),
          //         child: Padding(
          //           padding: const EdgeInsets.only(top: 0, bottom: 0),
          //           child: SingleChildScrollView(
          //             child: Column(
          //               children: [
          //                 for (int i = 0; i < selectedfiledata.length; i++)
          //                   bankStatementWidget(i)
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),

          // ElevatedButton(
          //   onPressed: () {
          //     selectFile();
          //   },
          //   child: Text('Select Files'),
          // ),

          //           Expanded(
          //             child: ListView.builder(
          //                 itemCount: documentdata.length,
          //                 itemBuilder: ((context, index) {
          //                   return Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       for (int i = 0;
          //                           i < documentdata[index].studentMorDocument.length;
          //                           i++)
          //                         Padding(
          //                           padding: const EdgeInsets.all(8.0),
          //                           child: Container(
          //                             height: 150,
          //                             width: 300,
          //                             decoration: BoxDecoration(
          //                                 color: AppColors.PrimaryWhiteColor,
          //                                 borderRadius: BorderRadius.circular(10)),
          //                             child: Column(
          //                               mainAxisAlignment: MainAxisAlignment.center,
          //                               children: [
          //                                 Text(
          //                                   "${i + 1}.  " +
          //                                       documentdata[index]
          //                                           .studentMorDocument[i]
          //                                           .fMoreDocRemark
          //                                           .toString(),
          //                                   style: batchtext2(AppColors.PrimaryMainColor),
          //                                 ),
          //                                 SizedBox(
          //                                   height: 5.h,
          //                                 ),
          //                                 GestureDetector(
          //                                   onTap: () async {
          //                                     // FilePickerResult? result =
          //                                     //     await FilePicker.platform.pickFiles(
          //                                     //   allowMultiple: false,
          //                                     //   allowedExtensions: ['pdf', 'docx'],
          //                                     //   type: FileType.custom,
          //                                     // );

          //                                     // if (result != null) {
          //                                     //   setState(() {
          //                                     //     file = File(result.files.single.path!);
          //                                     //   });
          //                                     // }
          //                                     // FilePickerResult? result =
          //                                     //     await FilePicker.platform.pickFiles();
          //                                     // if (result != null) {
          //                                     //   setState(() {
          //                                     //     _filePaths[_selectedIndex = i] =
          //                                     //         result.files.single.path!;
          //                                     //   });

          //                                     //   //   // await _uploadFile(index);
          //                                     // }
          //                                     //  _selectedItems[i] = _selectedItems[i];

          //                                     selectFiles(_selectedIndex = i);

          //                                     log(i.toString());
          //                                   },
          //                                   child: Container(
          //                                       height: 40.h,
          //                                       width: 170.w,
          //                                       decoration: BoxDecoration(
          //                                           border: Border.all(
          //                                               color:
          //                                                   AppColors.PrimaryBlackColor),
          //                                           borderRadius:
          //                                               BorderRadius.circular(10.r)),
          //                                       child: (file == null)
          //                                           ? Container(
          //                                               decoration: BoxDecoration(
          //                                                   color: Colors.white,
          //                                                   borderRadius:
          //                                                       BorderRadius.circular(
          //                                                           10)),
          //                                               child: Row(
          //                                                 mainAxisAlignment:
          //                                                     MainAxisAlignment
          //                                                         .spaceBetween,
          //                                                 children: [
          //                                                   Padding(
          //                                                       padding: EdgeInsets.only(
          //                                                           left: 20.r, right: 0),
          //                                                       child: Row(
          //                                                           // mainAxisAlignment:
          //                                                           //     MainAxisAlignment.end,
          //                                                           children: [
          //                                                             Text("Upload File"),
          //                                                             Center(
          //                                                                 child: Row(
          //                                                               mainAxisAlignment:
          //                                                                   MainAxisAlignment
          //                                                                       .end,
          //                                                               children: [
          //                                                                 Container(
          //                                                                     color: Colors
          //                                                                         .transparent,
          //                                                                     margin: EdgeInsets.only(
          //                                                                         left: 10
          //                                                                             .r),
          //                                                                     width: 20.w,
          //                                                                     child: Row(
          //                                                                       mainAxisAlignment:
          //                                                                           MainAxisAlignment
          //                                                                               .end,
          //                                                                       children: [
          //                                                                         // Container(
          //                                                                         //   height:
          //                                                                         //       50,
          //                                                                         //   width:
          //                                                                         //       2,
          //                                                                         //   color:
          //                                                                         //       AppColors.PrimaryGreyColor,
          //                                                                         // ),
          //                                                                         // Container(
          //                                                                         //   height:
          //                                                                         //       50.h,
          //                                                                         //   width:
          //                                                                         //       10.w,
          //                                                                         //   decoration: BoxDecoration(
          //                                                                         //       color: Colors.white
          //                                                                         //       // color: AppColors
          //                                                                         //       //     .PrimaryGreyColor,
          //                                                                         //       // border: Border.all(
          //                                                                         //       //     color: AppColors
          //                                                                         //       //         .PrimaryGreyColor),
          //                                                                         //       // borderRadius:
          //                                                                         //       //     const BorderRadius
          //                                                                         //       //             .only(
          //                                                                         //       //         topRight: Radius
          //                                                                         //       //             .circular(
          //                                                                         //       //                 10),
          //                                                                         //       //         bottomRight: Radius
          //                                                                         //       //             .circular(
          //                                                                         //       //                 10))
          //                                                                         //       ),
          //                                                                         //   child:
          //                                                                         //       Row(
          //                                                                         //     mainAxisAlignment:
          //                                                                         //         MainAxisAlignment.center,
          //                                                                         //     children: [
          //                                                                         //       Icon(Icons.attach_file),
          //                                                                         //       Text(
          //                                                                         //         "Attach",
          //                                                                         //         style: btntext(AppColors.PrimaryBlackColor),
          //                                                                         //       )
          //                                                                         //     ],
          //                                                                         //   ),
          //                                                                         // )
          //                                                                       ],
          //                                                                     )
          //                                                                     //Text(file!.path!.split('/').last),
          //                                                                     ),
          //                                                               ],
          //                                                             )),
          //                                                           ])
          //                                                       // : Row(
          //                                                       //     children: [
          //                                                       //       Image.asset(
          //                                                       //         "assets/images/docx.png",
          //                                                       //         height: 20.h,
          //                                                       //       ),
          //                                                       //       Center(
          //                                                       //           child: Container(
          //                                                       //         margin: EdgeInsets.only(
          //                                                       //             left: 10.r),
          //                                                       //         width: 250.w,
          //                                                       //         child: Text(file!.path!
          //                                                       //             .split('/')
          //                                                       //             .last),
          //                                                       //       )),
          //                                                       //     ],
          //                                                       //   )
          //                                                       ),
          //                                                 ],
          //                                               ),
          //                                             )
          //                                           :
          // Container(
          //                                               decoration: BoxDecoration(
          //                                                   color: Colors.white,
          //                                                   borderRadius:
          //                                                       BorderRadius.circular(
          //                                                           10)),
          //                                               child: Row(
          //                                                 mainAxisAlignment:
          //                                                     MainAxisAlignment
          //                                                         .spaceBetween,
          //                                                 children: [
          //                                                   Padding(
          //                                                       padding: EdgeInsets.only(
          //                                                           left: 20.r, right: 0),
          // //
          //                                                       child:
          //                                                           //(file!.path.split(".pdf")[0] == "pdf")
          //                                                           // ? Row(
          //                                                           //     // mainAxisAlignment:
          //                                                           //     //     MainAxisAlignment.end,
          //                                                           //     children: [
          //                                                           //         const Icon(
          //                                                           //           Icons.picture_as_pdf,
          //                                                           //           color: Colors.red,
          //                                                           //         ),
          //                                                           //         SizedBox(
          //                                                           //           width: 10.w,
          //                                                           //         ),
          //                                                           //         Text(file!.path
          //                                                           //             .split('/')
          //                                                           //             .last),
          //                                                           //       ])
          //                                                           Row(
          //                                                         children: [
          //                                                           Icon(
          //                                                             Icons.file_copy,
          //                                                             color: AppColors
          //                                                                 .PrimaryMainColor,
          //                                                           ),
          //                                                           Center(
          //                                                               child: Container(
          //                                                             margin:
          //                                                                 EdgeInsets.only(
          //                                                                     left: 10.r),
          //                                                             width: 50.w,
          //                                                             child: Text(
          //                                                               file!.path
          //                                                                   .split('/')
          //                                                                   .last,
          //                                                               style: batchtext2(
          //                                                                   AppColors
          //                                                                       .PrimaryMainColor),
          //                                                             ),
          //                                                           )),
          //                                                         ],
          //                                                       )),
          //                                                 ],
          //                                               ),
          //                                             )),
          //                                 ),
          //                                 SizedBox(
          //                                   height: 10,
          //                                 ),
          //                                 Container(
          //                                     height: 30.h,
          //                                     width: 100.w,
          //                                     decoration: BoxDecoration(
          //                                         borderRadius: BorderRadius.circular(5),
          //                                         color: AppColors.PrimaryMainColor),
          //                                     child: Center(
          //                                       child: Text(
          //                                         "Upload",
          //                                         style: batchtext2(
          //                                             AppColors.PrimaryWhiteColor),
          //                                       ),
          //                                     )),
          //                               ],
          //                             ),
          //                           ),
          //                         ),

          //                       SizedBox(
          //                         height: 40.h,
          //                       ),
          //                       // Center(
          //                       //   child: Container(
          //                       //       height: 20.h, width: 100.w, child: Text("wi")),
          //                       // )
          //                     ],
          //                   );
          //                 })),
          //           )
        ],
      ),
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

  void selectFile() async {
    if (selectedFile.length > 11) {
      // ToastHelper().showErrorToast(message: 'File Cannot Select more than 12.');
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        if (files.length + selectedFile.length > 12) {
          // ToastHelper()
          //     .showErrorToast(message: 'File Cannot Select more than 12.');
        } else {
          setState(() {
            selectedFile.addAll(files);
            // selectedFilePassword.a
            isFileSelected = true;
          });
          for (int i = 0; i < selectedFile.length; i++) {
            TextEditingController controller = TextEditingController();
            selectedfiledata.add(controller);
          }
        }
      } else {
        //user cancle here

        // User canceled the picker
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
              child: Container(
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
