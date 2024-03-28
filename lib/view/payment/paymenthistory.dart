import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/model/paymenthistory.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';
import '../../bloc/batchperformadetailsBloc.dart';

class PaymentHistoryData extends StatefulWidget {
  const PaymentHistoryData({super.key});

  @override
  State<PaymentHistoryData> createState() => _PaymentHistoryDataState();
}

class _PaymentHistoryDataState extends State<PaymentHistoryData> {
  late BatchperformaBloc batchperformaBloc;
  late PaymentHistory? paymentHistory;

  List<PaymentRazorPayHistory> paymentRazorPayHistory = [];

  List performa = [];
  bool? loading = true;

  @override
  void initState() {
    batchperformaBloc = BatchperformaBloc();
    gethistorydetails();
    getallhistoryDetails();
    super.initState();
  }

  getallhistoryDetails() {
    batchperformaBloc.batchpaymentperformaStream.listen((event) {
      if (event != null) {
        PaymentHistory paymenthis = PaymentHistory.fromJson(event);
        paymentRazorPayHistory.addAll(paymenthis.paymentRazorPayHistory);
      }

      setState(() {
        loading = false;
      });
    });
  }

  gethistorydetails() async {
    batchperformaBloc.callhistoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Payment History",
            onpress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.bottomnav,
                (routes) => false,
              );
            },
          )),
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(
                  strokeWidth: 2.w, color: AppColors.PrimaryMainColor))
          : paymentRazorPayHistory.isNotEmpty
              ? ListView.builder(
                  itemCount: paymentRazorPayHistory.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10).r,
                          margin: const EdgeInsets.only(bottom: 2).r,
                          width: double.infinity,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10).r,
                              side: const BorderSide(
                                color: AppColors.PrimaryGreyColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0).r,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "PAID".toString(),
                                        style: batchtexthead(Colors.green),
                                      ),
                                      Text(
                                        paymentRazorPayHistory[index]
                                            .fReceiptNo
                                            .toString(),
                                        style: batchtext1(
                                            AppColors.PrimaryBlackColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    paymentRazorPayHistory[index]
                                        .fServiceName
                                        .toString(),
                                    style: batchtexthead(
                                        AppColors.PrimaryBlackColor),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    paymentRazorPayHistory[index]
                                        .fTotalReceiveAmt
                                        .toString(),
                                    style: batchtexthead(
                                        AppColors.PrimaryBlackColor),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    paymentRazorPayHistory[index]
                                        .fPaymentDate
                                        .split(" ")[0]
                                        .toString(),
                                    style: batchtext1(AppColors.hintcolor),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    "Payment mode : ${paymentRazorPayHistory[index].fPaymentMode.toString()}",
                                    style:
                                        batchtext2(AppColors.PrimaryBlackColor),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(
                                      "assets/images/bannerlogo.png",
                                      height: 20.h,
                                      width: 100.w,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  })
              : Center(
                  child: Image.asset(
                    "assets/images/payimg.png",
                    height: 350.h,
                    width: 400.w,
                    fit: BoxFit.contain,
                  ),
                ),
    );
  }
}
