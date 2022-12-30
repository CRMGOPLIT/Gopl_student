import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/text_field.dart';
import '../../utils/text_style.dart';
import '../widget/button.dart';

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
  var _registerkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.PrimaryWhiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h), // here the desired height
        child: AppBarCustom(
          title: "Registration",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.login);
          },
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/bgreg.jpeg",
                ))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _registerkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormWidget(
                    hint: "Enter Your name",
                    title: "Enter Name",
                  ),
                  TextFormWidget(
                    hint: "Enter Your Email id",
                    title: "Email Id",
                  ),
                  TextFormWidget(
                      hint: "Enter Your Mobile Number",
                      title: "Mobile Number",
                      // validator: (value) {
                      //   if (value!.isEmpty ||
                      //       !RegExp(r"^[0-9]").hasMatch(value)) {
                      //     return 'Enter a valid email!';
                      //   }
                      //   return null;
                      // },
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp("[0-9]"),
                            allow: true),
                      ]),
                  Text("State",
                      style: FieldTextStyle(
                        AppColors.PrimaryBlackColor,
                      )),
                  Container(
                    height: 50.h,
                    width: 480.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r)),
                    child: DropdownButtonFormField(
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
                        padding: EdgeInsets.only(right: 10.r),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 30.sp,
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
                          isSelected = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("Closest Branch",
                      style: FieldTextStyle(
                        AppColors.PrimaryBlackColor,
                      )),
                  Container(
                    height: 50.h,
                    width: 480.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r)),
                    child: DropdownButtonFormField(
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
                        padding: EdgeInsets.only(right: 10.r),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 30.sp,
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
                          isSelected = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("University intake",
                      style: FieldTextStyle(
                        AppColors.PrimaryBlackColor,
                      )),
                  Container(
                    height: 50.h,
                    width: 480.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r)),
                    child: DropdownButtonFormField(
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
                        padding: EdgeInsets.only(right: 10.r),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 30.sp,
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
                          isSelected = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("Course interested",
                      style: FieldTextStyle(
                        AppColors.PrimaryBlackColor,
                      )),
                  Container(
                    height: 50.h,
                    width: 480.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r)),
                    child: DropdownButtonFormField(
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
                        padding: EdgeInsets.only(right: 10.r),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 30.sp,
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
                          isSelected = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("Country of programmes",
                      style: FieldTextStyle(
                        AppColors.PrimaryBlackColor,
                      )),
                  Container(
                    height: 50.h,
                    width: 480.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r)),
                    child: DropdownButtonFormField(
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
                        padding: EdgeInsets.only(right: 10.r),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 30.sp,
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
                          isSelected = true;
                        });
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // ButtonPrimary(title: "submit", onPressed: () {})
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/bgreg.jpeg",
                ))),
        child: BottomAppBar(
            elevation: 0.0,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.r, left: 15.r, right: 15.r),
              child: ButtonPrimary(
                title: "Submit",
                onPressed: () {
                  if (_registerkey.currentState!.validate()) {
                    // use the email provided here
                  }
                },
              ),
            )),
      ),
    );
  }
}
