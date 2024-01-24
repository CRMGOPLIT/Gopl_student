import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
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
        body: ListView.builder(
            itemCount: 10,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "PAID",
                                  style: batchtexthead(Colors.green),
                                ),
                                Text(
                                  "Serial No :- RCPT-DEL-2023-24-018503",
                                  style:
                                      batchtext1(AppColors.PrimaryBlackColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "IELTS Coaching 1 Month With Books(Online)",
                              style: batchtexthead(AppColors.PrimaryBlackColor),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "₹70000.00",
                              style: batchtexthead(AppColors.PrimaryBlackColor),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "Paid on 03 Dec, 2023 02:35 PM",
                              style: batchtext1(AppColors.hintcolor),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "Payment mode : UPI",
                              style: batchtext2(AppColors.PrimaryBlackColor),
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
            }));
  }
}
