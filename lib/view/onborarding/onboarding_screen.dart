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
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      body: SafeArea(
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
              // SizedBox(
              //   height: 40.h,
              // ),
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
              Container(
                height: 440.h,
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
                        Container(
                          height: 270.h,
                          //   color: AppColors.PrimaryWhiteColor,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 250.h,
                                  // width: 220.w,
                                  child: Image.asset(
                                    contents[i].image!,
                                    fit: BoxFit.contain,
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          contents[i].title!,
                          style: TextStyle(
                              color: AppColors.PrimaryMainColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 20.sp),
                        ),
                        // SizedBox(
                        //   height: 10.h,
                        // ),
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
                height: 50,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      contents.length, (index) => buildDot(index, context))),
              // Container(
              //   height: 60.h,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10.sp),
              //       gradient: const LinearGradient(
              //         begin: Alignment.centerLeft,
              //         end: Alignment.centerRight,
              //         colors: [
              //           Color(0xff143C79),
              //           Color(0xff2A67C5),
              //         ],
              //       )),
              //   child: const Center(
              //     child: Text(
              //       'Next',
              //       style: TextStyle(
              //         fontSize: 28.0,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SizedBox(
                    //   height: 30.h,
                    // ),
                    currtpage == contents.length - 1
                        ? InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, RoutesName.login, (routes) => false);
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              // alignment: Alignment.center,
                              height: 90.h,
                              width: 100.h,
                              //color: Colors.red,
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
                              padding: EdgeInsets.all(15),
                              height: 90.h,
                              width: 100.h,
                              //color: Colors.red,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Next",
                                  //textAlign: TextAlign.end,
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
    // Update the boolean value in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('isFirstTime', true);
    });

    //  Navigator.pushNamed(context, RoutesName.home);
  }
}
