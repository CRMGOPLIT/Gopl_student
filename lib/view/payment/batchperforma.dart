import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/batchperformadetailsBloc.dart';
import 'package:global_student/model/performaBatchModel.dart';
import 'package:global_student/utils/text_style.dart';

import '../../utils/color.dart';
import '../../utils/routes/routes_name.dart';
import '../widget/app_bar.dart';

class BatchPerforma extends StatefulWidget {
  const BatchPerforma({super.key});

  @override
  State<BatchPerforma> createState() => _BatchPerformaState();
}

class _BatchPerformaState extends State<BatchPerforma> {
  late BatchperformaBloc batchperformaBloc;

  List<PerformaBatch> performaBatch = [];

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
    batchperformaBloc.batchpaymentperformaStream.listen((event) {
      if (event != null) {
        performa = event;

        for (int i = 0; i < performa.length; i++) {
          PerformaBatch performaadd = PerformaBatch.fromJson(event[0]);

          performaBatch.add(performaadd);
        }
        setState(() {
          loading = false;
        });
      }
    });
  }

  getperformadetails() async {
    Map<String, dynamic> data = {"StudentID": "1902979", "ERP": ""};
    batchperformaBloc.callperformadetailsDetails(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: AppBarCustom(
              title: "Batch Performa",
              onpress: () {
                // Navigator.pushNamed(context, RoutesName.batchDetails
                //     // (routes) => false,
                //     );
                // Navigator.pushNamed(
                //   context,
                //   RoutesName.batchDetails,
                // );

                Get.back();
              },
            )),
        body: loading == true
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: AppColors.PrimaryMainColor,
              ))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: performaBatch.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10).r,
                        width: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10).r,
                            side: const BorderSide(
                              color: AppColors.PrimaryGreyColor,
                            ),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0).r,
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
                                  performaBatch[index].fService,
                                  style: batchtexthead(Colors.green),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  height: 1.h,
                                  color: AppColors.PrimaryBlackColor,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Performa Invoice No. :",
                                      style: batchtext1(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                    Text(
                                      performaBatch[index].fInvoiceId,
                                      textAlign: TextAlign.end,
                                      style: batchtext2(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Date of Invoice :",
                                      style: batchtext1(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                    Text(
                                      performaBatch[index].fInvoiceDate,
                                      style: batchtext2(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Payment Stage :",
                                      style: batchtext1(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                    Text(
                                      performaBatch[index].fStage,
                                      textAlign: TextAlign.center,
                                      style: batchtext2(Colors.red),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Amount :",
                                      style: batchtext1(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                    Text(
                                      "${performaBatch[index].fTotalAmt}\n( ${totalorgst(index)}${"0"} + ${performaBatch[index].fTaxAmount} Gst )",

                                      //\n(${totalorgst(index)}+${performaBatch[index].fTaxAmount} Gst)",
                                      // performaBatch[index].fTotalAmt,
                                      textAlign: TextAlign.end,
                                      style: batchtext2(
                                          AppColors.PrimaryBlackColor),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.h),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesName.batchrecipt,
                                      //(routes) => false,
                                    );
                                  },
                                  child: Container(
                                      width: 100.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                          color: AppColors.PrimaryMainColor,
                                          borderRadius:
                                              BorderRadius.circular(5).r),
                                      child: Center(
                                          child: Text(
                                        "Continue",
                                        style: batchtexthead(
                                            AppColors.PrimaryWhiteColor),
                                      ))),
                                ),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Card(
                                //       elevation: 5,
                                //       child: Container(
                                //         padding: const EdgeInsets.all(23).r,
                                //         child: Column(
                                //           children: [
                                //             Text(
                                //               "Date of payment",
                                //               style:
                                //                   batchtext1(AppColors.PrimaryBlackColor),
                                //             ),
                                //             SizedBox(
                                //               height: 5.h,
                                //             ),
                                //             Text(
                                //               "27 may 2023",
                                //               style:
                                //                   batchtext2(AppColors.PrimaryBlackColor),
                                //             )
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //     Card(
                                //       elevation: 5,
                                //       child: Container(
                                //         padding: const EdgeInsets.all(15).r,
                                //         child: Column(
                                //           children: [
                                //             Text(
                                //               "Total Amount",
                                //               style:
                                //                   batchtext1(AppColors.PrimaryBlackColor),
                                //             ),
                                //             SizedBox(
                                //               height: 5.h,
                                //             ),
                                //             Center(
                                //               child: Text(
                                //                 "7522.50 \n(6375.00 +1147.50 Gst)",
                                //                 textAlign: TextAlign.center,
                                //                 style:
                                //                     batchtext2(AppColors.PrimaryBlackColor),
                                //               ),
                                //             )
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Container(
                                //       height: 70.h,
                                //       width: 150.w,
                                //       padding: const EdgeInsets.all(15).r,
                                //       decoration: BoxDecoration(
                                //         color: AppColors.PrimaryGreyColor,
                                //       ),
                                //       child: Column(
                                //         children: [
                                //           Text(
                                //             "Performa Invoice No.",
                                //             style: batchtext1(AppColors.PrimaryBlackColor),
                                //           ),
                                //           SizedBox(
                                //             height: 5.h,
                                //           ),
                                //           Text(
                                //             "27 may 2023",
                                //             style: batchtext2(AppColors.PrimaryBlackColor),
                                //           )
                                //         ],
                                //       ),
                                //     ),
                                //     Container(
                                //       height: 70.h,
                                //       width: 150.w,
                                //       padding: const EdgeInsets.all(15).r,
                                //       decoration: BoxDecoration(
                                //         color: AppColors.PrimaryGreyColor,
                                //       ),
                                //       child: Column(
                                //         children: [
                                //           Text(
                                //             "Payment Stage",
                                //             style: batchtext1(AppColors.PrimaryBlackColor),
                                //           ),
                                //           SizedBox(
                                //             height: 5.h,
                                //           ),
                                //           Center(
                                //             child: Text(
                                //               "Pending",
                                //               textAlign: TextAlign.center,
                                //               style:
                                //                   batchtext2(AppColors.PrimaryBlackColor),
                                //             ),
                                //           )
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/performaimg.png",
                          height: 250.h,
                          width: 300.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  );
                }));
  }

  totalorgst(int i) {
    double totalamount = double.parse(performaBatch[i].fTotalAmt);
    double taxamount = double.parse(performaBatch[i].fTaxAmount);
    return totalamount - taxamount;
  }
}
