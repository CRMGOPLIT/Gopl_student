import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/text_style.dart';
import '../../utils/color.dart';
import '../../utils/routes/routes_name.dart';
import '../widget/app_bar.dart';

class TokenHistory extends StatefulWidget {
  const TokenHistory({super.key});

  @override
  State<TokenHistory> createState() => _TokenHistoryState();
}

class _TokenHistoryState extends State<TokenHistory> {
  List<Color> colors = [];

  List<Color> generateRandomColors() {
    List<Color> colorList = [
      const Color(0xffEEF5FF),
      const Color(0xffFFEEF0),
      const Color(0xffF4F3FF),
      const Color(0xffF2F9F6),
      const Color(0xffF9F2F6),
      const Color(0xffFFEEF9),
      const Color(0xffFFF6EE),
      const Color(0xffF3FCFF),
    ];

    colorList.shuffle(Random());
    return colorList;
  }

  Color getRandomColor() {
    if (colors.isEmpty) {
      colors = generateRandomColors();
    }
    return colors.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBarCustom(
            title: "Token History",
            onpress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.gofair,
                (routes) => false,
              );
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0).r,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.PrimaryWhiteColor,
                  //Color.fromARGB(255, 2, 75, 2),
                  borderRadius: BorderRadius.circular(10)),
              child: Card(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: AppColors.PrimaryMainColor,
                    ),
                    borderRadius: BorderRadius.circular(10).r),
                elevation: 5,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.circle_rounded,
                        color: Colors.green,
                      )
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Image.asset(
                        "assets/images/tokencoin.png",
                        height: 100.h,
                        width: 400.w,
                      ),
                      Text(
                        "34567909",
                        style: batchtext2(AppColors.PrimaryBlackColor),
                      ),
                      Text(
                        "Date :- 12/78/900",
                        style: batchtext2(AppColors.PrimaryBlackColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
              ),
            ),
            
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Token History"),
                  )
                ],
              ),
            ),
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    "assets/images/tokencoin.png",
                    height: 200.h,
                  ),
                ),
              ),
            ),
            Text(
              "Token No :-  1234566",
              style: batchtext2(AppColors.PrimaryMainColor),
            ),
          ],
        ),
      ),
    );
  }
}
