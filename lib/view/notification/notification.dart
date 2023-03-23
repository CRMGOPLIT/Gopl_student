import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:global_student/view/widget/app_bar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List notice = [
    "NotiFication",
    "Go Fair",
    "University Visit",
    "NotiFication",
    "Go Fair",
    "University Visit",
    "NotiFication",
    "Go Fair",
    "University Visit",
  ];

  text1(int index) {
    var output;

    if (notice.length > 0) {
      output = notice[index];
    }
    return output[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroungcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Notification",
            onpress: () {
              Navigator.pushNamed(context, RoutesName.bottomnav);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: notice.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return Card(
                        elevation: 3,
                        child: ListTile(
                          leading: Container(
                            // padding: EdgeInsets.all(10),
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                                color: AppColors.PrimaryMainColor,
                                borderRadius: BorderRadius.circular(40)),
                            child: Center(
                                child: Text(
                              text1(index),
                              style: hometext(AppColors.PrimaryWhiteColor),
                            )),
                          ),
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 5.sp, top: 10.sp),
                            child: Text(
                              notice[index],
                              style: FieldTextStyle(AppColors.PrimaryMainColor),
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Go fair Start 23 March In Delhi. Visit Our WebSite. ",
                                  style:
                                      batchtext1(AppColors.PrimaryBlackColor),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  "13 Mar At 9:00 AM ",
                                  style: batchtext1(Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
              )

              // Container(
              //   height: 160,
              //   width: 380,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       image: DecorationImage(
              //           image: AssetImage("assets/images/appbanner1.jpg"))),
              // )
            ],
          ),
        ));
  }
}
