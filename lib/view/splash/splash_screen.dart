import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  @override
  String? _connectionStatus;
  String? check;

  String? token;
//  late StreamSubscription subscription;
  late StreamSubscription subscription2;
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
      showDialogBox();
    }
    setState(() {});
  }

  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });
  }

  showDialogBox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("No Internet"),
              content: const Text("Please check your internet connection"),
              actions: [
                CupertinoButton.filled(
                    child: const Text("Retry"),
                    onPressed: () {
                      Navigator.pop(context);
                      checkInternet();
                    }),
              ],
            )); // CupertinoAlertDialog
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   startStreaming();
  //   super.initState();
  // }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    // subscription.cancel();
    //subscription2.cancel();
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
      bool _seen = (prefs.getBool('seen') ?? false);

      if (_seen) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamed(context, RoutesName.home);

          print("if $check");
          // getConnectivity();
        });
      } else {
        await prefs.setBool('seen', true);
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamed(context, RoutesName.onbording);
          //  getConnectivity();
        });
      }
    } else {
      setState(() {
        _connectionStatus = 'Not connected';
        check = _connectionStatus;
      });
      // checkInternet();
      // showDialogBox();
      // getConnectivity();
      print("else$check");
      // Future.delayed(const Duration(seconds: 1), () {
      //   Navigator.pushNamed(context, RoutesName.onbording);
      // });
    }
  }

  // Future checkmethod() async {
  //   if (check == 'Connected') {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     bool _seen = (prefs.getBool('seen') ?? false);

  //     if (_seen) {
  //       Future.delayed(const Duration(seconds: 3), () {
  //         Navigator.pushNamed(context, RoutesName.home);
  //         print("if $check");
  //       });
  //     } else {
  //       await prefs.setBool('seen', true);
  //       Future.delayed(const Duration(seconds: 3), () {
  //         Navigator.pushNamed(context, RoutesName.onbording);
  //       });
  //     }
  //   } else {
  //     Future.delayed(const Duration(seconds: 3), () {
  //       Navigator.pushNamed(context, RoutesName.login);
  //     });
  //     print("else$check");
  //   }
  // }

  // Future checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _seen = (prefs.getBool('seen') ?? false);

  //   if (_seen) {
  //     Future.delayed(const Duration(seconds: 3), () {
  //       Navigator.pushNamed(context, RoutesName.home);
  //     });
  //   } else {
  //     await prefs.setBool('seen', true);
  //     Future.delayed(const Duration(seconds: 3), () {
  //       Navigator.pushNamed(context, RoutesName.onbording);
  //     });
  //   }
  // }

  // Future<Object> checkInternetConnectivity() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     // Mobile data detected.
  //     return errmsg("cecjnjk", false);
  //   } else {
  //     // Neither mobile data nor Wifi detected.
  //     return false;
  //   }
  // }

  @override
  initState() {
    //   checkmethod();
    // startStreaming();
    // _checkInternetConnection();
    //getConnectivity();
    // getStringValuesSF();
    getStringValuesSF();

    // Future.delayed(const Duration(seconds: 3), () {
    //   Navigator.pushNamed(context, RoutesName.onbording);
    // });
    super.initState();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    token = prefs.getString('stringValue');
    if (token == null) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RoutesName.onbording);
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RoutesName.bottomnav);
      });
    }

    return token;
  }

  @override
  Widget build(BuildContext context) {
    return check == "Not connected"
        ? ConnectionChecker()
        : Scaffold(
            backgroundColor: AppColors.PrimaryMainColor,
            body: FadeIn(
              duration: const Duration(seconds: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Internet connection status: $_connectionStatus',
                    ),
                  ),
                  Text(token.toString()),
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

  Widget errmsg(String text, bool show) {
    //error message widget.
    if (show == true) {
      //if error is true then show error message box
      return Container(
        padding: const EdgeInsets.all(10.00),
        margin: const EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [
          Container(
            margin: const EdgeInsets.only(right: 6.00),
            child: const Icon(Icons.info, color: Colors.white),
          ), // icon for error message

          Text(text, style: const TextStyle(color: Colors.white)),
          //show error message text
        ]),
      );
    } else {
      return Container();
      //if error is false, return empty container.
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
