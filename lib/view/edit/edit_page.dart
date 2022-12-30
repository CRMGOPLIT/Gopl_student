import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/button.dart';
import 'package:global_student/view/widget/text_field.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h), // here the desired height
        child: AppBarCustom(
          title: "Edit Profile",
          onpress: () {
            // Navigator.pushNamed(context, .login);
          },
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/images/editimg.png",
              fit: BoxFit.cover,
              height: 250.h,
              width: 250.w,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 345.h,
            decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.r),
                topLeft: Radius.circular(25.r),
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  TextFormWidget(
                    title: "Alternate Email ID",
                    hint: "Email ID",
                  ),
                  TextFormWidget(
                    title: "Alternate Mobile No",
                    hint: "Mobile Number",
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  ButtonPrimary(
                    title: "Submit",
                    onPressed: () {},
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
