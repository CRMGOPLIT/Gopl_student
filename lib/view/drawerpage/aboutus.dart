import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
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
              Navigator.pushNamed(context, RoutesName.bottomnav);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ImageSlideshow(
                  width: double.infinity,
                  height: 120.h,
                  initialPage: 0,
                  indicatorColor: const Color(0xff5D88C6),
                  indicatorBackgroundColor: AppColors.PrimaryGreyColor,
                  onPageChanged: (value) {},
                  autoPlayInterval: 3000,
                  isLoop: true,
                  children: List.generate(image.length, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        image: DecorationImage(
                            image: AssetImage(image[index]), fit: BoxFit.fill
                            // fit: BoxFit.cover,
                            ),
                      ),
                    );
                  })),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "We are India’s pioneer education consulting group that undertakes students’ recruitment from India and Nepal for 700+ Institutions and university partners across the globe.\nWith a massive network of 21 offices in all the major cities in India and Kathmandu, Nepal, Global Opportunities has nurtured alliances in major countries, including the United Kingdom, United States of America, Canada, Australia, New Zealand, Ireland, Singapore, Dubai, Malaysia amongst other countries.",
                style: FieldTextStyle(AppColors.PrimaryMainColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "With a massive network of 21 offices in all the major cities in India and Kathmandu, Nepal,",
                style: FieldTextStyle(AppColors.PrimaryMainColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Our team of seasoned counselors with our motto to enable students to ‘step out without doubt’, have created over 70,000 Global Graduates since our inception in 2001. Our students are charting their success stories across the globe, as we establish Global Opportunities as the most trusted and accessible Overseas Education Consultant in India & Nepal.",
                style: FieldTextStyle(AppColors.PrimaryMainColor),
              ),
            ],
          ),
        ));
  }
}
