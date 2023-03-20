import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';

import '../../utils/text_style.dart';

class TextFormWidget extends StatelessWidget {
  String? title;
  String? hint;
  final List<TextInputFormatter>? inputFormatters;
  TextEditingController? controller;

  final String? Function(String?)? validator;
  TextInputType? keyboardType;

  TextFormWidget(
      {super.key,
      required this.title,
      required this.hint,
      this.inputFormatters,
      this.controller,
      this.validator,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        TextFormField(
          inputFormatters: inputFormatters,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          // validator:((value) => {
          //   valid();
          // },
          // [
          style: batchtext2(AppColors.PrimaryMainColor),
          // ],
          cursorColor: AppColors.PrimaryBlackColor,
          decoration: InputDecoration(
            hintText: "$hint",
            hintStyle: TextStyle(
                color: AppColors.PrimaryMainColor, fontWeight: FontWeight.w400),
            fillColor: AppColors.PrimaryMainColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.PrimaryMainColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: AppColors.PrimaryMainColor,
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
