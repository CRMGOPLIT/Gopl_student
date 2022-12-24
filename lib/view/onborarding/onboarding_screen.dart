import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/view/onborarding/onboarding_model.dart';

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
      backgroundColor: AppColors.PrimaryMainColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currtpage = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.all(40.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 220.h,
                          width: 220.w,
                          child: Image.asset(
                            contents[i].image!,
                            // fit: BoxFit.cover,
                          )),
                      Text(
                        contents[i].title!,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        contents[i].discription!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 100.h,
            margin: EdgeInsets.all(20.sp),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        contents.length, (index) => buildDot(index, context))),
                SizedBox(
                  height: 30.h,
                ),
                currtpage == contents.length - 1
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.otp);
                        },
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              height: 40.h,
                              width: 100.h,
                              //color: Colors.red,
                              child: Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )))
                    : GestureDetector(
                        onTap: () {
                          _controller?.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.ease);
                        },
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              height: 40.h,
                              width: 60.h,
                              // color: Colors.red,
                              child: Center(
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 8.h,
      width: currtpage == index ? 8.w : 8.w,
      margin: EdgeInsets.only(right: 8.sp),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
        color: currtpage == index ? Colors.white : Colors.transparent,
      ),
    );
  }
}
