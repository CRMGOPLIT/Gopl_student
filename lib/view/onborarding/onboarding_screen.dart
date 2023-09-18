import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/view/onborarding/onboarding_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onbording extends StatefulWidget {
  const Onbording({Key? key}) : super(key: key);

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currtpage = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _finishIntro();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: AppColors.backgroungcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffF4F8FE),
                Color(0xffFDF7F4),
              ],
            )),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutesName.login, (routes) => false);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Skip Now",
                          style: TextStyle(
                              color: AppColors.PrimaryMainColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp),
                        )),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.7,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: contents.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currtpage = index;
                      });
                    },
                    itemBuilder: (_, i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 270.h,
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 250.h,
                                    child: Image.asset(
                                      contents[i].image!,
                                      fit: BoxFit.contain,
                                    )),
                              ],
                            ),
                          ),
                          Text(
                            contents[i].title!,
                            style: TextStyle(
                                color: AppColors.PrimaryMainColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 20.sp),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: Text(
                              contents[i].discription!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.PrimaryMainColor,
                                  height: 1.4,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        contents.length, (index) => buildDot(index, context))),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      currtpage == contents.length - 1
                          ? InkWell(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    RoutesName.login, (routes) => false);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15).w,
                                height: 90.h,
                                width: 120.h,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: AppColors.PrimaryMainColor,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ))
                          : InkWell(
                              onTap: () {
                                _controller?.nextPage(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.ease);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15).r,
                                height: 90.h,
                                width: 100.h,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        color: AppColors.PrimaryMainColor,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 8.h,
      width: currtpage == index ? 8.w : 8.w,
      margin: EdgeInsets.only(right: 8.sp),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.PrimaryMainColor),
        borderRadius: BorderRadius.circular(20),
        color: currtpage == index
            ? AppColors.PrimaryMainColor
            : Colors.transparent,
      ),
    );
  }

  void _finishIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('isFirstTime', true);
    });
  }
}
