import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/batchperformadetailsBloc.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/payment/batchrecipt.dart';
import '../../model/perfomacreatelistModel.dart';
import '../../utils/color.dart';
import '../widget/app_bar.dart';

class BatchPerforma extends StatefulWidget {
  const BatchPerforma({super.key});

  @override
  State<BatchPerforma> createState() => _BatchPerformaState();
}

class _BatchPerformaState extends State<BatchPerforma> {
  late BatchperformaBloc batchperformaBloc;
  Performacreatelist? performacreatelist;

  final List<Miscellaneous> testPrep = [];

  List performa = [];
  bool? loading = true;

  @override
  void initState() {
    batchperformaBloc = BatchperformaBloc();
    getperformadetails();
    getgofairDetails();
    super.initState();
  }

  getgofairDetails() {
    batchperformaBloc.getperformacreateStream.listen((event) {
      if (event != null) {
        Performacreatelist performaadd = Performacreatelist.fromJson(event);

        testPrep.addAll(performaadd.testPrep);
      }

      setState(() {
        loading = false;
      });
      //}
    });
  }

  getperformadetails() async {
    batchperformaBloc.callPerformaCreateApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: AppBarCustom(
              title: "Batch Proforma",
              onpress: () {
                Get.back();
              },
            )),
        body: loading == true
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: AppColors.PrimaryMainColor,
              ))
            : testPrep.isEmpty
                ? Center(
                    child: Image.asset(
                    "assets/images/performaimg.png",
                    height: 250.h,
                    width: 300.w,
                    fit: BoxFit.contain,
                  ))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: testPrep.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  testPrep[index].fStage == "PENDING"
                                      ? Container(
                                          padding: const EdgeInsets.all(10).r,
                                          width: double.infinity,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10).r,
                                              side: const BorderSide(
                                                color:
                                                    AppColors.PrimaryGreyColor,
                                              ),
                                            ),
                                            elevation: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0).r,
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Image.asset(
                                                      "assets/images/bannerlogo.png",
                                                      height: 40.h,
                                                      width: 300.w,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Text(
                                                    testPrep[index].fService,
                                                    style: batchtexthead(
                                                        Colors.green),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Container(
                                                    height: 1.h,
                                                    color: AppColors
                                                        .PrimaryBlackColor,
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Performa Invoice No. :",
                                                        style: batchtext1(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                      Text(
                                                        testPrep[index]
                                                            .fInvoiceId,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: batchtext2(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Date of Invoice :",
                                                        style: batchtext1(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                      Text(
                                                        testPrep[index]
                                                            .fInvoiceDate
                                                            .split(" ")[0]
                                                            .toString(),
                                                        style: batchtext2(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Payment Stage :",
                                                        style: batchtext1(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                      Text(
                                                        testPrep[index]
                                                            .fStage
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: batchtext2(
                                                            testPrep[index]
                                                                        .fStage ==
                                                                    "PENDING"
                                                                ? Colors.red
                                                                : Colors.green),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "BasePriceAndTax :",
                                                        style: batchtext1(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                      Text(
                                                        testPrep[index]
                                                            .basePriceAndTax,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: batchtext2(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Total Amount :",
                                                        style: batchtext1(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                      Text(
                                                        testPrep[index]
                                                            .fTotalAmt,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: batchtext2(AppColors
                                                            .PrimaryBlackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 30.h),
                                                  testPrep[index].fStage ==
                                                          "PENDING"
                                                      ? InkWell(
                                                          onTap: () {
                                                            Get.to(
                                                                () =>
                                                                    const BatchReceipt(),
                                                                arguments: [
                                                                  testPrep[
                                                                          index]
                                                                      .fInvoiceId,
                                                                  testPrep[
                                                                          index]
                                                                      .currentBranch,
                                                                  testPrep[
                                                                          index]
                                                                      .currentCounsellor,
                                                                  testPrep[
                                                                          index]
                                                                      .fSubCategoryName,
                                                                ]);
                                                          },
                                                          child: Container(
                                                              width: 100.w,
                                                              height: 40.h,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .PrimaryMainColor,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                              5)
                                                                          .r),
                                                              child: Center(
                                                                  child: Text(
                                                                "Continue",
                                                                style: batchtexthead(
                                                                    AppColors
                                                                        .PrimaryWhiteColor),
                                                              ))),
                                                        )
                                                      : Container(
                                                          width: 100.w,
                                                          height: 40.h,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .green
                                                                  .withOpacity(
                                                                      0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                          .circular(
                                                                              5)
                                                                      .r),
                                                          child: Center(
                                                              child: Text(
                                                            "Payment Done",
                                                            style: batchtexthead(
                                                                Colors.white
                                                                    .withOpacity(
                                                                        0.9)),
                                                          ))),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            SizedBox(
                                              height: 200.h,
                                            ),
                                            Center(
                                                child: Image.asset(
                                              "assets/images/performaimg.png",
                                              height: 250.h,
                                              width: 300.w,
                                              fit: BoxFit.contain,
                                            )),
                                          ],
                                        )
                                ],
                              );
                            }),
                      ),
                    ],
                  ));
  }

  
}
