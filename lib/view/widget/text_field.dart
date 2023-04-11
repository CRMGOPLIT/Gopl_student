import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/constant.dart';

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
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
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
                  color: AppColors.hintcolor,
                  fontFamily: Constant.font_poppins_bold,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                  letterSpacing: 1,
                  fontSize: 12.sp),
              fillColor: AppColors.PrimaryMainColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
