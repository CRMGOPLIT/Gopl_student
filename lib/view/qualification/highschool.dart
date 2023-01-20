import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:global_student/view/widget/button.dart';
import 'package:lottie/lottie.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';

class HighSchool extends StatefulWidget {
  const HighSchool({super.key});

  @override
  State<HighSchool> createState() => _HighSchoolState();
}

class _HighSchoolState extends State<HighSchool> {
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
  bool isFileSelected = false;
  // List<File> selectedBankStatements = [];
  PlatformFile? file;
  var _registerkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h), // here the desired height
        child: AppBarCustom(
          title: "Qualification",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.home);
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
                  Text("Qualification",
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
                          borderSide: const BorderSide(
                              color: AppColors.PrimaryGreyColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
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
                  Text("Stream",
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
                          borderSide: const BorderSide(
                              color: AppColors.PrimaryGreyColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
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
                  Text("Board/University",
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
                          borderSide: const BorderSide(
                              color: AppColors.PrimaryGreyColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
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
                  Text("Regular/Distance",
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
                          borderSide: const BorderSide(
                              color: AppColors.PrimaryGreyColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
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
                  Text("Percentage/CGPA",
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
                          borderSide: const BorderSide(
                              color: AppColors.PrimaryGreyColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
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
                  Text("Degree start Year",
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
                          borderSide: const BorderSide(
                              color: AppColors.PrimaryGreyColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
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
                  Text("Degree end Year",
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
                          borderSide: const BorderSide(
                              color: AppColors.PrimaryGreyColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
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
                  Text("Upload 10th Marks",
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
                          borderSide: const BorderSide(
                              color: AppColors.PrimaryGreyColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
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
                  Text("Upload 10th Marks",
                      style: FieldTextStyle(
                        AppColors.PrimaryBlackColor,
                      )),
                  GestureDetector(
                    onTap: () {
                      selectFiles();
                    },
                    child: Container(
                        height: 50.h,
                        width: 400.w,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.PrimaryGreyColor),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: (file == null)
                            ? Lottie.asset(
                                "assets/images/upload.json",
                              )
                            : Padding(
                                padding: EdgeInsets.only(left: 20.r),
                                child: (file!.extension == "pdf")
                                    ? Row(children: [
                                        const Icon(
                                          Icons.picture_as_pdf,
                                          color: Colors.red,
                                        ),
                                        Center(
                                            child: Container(
                                          margin: EdgeInsets.only(left: 10.r),
                                          width: 250.w,
                                          child:
                                              Text(file!.path!.split('/').last),
                                        ))
                                      ])
                                    : Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/docx.png",
                                            height: 20.h,
                                          ),
                                          Center(
                                              child: Container(
                                            margin: EdgeInsets.only(left: 10.r),
                                            width: 250.w,
                                            child: Text(
                                                file!.path!.split('/').last),
                                          )),
                                        ],
                                      ))),
                  ),
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

  void selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['docx', 'pdf'],
    );

    if (result == null) return;

    file = result.files.first;

    setState(() {});
  }
}
