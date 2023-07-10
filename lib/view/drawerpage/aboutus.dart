import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List image = [
    "assets/images/appbanner1.jpg",
    "assets/images/appbanner2.jpg",
    "assets/images/appbanner3.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "About Us",
            onpress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.bottomnav,
                (routes) => false,
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/bannerlogo.png",
                  height: 40,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "We are India’s pioneer education consulting group that undertakes students’ recruitment from India and Nepal for 700+ Institutions and university partners across the globe.\n\nWith a massive network of 21 offices in all the major cities in India and Kathmandu, Nepal, Global Opportunities has nurtured alliances in major countries, including the United Kingdom, United States of America, Canada, Australia, New Zealand, Ireland, Singapore, Dubai, Malaysia amongst other countries.",
                  style: batchtext1(AppColors.PrimaryBlackColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Our team of seasoned counselors with our motto to enable students to ‘step out without doubt’, have created over 70,000 Global Graduates since our inception in 2001. Our students are charting their success stories across the globe, as we establish Global Opportunities as the most trusted and accessible Overseas Education Consultant in India & Nepal.",
                  style: batchtext1(AppColors.PrimaryBlackColor),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Global Opportunities has a guiding Mission and Vision statement that provides a beacon for our organization.",
                  style: batchtext2(
                    AppColors.PrimaryBlackColor,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Our Mission Statement",
                  style: location(
                    AppColors.PrimaryMainColor,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "👉🏻 Easy access to the outside world for anybody heading forward in higher education.\n\n👉🏻 Augmenting students’ experience through expert counseling and unmatched support services.\n\n👉🏻 Facilitating the admission and visa processing, post the acceptance of the application by the partner university.\n\n👉🏻 Ensuring availability of only reputed and recognized International Education partners for aspiring students through stringent selection process.\n\n👉🏻 Assisting the youth of India and Nepal with many ways to get comfortable in a foreign and different environment.",
                  style: batchtext1(
                    AppColors.PrimaryBlackColor,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Our Motto :  \"Step Out without Doubt” - emphasizes the company’s proficient counseling to the seeker letting them move ahead without any doubts.\"",
                  style: FieldTextStyle(Colors.green),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Our Vision",
                  style: location(
                    AppColors.PrimaryMainColor,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "“To offer and provide effortlessly facilitation of fulfilling dreams of studying internationally.”",
                  style: batchtext2(AppColors.PrimaryMainColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "We support ambitions. Our goal is to make it happen for the ones aiming to pursue international education. The international education process can be chaotic, and mind-numbing. That’s where we step in and make the whole experience of the process of studying abroad simple, hassle-free and effortless.",
                  style: batchtext1(AppColors.PrimaryBlackColor),
                )
              ],
            ),
          ),
        ));
  }
}
