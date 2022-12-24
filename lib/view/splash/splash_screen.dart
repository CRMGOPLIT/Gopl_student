import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';

import '../../utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, RoutesName.onbording);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PrimaryMainColor,
      body: FadeIn(
        duration: const Duration(seconds: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Center(
              child: Image.asset(
                "assets/images/logo.png",
                height: 180.h,
                // width: 200.w,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FadeIn(
        duration: const Duration(seconds: 2),
        child: BottomAppBar(
          elevation: 0.0,
          color: Colors.transparent,
          child: Image.asset(
            "assets/images/Country.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
