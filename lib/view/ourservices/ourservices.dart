import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/dashboard/dash_grid_model.dart';
import '../../utils/routes/routes_name.dart';
import '../widget/app_bar.dart';

class OurServices extends StatefulWidget {
  const OurServices({super.key});

  @override
  State<OurServices> createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Our Services",
            onpress: () {
              // Navigator.pushNamed(context, RoutesName.batchDetails
              //     // (routes) => false,
              //     );
              // Navigator.pushNamed(
              //   context,
              //   RoutesName.batchDetails,
              // );

              Get.back();
            },
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Image.asset(
                "assets/images/bannerlogo.png",
                height: 40.h,
                width: 300.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.r, right: 10.r),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(
                    parent: NeverScrollableScrollPhysics()),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.r,
                    mainAxisSpacing: 10.r,
                    childAspectRatio: 10.h / 8.h),
                itemCount: ourservices.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.batchperforma,
                        // (routes) => false,
                      );
                    },
                    child: Card(
                      elevation: 5,
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: AppColors.PrimaryGreyColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // color: dashgrid[index].color,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.sp),
                              alignment: Alignment.center,
                              child: Image.asset(
                                ourservices[index].image!,
                                height: 50.h,
                                width: 75.w,
                              ),
                            ),
                            Text(ourservices[index].title!,
                                textAlign: TextAlign.center,
                                style: batchtext2(
                                  AppColors.PrimaryBlackColor,
                                )),
                          ]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Image.asset(
                "assets/images/ourserimg.png",
                height: 250.h,
                width: 500.w,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
