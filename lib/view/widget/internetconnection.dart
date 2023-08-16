import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/view/widget/button.dart';

class ConnectionChecker extends StatefulWidget {
  const ConnectionChecker({super.key});

  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isConnected = false;

  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    setState(() {});
  }

  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startStreaming();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
                height: 230.h,
                width: 250.w,
                child: Image.asset(
                  'assets/images/net.png',
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text("NO connection",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800)),
          SizedBox(
            height: 10.h,
          ),
          Text("Please check your internet connectivity and try again",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
          SizedBox(
            height: 30.h,
          ),
          isConnected == true
              ? SizedBox(
                  width: 150.w,
                  child: ButtonPrimary(
                      title: "Retry",
                      onPressed: () {
                        Future.delayed(const Duration(seconds: 0), () {
                          Navigator.pushNamed(context, RoutesName.splash);
                        });
                      }),
                )
              : Container(),
        ],
      ),
    );
  }
}
