import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/widget/internetconnection.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _connectionStatus;
  String? check;
  String? token;

  bool isDeviceConnected = false;
  bool isAlertSet = false;

  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isConnected = false;

  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      isConnected = true;
    } else {
      isConnected = false;
      Get.to(const ConnectionChecker());
    }
  }

  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            const ConnectionChecker();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  Future _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _connectionStatus = 'Connected';
        check = _connectionStatus;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = (prefs.getBool('seen') ?? false);
      token = prefs.getString('stringValue');

      if (seen && token != null) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamed(context, RoutesName.bottomnav);
          getConnectivity();
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
            getConnectivity();
          });
        } else {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.onbording,
              (routes) => false,
            );

            getConnectivity();
          });
        }
      }
    } else {
      setState(() {
        _connectionStatus = 'Not connected';
        check = _connectionStatus;
      });
      checkInternet();
      showDialogwBox();

      getConnectivity();
    }
  }

  @override
  initState() {
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

  Widget errmsg(String text, bool show) {
    if (show == true) {
      return Container(
        padding: const EdgeInsets.all(10.00),
        margin: const EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [
          Container(
            margin: const EdgeInsets.only(right: 6.00),
            child: const Icon(Icons.info, color: Colors.white),
          ),
          Text(text, style: const TextStyle(color: Colors.white)),
        ]),
      );
    } else {
      return Container();
    }
  }

  showDialogwBox() => showCupertinoDialog<String>(
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
                  showDialogwBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
