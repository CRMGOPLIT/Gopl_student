import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

import 'package:lottie/lottie.dart';

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error(
      {super.key, required this.errorMessage, required this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextRegular(Colors.black),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        )
      ],
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({super.key, required this.loadingMessage});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          key: key,
          backgroundColor: Colors.transparent,
          children: const [Center(child: CircularProgressIndicator())],
        ));
  }
}

class NetworkDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                key: key,
                backgroundColor: AppColors.backgroungcolor,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: SizedBox(
                              height: 50.h,
                              width: 50.w,
                              child: Lottie.asset("assets/images/loder.json")),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text("Loading please wait...",
                            style: TextRegular(AppColors.PrimaryMainColor)),
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}

class NetworkDialogLoading {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.1),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.PrimaryMainColor,
                  strokeWidth: 2.w,
                ),
              ));
        });
  }
}
