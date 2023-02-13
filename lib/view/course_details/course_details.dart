import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Course Details",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.home);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Image.asset(
                  "assets/images/logocollege.png",
                  height: 80.h,
                  width: 150.w,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Solent University Southampton",
                style: OtpText(AppColors.PrimaryMainColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "East Park Terrace, Southampton SO14 OYN United kingdom",
                textAlign: TextAlign.center,
                style: Text2Regular(AppColors.PrimaryBlackColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45.h,
                    width: 160.w,
                    decoration: BoxDecoration(
                        color: AppColors.PrimaryMainColor,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/ranklogo.png",
                        height: 30.h,
                        width: 30.w,
                        fit: BoxFit.cover,
                      ),
                      trailing: Text(
                        "QS Ranking 1000",
                        style: TextRegular(AppColors.PrimaryWhiteColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 45.h,
                    width: 160.w,
                    decoration: BoxDecoration(
                        color: AppColors.PrimaryMainColor,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/ranklogo.png",
                        height: 30.h,
                        width: 30.w,
                        fit: BoxFit.cover,
                      ),
                      trailing: Text(
                        "QS Ranking 1000",
                        style: TextRegular(AppColors.PrimaryWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  "Web Url",
                  style: OtpText(AppColors.PrimaryBlackColor),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () async {
                  const url = 'https://www.solent.ac.uk/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 45.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.PrimaryBlackColor),
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Text(
                      "https://www.solent.ac.uk/",
                      style: TextRegular(AppColors.PrimaryMainColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Honours Bachelor of science in Sport and Exercise Science ",
                style: FieldTextStyle(AppColors.PrimaryMainColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),
                width: 350.w,
                decoration: BoxDecoration(
                  color: AppColors.PrimaryWhiteColor,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(
                          4,
                          4,
                        ),
                        color: Colors.black12,
                        blurRadius: 2.0,
                        spreadRadius: 3.0),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Text(
                        "Intakes -",
                        style: FieldTextStyle(AppColors.PrimaryBlackColor),
                      ),
                      title: Text(
                        "September",
                        style: Text2Regular(AppColors.PrimaryBlackColor),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "Duration -",
                        style: FieldTextStyle(AppColors.PrimaryBlackColor),
                      ),
                      title: Text(
                        "3 year",
                        style: Text2Regular(AppColors.PrimaryBlackColor),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "Course Url -",
                        style: FieldTextStyle(AppColors.PrimaryBlackColor),
                      ),
                      title: Text(
                        "https://www.solent.ac.uk./courses/undergraduate/sport-and",
                        style: Text2Regular(AppColors.PrimaryMainColor),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "Application Url -",
                        style: FieldTextStyle(AppColors.PrimaryBlackColor),
                      ),
                      title: Text(
                        "https://www.solent.ac.uk./courses/undergraduate/sport-and",
                        style: Text2Regular(AppColors.PrimaryMainColor),
                      ),
                    ),
                    coursefield(
                      title: "Location -",
                      subtitle: "Southampton",
                    ),
                    coursefield(
                      title: "Campus -",
                      subtitle: "Southampton City Campus",
                    ),
                    coursefield(
                      title: "Majors -",
                      subtitle: "Sports Science, Sports, Sports Management",
                    ),
                    coursefield(
                      title: "Application Fee -",
                      subtitle: "GBP 22.00",
                    ),
                    coursefield(
                      title: "Multiple Course\nApplication Fee  -",
                      subtitle: "GBP 26.50",
                    ),
                    coursefield(
                      title: "Tuition Fee -",
                      subtitle: "GBP 15000.00/year",
                    ),
                    coursefield(
                      title: "Scholarship -",
                      subtitle: "No",
                    ),
                    coursefield(
                      title: "Placement -",
                      subtitle: "GBP 22.00",
                    ),
                    coursefield(
                      title: "Living expensive -",
                      subtitle: "",
                    ),
                    coursefield(
                      title: "Conditional Offer -",
                      subtitle: "No",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Standardized Test Requirement",
                style: OtpText(AppColors.PrimaryMainColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),
                width: 350.w,
                decoration: BoxDecoration(
                  color: AppColors.PrimaryWhiteColor,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(
                          4,
                          4,
                        ),
                        color: Colors.black12,
                        blurRadius: 2.0,
                        spreadRadius: 3.0),
                  ],
                ),
                child: Column(
                  children: [
                    coursefield(
                      title: "IELTS Overall -",
                      subtitle: "6.0",
                    ),
                    coursefield(
                      title: "CIELTS no Band Less Than -",
                      subtitle: "5.5",
                    ),
                    coursefield(
                      title: "TOEFL iBT Overall -",
                      subtitle: "80.0",
                    ),
                    coursefield(
                      title: "TOEFL iBT no \nBands Less Than -",
                      subtitle: "  20.0",
                    ),
                    coursefield(
                      title: "Dat Score -",
                      subtitle: "95.0",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Expectable Board",
                style: OtpText(AppColors.PrimaryMainColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 2.h,
                width: 300.w,
                color: AppColors.PrimaryBlackColor,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Entry Requirements",
                style: OtpText(AppColors.PrimaryMainColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 2.h,
                width: 300.w,
                color: AppColors.PrimaryBlackColor,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "12th Standard with 65% and above.",
                style: Text2Regular(AppColors.PrimaryBlackColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Remarks",
                style: OtpText(AppColors.PrimaryMainColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 2.h,
                width: 300.w,
                color: AppColors.PrimaryBlackColor,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "CO-OP Fees - 1250",
                style: Text2Regular(AppColors.PrimaryBlackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class coursefield extends StatelessWidget {
  String title;
  String subtitle;
  coursefield({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title,
        style: FieldTextStyle(AppColors.PrimaryBlackColor),
      ),
      title: Text(
        subtitle,
        style: Text2Regular(AppColors.PrimaryBlackColor),
      ),
    );
  }
}
