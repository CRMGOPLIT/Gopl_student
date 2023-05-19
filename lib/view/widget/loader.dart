import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

import 'package:lottie/lottie.dart';

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({required this.errorMessage, required this.onRetryPressed});

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
              SizedBox(height: 8),
              // RaisedButton(
              //   color: AppColors.PrimaryColor,
              //   child: Text('Retry', style: textStyle()),
              //   onPressed: () {
              //     onRetryPressed();
              //   },
              // )
            ],
          ),
        )
      ],
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({required this.loadingMessage});

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
        // barrierColor: AppColors.GreyScaleDarkG5Color.withOpacity(0.5),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                key: key,
                // shape: ShapeBorder,
                //  shape: BoxShape.circle,
                backgroundColor: AppColors.backgroungcolor,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Container(
                              height: 50,
                              width: 50,
                              child: Lottie.asset("assets/images/loder.json")),
                        ),
                        SizedBox(
                          height: 10,
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
                  child: Lottie.asset("assets/images/loader.json",
                      height: 320.h, width: 250.w)
                  // CircularProgressIndicator(
                  //   color: AppColors.PrimaryMainColor,
                  //   strokeWidth: 3.w,
                  // ),
                  ));
        });
  }
}
