import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

class ApiErrorDialog extends StatelessWidget {
  final Function onPressed;
  final String description;
  final String image;
  final String? btnText;

  const ApiErrorDialog(
      {super.key,
      required this.image,
      required this.description,
      required this.onPressed,
      this.btnText});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SimpleDialog(
        insetPadding: const EdgeInsets.all(15).w,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0).r,
            child: Container(
              width: 300.w,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 16.h,
                  ),
                  Image.asset(
                    image,
                    height: 94.h,
                    width: 114.w,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(description,
                      textAlign: TextAlign.center,
                      style: TextRegular(AppColors.PrimaryMainColor)),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 24, left: 24, right: 24, bottom: 8),
                    child: SizedBox(
                      width: 300,
                      child:
                          MediumBottonWithoutIcon(btnText ?? 'Okay', true, () {
                        onPressed();
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
