import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/view/applicationStatus/according_widget.dart';
import 'package:global_student/view/widget/app_bar.dart';

class ApplicationStatus extends StatefulWidget {
  const ApplicationStatus({super.key});

  @override
  State<ApplicationStatus> createState() => _ApplicationStatusState();
}

class _ApplicationStatusState extends State<ApplicationStatus> {
  bool isExpanded = false;
  int? num;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Application Status",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.home);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ListTile(
            //   leading: Text("Application",
            //       style: Text2Regular(
            //         AppColors.PrimaryBlackColor,
            //       )),
            //   trailing: Text("View All",
            //       style: Text2Regular(
            //         AppColors.PrimaryBlackColor,
            //       )),
            // ),
            SizedBox(
              height: 15.h,
            ),
            Column(
              children: [
                for (int i = 0; i < 8; i++)
                  Container(
                      margin: EdgeInsets.only(
                        left: 15.r,
                        right: 15.r,
                        bottom: 10.r,
                      ),
                      child: AccordingWidget()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
