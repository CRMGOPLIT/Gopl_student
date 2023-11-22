import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/view/batch_details/batch_details.dart';
import 'package:global_student/view/widget/app_bar.dart';
import '../../utils/text_style.dart';
import '../dashboard/dash_grid_model.dart';

class BatchList extends StatefulWidget {
  const BatchList({super.key});

  @override
  State<BatchList> createState() => _BatchListState();
}

class _BatchListState extends State<BatchList> {
  List<String> batchid = ["IELTS", "GRE", "GMAT", "SAT", "PTE"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Test Prep",
            onpress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.bottomnav,
                (routes) => false,
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.r, right: 8.r),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.r,
                        mainAxisSpacing: 10.r,
                        childAspectRatio: 10.h / 8.h),
                    itemCount: batchlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () =>
                            const BatchDetails(),
                            arguments: [
                              batchid[index],
                            ],
                          );
                        },
                        child: Card(
                          elevation: 4,
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color:
                                  AppColors.PrimaryMainColor.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: AppColors.PrimaryWhiteColor,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.sp),
                                  alignment: Alignment.center,
                                  height: 80.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      color: batchlist[index].color,
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                    batchlist[index].image!,
                                    height: 50.h,
                                    width: 50.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(batchlist[index].title.toString(),
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
              )
           
            ],
          ),
        ));
  }
}
