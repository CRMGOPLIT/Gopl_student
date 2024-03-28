import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/helper/apiResponseHelper.dart';
import 'package:global_student/view/widget/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/searchBloc.dart';
import '../../utils/routes/routes_name.dart';
import '../widget/app_bar.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  String? token;

  late SearchBloc searchBloc;
  @override
  void initState() {
    searchBloc = SearchBloc();
    super.initState();
    searchBloc.deleteaccountStream.listen((event) {
      bool response =
          ApiResponseHelper().handleResponse(event: event, context: context);

      if (response == true && event.data['Status'] == 'Success') {
        Timer(const Duration(milliseconds: 3000), () {
          removeValues();
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.login,
            (routes) => false,
          );
        });
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

  deleteaccount() {
    NetworkDialog.showLoadingDialog(context, _keyLoader);

    searchBloc.callDeleteAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Delete Account",
          onpress: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.bottomnav,
              (routes) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you sure you want to delete? Please read how deletion will affect ?.",
                style: batchtext2(AppColors.PrimaryBlackColor),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Account",
                style: batchtext2(AppColors.PrimaryBlackColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Deleting your account removes personal information from our database. Your mobile & email becomes permanently reserved and same email & mobile cannot be re-used to register a new account.",
                style: batchtext1(AppColors.PrimaryBlackColor),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Email & Mobile Subscription",
                style: batchtext2(AppColors.PrimaryBlackColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Deleting your account will unsubscribe you from all mailing lists.",
                style: batchtext1(AppColors.PrimaryBlackColor),
              ),
              SizedBox(
                height: 55.h,
              ),
              Center(
                child: Container(
                  height: 40.h,
                  width: 150.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Are you sure Delete Account ?",
                          backgroundColor: AppColors.PrimaryWhiteColor,
                          titleStyle: btntext(AppColors.PrimaryMainColor),
                          titlePadding: EdgeInsets.all(10.sp),
                          textConfirm: "  Ok ",
                          textCancel: "Cancel",
                          cancelTextColor: AppColors.PrimaryMainColor,
                          confirmTextColor: Colors.white,
                          buttonColor: AppColors.PrimaryMainColor,
                          barrierDismissible: false,
                          radius: 10.r,
                          onConfirm: () {
                            Navigator.pop(context);
                            deleteaccount();
                          },
                          content: Container());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.PrimaryMainColor,
                        textStyle: OtpText(Colors.green),
                        shadowColor: Colors.transparent,
                        elevation: 10),
                    child: Center(
                      child: Text("Delete Account".toUpperCase(),
                          style: batchtext2(
                            AppColors.PrimaryWhiteColor,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.remove("stringValue").toString();
  }
}
