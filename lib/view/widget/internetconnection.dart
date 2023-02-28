// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:global_student/utils/color.dart';
// import 'package:global_student/utils/text_style.dart';

// class InternetConnection extends StatefulWidget {
//   const InternetConnection({super.key});

//   @override
//   State<InternetConnection> createState() => _InternetConnectionState();
// }

// class _InternetConnectionState extends State<InternetConnection> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 200.h,
//             ),
//             Image.asset('assets/images/on1.png'),
//             SizedBox(
//               height: 60.h,
//             ),
//             Text(
//               "No Connection Internet",
//               style: H1TextStyle(AppColors.PrimaryBlackColor),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';

// class ConnectionChecker extends StatelessWidget {
//   const ConnectionChecker({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<ConnectivityResult>(
//       stream: Connectivity().onConnectivityChanged,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         return Scaffold(
//           body: Center(
//               child: snapshot.data == ConnectivityResult.none
//                   ? Text("check internet")
//                   : Text("connected")),
//         );
//       },
//     );
//   }
// }

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
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

  @override
  void initState() {
    // TODO: implement initState

    startStreaming();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
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
              : SizedBox(
                  width: 150.w,
                  child: ButtonPrimary(
                      title: "Retry",
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: const Text('No Internet Connection'),
                          backgroundColor: (Colors.black),
                          action: SnackBarAction(
                            textColor: AppColors.PrimaryWhiteColor,
                            label: 'Dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }))
        ],
      ),
    );
  }
}
