import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/widget/text_field.dart';

import '../../utils/text_style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PrimaryWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.PrimaryWhiteColor,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 30.sp,
        ),
        centerTitle: true,
        title: Text(
          "Registration",
          style: H1TextStyle(AppColors.PrimaryBlackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormWidget(
                hint: "Enter Your name",
                title: "Enter Name",
              ),
              Text("Enter Name",
                  style: H2TextStyle(
                    AppColors.PrimaryBlackColor,
                  )),
              Container(
                height: 50.h,
                width: 480.w,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                child: DropdownButtonFormField(
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
                    padding: EdgeInsets.only(right: 10.r),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30.sp,
                      color: AppColors.PrimaryBlackColor,
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
                      isSelected = true;
                    });
                  },
                ),
              ),

              // SizedBox(
              //   height: 10.h,
              // ),
              // Text("Enter Name",
              //     style: H2TextStyle(
              //       AppColors.PrimaryBlackColor,
              //     )),
              // TextFormField(
              //   cursorColor: AppColors.PrimaryBlackColor,
              //   decoration: InputDecoration(
              //     hintText: "Enter Your Name",
              //     fillColor: AppColors.PrimaryMainColor,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryGreyColor,
              //         width: 2.0,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryBlackColor,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text("Enter Name",
              //     style: H2TextStyle(
              //       AppColors.PrimaryBlackColor,
              //     )),
              // TextFormField(
              //   cursorColor: AppColors.PrimaryBlackColor,
              //   decoration: InputDecoration(
              //     hintText: "Enter Your Name",
              //     fillColor: AppColors.PrimaryMainColor,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryGreyColor,
              //         width: 2.0,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryBlackColor,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text("Enter Name",
              //     style: H2TextStyle(
              //       AppColors.PrimaryBlackColor,
              //     )),
              // TextFormField(
              //   cursorColor: AppColors.PrimaryBlackColor,
              //   decoration: InputDecoration(
              //     hintText: "Enter Your Name",
              //     fillColor: AppColors.PrimaryMainColor,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryGreyColor,
              //         width: 2.0,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryBlackColor,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text("Enter Name",
              //     style: H2TextStyle(
              //       AppColors.PrimaryBlackColor,
              //     )),
              // TextFormField(
              //   cursorColor: AppColors.PrimaryBlackColor,
              //   decoration: InputDecoration(
              //     hintText: "Enter Your Name",
              //     fillColor: AppColors.PrimaryMainColor,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryGreyColor,
              //         width: 2.0,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryBlackColor,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text("Enter Name",
              //     style: H2TextStyle(
              //       AppColors.PrimaryBlackColor,
              //     )),
              // TextFormField(
              //   cursorColor: AppColors.PrimaryBlackColor,
              //   decoration: InputDecoration(
              //     hintText: "Enter Your Name",
              //     fillColor: AppColors.PrimaryMainColor,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryGreyColor,
              //         width: 2.0,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryBlackColor,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text("Enter Name",
              //     style: H2TextStyle(
              //       AppColors.PrimaryBlackColor,
              //     )),
              // TextFormField(
              //   cursorColor: AppColors.PrimaryBlackColor,
              //   decoration: InputDecoration(
              //     hintText: "Enter Your Name",
              //     fillColor: AppColors.PrimaryMainColor,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryGreyColor,
              //         width: 2.0,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryBlackColor,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text("Enter Name",
              //     style: H2TextStyle(
              //       AppColors.PrimaryBlackColor,
              //     )),
              // TextFormField(
              //   cursorColor: AppColors.PrimaryBlackColor,
              //   decoration: InputDecoration(
              //     hintText: "Enter Your Name",
              //     fillColor: AppColors.PrimaryMainColor,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryGreyColor,
              //         width: 2.0,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: const BorderSide(
              //         color: AppColors.PrimaryBlackColor,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
