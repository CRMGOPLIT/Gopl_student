import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/batchperformadetailsBloc.dart';
import 'package:global_student/model/paymentreceiptmodel.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/widget/loader.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/color.dart';
import '../widget/app_bar.dart';

class OurservicesReceipt extends StatefulWidget {
  const OurservicesReceipt({super.key});

  @override
  State<OurservicesReceipt> createState() => _OurservicesReceiptState();
}

class _OurservicesReceiptState extends State<OurservicesReceipt> {
  late BatchperformaBloc batchperformaBloc;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final _razorpay = Razorpay();

  BatchPerformaReceipt? batchPerformaReceipt;
  final List<PrintMain> printMaindata = [];
  final List<PrintDetail> printDetail = [];

  var invoiceid = Get.arguments;
  String? studentid;

  List performa = [];
  bool? loading = true;

  @override
  void initState() {
    batchperformaBloc = BatchperformaBloc();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
    getreciptcalldetails();
    getreciptDetails();
    paymentcall();
    succespayment();
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    verifySignature(
      signature: response.signature,
      paymentId: response.paymentId,
      orderId: response.orderId,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? ''),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

  getreciptDetails() {
    batchperformaBloc.batchpaymentreciptStream.listen((event) {
      if (event != null) {
        BatchPerformaReceipt batchPerformaReceipt =
            BatchPerformaReceipt.fromJson(event);

        printMaindata.addAll(batchPerformaReceipt.printMain);

        printDetail.addAll(batchPerformaReceipt.printDetail);
        setState(() {
          loading = false;
        });
      }
    });
  }

  paymentcall() {
    batchperformaBloc.createorderbatchStream.listen((event) {
      Navigator.pop(context);
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true && event.data["OrderId"] != "") {
        openGateway(event.data["OrderId"].toString());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(seconds: 2),
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
                      Text("Sorry!! Please Contact to Your counsellor",
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

  succespayment() {
    batchperformaBloc.veryfypaymentStream.listen((event) {
      Navigator.pop(context);

      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true && event.data['type'] == 'Payment Success') {
        sucess();
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.ourservices,
            (routes) => false,
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(milliseconds: 1000),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30.w,
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
                      Text(event.data["type"].toString(),
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

  openGateway(String orderId) {
    var options = {
      'key': "rzp_live_P7187dAkpioejt",
      'name': 'Global Opportunities',
      'order_id': orderId.toString(),
      'description': printDetail[0].fServiceName.toString(),
      'timeout': 60 * 5,
      'prefill': {
        'contact': printMaindata[0].fMobile.toString(),
        'email': printMaindata[0].fEmail.toString(),
      },
    };
    _razorpay.open(options);
  }

  getreciptcalldetails() async {
    Map<String, dynamic> data = {
      "f_InvoiceID": invoiceid[0].toString(),
      "erp": invoiceid[3].toString(),
    };

    batchperformaBloc.callreciptdetailsDetails(data);
  }

  searchFilter() {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Map<String, String> courseAppliedemail = {
      "amount": printMaindata[0].fGrandTotal.split(".")[0].toString(),
    };

    batchperformaBloc.callCreateOrder(courseAppliedemail);
  }

  void verifySignature({
    String? signature,
    String? paymentId,
    String? orderId,
  }) async {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");
    Map<String, String> data = {
      "f_CounsellorId": invoiceid[2].toString(),
      "f_BranchId": invoiceid[1].toString(),
      "f_StudentID": studentid.toString(),
      "f_TotalReceiveAmt":
          printMaindata[0].pendingAmount.toString(), //total amount
      "f_InvoiceNo": printMaindata[0].fProposalNo.toString(),
      "f_PaymentMode": "ByOnlineTransfer".toString(),
      "razorpay_payment_id": paymentId.toString(),
      "razorpay_order_id": orderId.toString(),
      "razorpay_signature": signature.toString(),
      "ErpService": invoiceid[3].toString(),
      "f_Receiveamt": printMaindata[0].totalAmount.toString()
    };

    batchperformaBloc.callVeryfiPayment(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Proforma Details",
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
                              printMaindata[0].fBranchAddress.toString(),
                              textAlign: TextAlign.center,
                              style: batchtext1(AppColors.PrimaryMainColor),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
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
                                printMaindata[0].fProposalNo.toString(),
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
                                printMaindata[0]
                                    .fProposalDate
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
                                printMaindata[0].fSubTotal.toString(),
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
                                printMaindata[0].fTaxAmount.toString(),
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
                                "Transactions Charge (2.36 %):",
                                style: batchtext1(AppColors.PrimaryBlackColor),
                              ),
                              Text(
                                printMaindata[0]
                                    .fGrandTotal236Percentage
                                    .toString(),
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
                                printMaindata[0].fGrandTotal.toString(),
                                textAlign: TextAlign.end,
                                style:
                                    batchtexthead(AppColors.PrimaryBlackColor),
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
                                printMaindata[0].fGrandTotal.toString(),
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
                              onTap: () {
                                searchFilter();
                              },
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

  sucess() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xffF2F9F6),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                  height: 90.h,
                  child: Lottie.asset("assets/images/sucess1.json",
                      fit: BoxFit.contain)),
            ],
          ),
        ),
        content: Text(
          "🤗 Hey, ${printMaindata[0].fStudentFullName.toString()}!Thank you for purchasing ${printDetail[0].fServiceName.toString()} . Your payment has been confirmed",
          textAlign: TextAlign.center,
          style: batchtext2(AppColors.PrimaryMainColor),
        ),
      ),
    );
  }
}
