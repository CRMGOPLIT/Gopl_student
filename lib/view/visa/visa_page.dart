import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/button.dart';

import '../../utils/routes/routes_name.dart';

class VisaPage extends StatefulWidget {
  const VisaPage({super.key});

  @override
  State<VisaPage> createState() => _VisaPageState();
}

class _VisaPageState extends State<VisaPage> {
  String dropdownvalue = 'SDS';

  String selectedvalue = "";

  // List of items in our dropdown menu
  var items = [
    'SDS',
    'Non SDS',
  ];
  bool isSelected = false;

  void selected(_value) {
    if (_value == "Country") {
      Text("ne,");
    } else if (_value == "Item 2") {
      Text("ne,");
    }
    setState(() {
      dropdownvalue = _value;
      isSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Apply Visa",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.home);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text("State",
                  //     style: FieldTextStyle(
                  //       AppColors.PrimaryBlackColor,
                  //     )),
                  Container(
                      height: 50.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.PrimaryWhiteColor),
                      child: Center(
                          child: Text(
                        "Canada",
                        style: FieldTextStyle(AppColors.PrimaryMainColor),
                      ))),

                  Container(
                    height: 50.h,
                    width: 160.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.PrimaryWhiteColor),
                    child: DropdownButtonFormField(
                      // hint: Text("djkbkjbe"),
                      style: TextStyle(
                          color: AppColors.PrimaryMainColor,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                              color: AppColors.PrimaryGreyColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: AppColors.PrimaryBlackColor,
                            width: 1,
                          ),
                        ),
                      ),
                      value: dropdownvalue,
                      isExpanded: true,
                      icon: Padding(
                        padding: EdgeInsets.only(
                          right: 10.r,
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 25.sp,
                          color: AppColors.PrimaryMainColor,
                        ),
                      ),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.r),
                            child: Text(items),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedvalue = newValue!;
                          isSelected = true;
                          // selected(dropdownvalue);
                        });
                      },
                    ),
                  ),
                ],
              ),
              selectedvalue == "Non SDS"
                  ? const ApplyVisaone()
                  : const ApplyVisaTwo(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.r, left: 15.r, right: 15.r),
            child: ButtonPrimary(
              title: "Submit",
              onPressed: () {},
            ),
          )),
    );
  }
}

class ApplyVisaone extends StatelessWidget {
  const ApplyVisaone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Text("IMM 1294 From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("IMM 5654 From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("SPQ From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("Passport  copy color front and back page",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}

class ApplyVisaTwo extends StatelessWidget {
  const ApplyVisaTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Text("IMM 1294 From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("IMM 5654 From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("SPQ From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("Passport  copy color front and back page",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: AppColors.PrimaryWhiteColor,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 8, //or null
                decoration: InputDecoration.collapsed(
                  hintText: "Remarks",
                ),
              ),
            )),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
