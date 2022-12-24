import 'package:flutter/material.dart';
import 'package:global_student/utils/routes/routes_name.dart';

import '../../view/login/otp_page.dart';
import '../../view/onborarding/onboarding_screen.dart';
import '../../view/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesName.onbording:
        return MaterialPageRoute(
            builder: (BuildContext context) => Onbording());

      case RoutesName.otp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OtpPage());
      // case RoutesName.signUp:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const SignUpView());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
