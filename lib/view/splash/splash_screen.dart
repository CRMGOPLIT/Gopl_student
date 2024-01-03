import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/widget/internetconnection.dart';
import 'package:global_student/view/widget/notificationservices.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription subscription;
  NotificationServices notificationServices = NotificationServices();
  bool isDeviceConnected = false;
  bool isAlertSet = false;
//  String? _connectionStatus;
  String? check;
  String? token;

  late ConnectivityResult result;

  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      isDeviceConnected = true;
    } else {
      isDeviceConnected = false;
      Get.to(() => const ConnectionChecker());
    }
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

  Future _checkInternetConnection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);
    token = prefs.getString('stringValue');

    if (seen && token != null) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RoutesName.bottomnav);
      });
    } else {
      await prefs.setBool('seen', true);
      if (seen == true && token == null) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.login,
            (routes) => false,
          );
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.onbording,
            (routes) => false,
          );
        });
      }
    }
  }

  getnotificationtoken() async {
    String devicetoken = await notificationServices.getDeviceToken();
    // print(value);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      prefs.setString('token', devicetoken.toString());
    });
  }

  inittoken() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      getnotificationtoken();
    });
  }

  // String? fcmToken;
  // Future<void> _retrieveFCMToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String devicetoken = await notificationServices.getDeviceToken();
  //   setState(() {
  //     fcmToken = devicetoken;
  //   });

  //   prefs.setString('token', fcmToken.toString());
  //   // Send the token to the server
  // }

  @override
  initState() {
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    inittoken();
    startStreaming();
    _checkInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return check == "Not connected"
        ? const ConnectionChecker()
        : Scaffold(
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

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
