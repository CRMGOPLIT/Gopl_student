import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';

import '../../utils/text_style.dart';

class TextFormWidget extends StatelessWidget {
  String? title;
  String? hint;

  TextFormWidget({super.key, required this.title, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title",
            style: H2TextStyle(
              AppColors.PrimaryBlackColor,
            )),
        TextFormField(
          cursorColor: AppColors.PrimaryBlackColor,
          decoration: InputDecoration(
            hintText: "$hint",
            fillColor: AppColors.PrimaryMainColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color.fromRGBO(217, 217, 217, 1),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: AppColors.PrimaryBlackColor,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
