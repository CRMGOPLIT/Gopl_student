import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List image = ["assets/images/banner1.jpg", "assets/images/banner2.jpg"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PrimaryWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.PrimaryMainColor,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: AppColors.PrimaryWhiteColor,
        ),
        // title: Text(
        //   "DashBoard",
        //   style: H1TextStyle(
        //     AppColors.PrimaryWhiteColor,
        //   ),
        // ),
      ),
      body: Column(
        children: [
          Container(
            //ß padding: EdgeInsets.only(left: 15.r, right: 15.r),
            // width: 400.w,
            height: 150.h,
            child: ImageSlideshow(
                width: double.infinity,
                // height: 15.h,
                initialPage: 0,
                indicatorColor: AppColors.PrimaryMainColor,
                indicatorBackgroundColor: Colors.white,
                onPageChanged: (value) {},
                autoPlayInterval: 5000,
                isLoop: true,
                children: List.generate(image.length, (index) {
                  return Container(
                    // height: 180.h,
                    // width: 300.w,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      //0  borderRadius: BorderRadius.circular(0.r),
                      image: DecorationImage(
                        image: AssetImage(image[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Container(
              // height: 445.h,
              decoration: BoxDecoration(
                color: AppColors.PrimaryMainColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.r),
                  topLeft: Radius.circular(25.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Row(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15.r,
                            mainAxisSpacing: 20.r),
                        itemCount: 8,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            // width: 300.w,
                            padding: EdgeInsets.all(15.r),
                            decoration: BoxDecoration(
                                color: AppColors.PrimaryWhiteColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Column(children: [
                              Image.asset(
                                "assets/images/admission.png",
                                height: 60.h,
                                width: 60.w,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("Admission Details",
                                  textAlign: TextAlign.center,
                                  style: Text2Regular(
                                    AppColors.PrimaryMainColor,
                                  ))
                            ]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
