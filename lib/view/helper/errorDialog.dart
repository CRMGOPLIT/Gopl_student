import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

class ErrorDialog extends StatelessWidget {
  final Function onPressed;
  final String title;
  final String image;

  const ErrorDialog({
    super.key,
    required this.image,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SimpleDialog(
        insetPadding: const EdgeInsets.all(15),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              width: 300,
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
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextRegular(AppColors.PrimaryMainColor),
                  ),
// SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.only(
                            top: 24, left: 24, right: 24, bottom: 8)
                        .r,
                    child: SizedBox(
                      width: 300.w,
                      child: onPressed('Okay', true, () {
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
