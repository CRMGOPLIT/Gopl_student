import 'package:flutter/material.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

class ApiErrorDialog extends StatelessWidget {
  final Function onPressed;
  final String description;
  final String image;
  final String? btnText;

  ApiErrorDialog(
      {required this.image,
      required this.description,
      required this.onPressed,
      this.btnText});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SimpleDialog(
        insetPadding: EdgeInsets.all(15),
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
                // mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Image.asset(
                    image,
                    height: 94,
                    width: 114,
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  Text(description,
                      textAlign: TextAlign.center,
                      style: TextRegular(AppColors.PrimaryMainColor)),
// SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 24, left: 24, right: 24, bottom: 8),
                    child: Container(
                      width: 300,
                      child:
                          MediumBottonWithoutIcon(btnText ?? 'Okay', true, () {
                        onPressed();
                      }),
                    ),
                  ),

                  // SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}