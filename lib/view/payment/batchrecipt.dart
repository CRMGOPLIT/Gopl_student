import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/batchperformadetailsBloc.dart';
import 'package:global_student/model/paymentreceiptmodel.dart';
import 'package:global_student/utils/text_style.dart';
import '../../utils/color.dart';
import '../widget/app_bar.dart';

class BatchReceipt extends StatefulWidget {
  const BatchReceipt({super.key});

  @override
  State<BatchReceipt> createState() => _BatchReceiptState();
}

class _BatchReceiptState extends State<BatchReceipt> {
  late BatchperformaBloc batchperformaBloc;

  PerformaBatch? printMain;
  final List<PrintDetail> printDetail = [];
  final List<MakePaymentLst> makePaymentLstdata = [];
  late final RefundDetails refundDetails;

  List performa = [];
  bool? loading = true;

  @override
  void initState() {
    batchperformaBloc = BatchperformaBloc();
    getreciptcalldetails();
    getreciptDetails();
    super.initState();
  }

  getreciptDetails() {
    batchperformaBloc.batchpaymentreciptStream.listen((event) {
      if (event != null) {
        printMain = PerformaBatch.fromJson(event);
        PerformaBatch printdetails = PerformaBatch.fromJson(event);
        printDetail.addAll(printdetails.printDetail);
        setState(() {
          loading = false;
        });
      }
    });
  }

  getreciptcalldetails() async {
    Map<String, dynamic> data = {
      "studentID": "1902979",
      "erp": "PROFORMA INVOICE",
      "f_InvoiceID": "MOHPI-2023-24-019553"
    };
    batchperformaBloc.callreciptdetailsDetails(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Batch Recipt",
            onpress: () {
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   RoutesName.batchperforma,
              //   (routes) => false,
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
          : Column(
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/images/bannerlogo.png",
                              height: 30.h,
                              width: 200.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Text(
                              printMain!.printMain.fBranchAddress.toString(),
                              // "Branch Name: HS 27, 2nd Floor Kailash Colony Market New Delhi ",
                              textAlign: TextAlign.center,
                              style: batchtext1(AppColors.PrimaryMainColor),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Text(
                              printDetail[0].fServiceName.toString(),
                              textAlign: TextAlign.end,
                              style: batchtexthead(AppColors.PrimaryBlackColor),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Performa Invoice No. :",
                                style: batchtext1(AppColors.PrimaryBlackColor),
                              ),
                              Text(
                                printMain!.printMain.fProposalNo.toString(),
                                textAlign: TextAlign.end,
                                style: batchtext2(AppColors.PrimaryBlackColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date :",
                                style: batchtext1(AppColors.PrimaryBlackColor),
                              ),
                              Text(
                                printMain!.printMain.fProposalDate
                                    .split(" ")[0]
                                    .toString(),
                                textAlign: TextAlign.end,
                                style: batchtext2(AppColors.PrimaryBlackColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quantity :",
                                style: batchtext1(AppColors.PrimaryBlackColor),
                              ),
                              Text(
                                printDetail[0].fQty.toString(),
                                textAlign: TextAlign.end,
                                style: batchtext2(AppColors.PrimaryBlackColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "UP/INR :",
                                style: batchtext1(AppColors.PrimaryBlackColor),
                              ),
                              Text(
                                printDetail[0].fSuggestedPrice.toString(),
                                textAlign: TextAlign.end,
                                style: batchtext2(AppColors.PrimaryBlackColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gst 18 % :",
                                style: batchtext1(AppColors.PrimaryBlackColor),
                              ),
                              Text(
                                printMain!.printMain.fTaxAmount.toString(),
                                textAlign: TextAlign.end,
                                style: batchtext2(AppColors.PrimaryBlackColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            height: 1.h,
                            color: AppColors.PrimaryBlackColor,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total :",
                                style:
                                    batchtexthead(AppColors.PrimaryBlackColor),
                              ),
                              Text(
                                printMain!.printMain.fSubTotal.toString(),
                                textAlign: TextAlign.end,
                                style: batchtext2(AppColors.PrimaryBlackColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            height: 1.h,
                            color: AppColors.PrimaryBlackColor,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amount Payable :",
                                style:
                                    batchtexthead(AppColors.PrimaryBlackColor),
                              ),
                              Text(
                                printMain!.printMain.fGrandTotal.toString(),
                                textAlign: TextAlign.end,
                                style: batchtexthead(Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                  width: 100.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.PrimaryMainColor,
                                      borderRadius: BorderRadius.circular(5).r),
                                  child: Center(
                                      child: Text(
                                    "Pay Now",
                                    style: batchtexthead(
                                        AppColors.PrimaryWhiteColor),
                                  ))),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "*E&OE",
                            style: batchtexthead(AppColors.PrimaryMainColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "(I) Cheques are subject to realization. (II) Fee once Paid will not be Refund. (III) Rights of admission reserved.",
                            style: batchtext1(Colors.red),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "(iv) Duties and taxes as applicable. (V) In case of loss of receipts.",
                            style: batchtext1(Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
