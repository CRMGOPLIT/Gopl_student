import 'package:flutter/material.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/view/applicationStatus/application_status.dart';
import 'package:global_student/view/batch_details/batch_details.dart';
import 'package:global_student/view/branch_location/branch_location.dart';
import 'package:global_student/view/dashboard/home_page.dart';
import 'package:global_student/view/edit/edit_page.dart';
import 'package:global_student/view/event_details/event_detils.dart';
import 'package:global_student/view/login/login_page.dart';
import 'package:global_student/view/qualification/highschool.dart';
import 'package:global_student/view/splash/splash_screen.dart';

import '../../view/login/otp_page.dart';
import '../../view/onborarding/onboarding_screen.dart';
import '../../view/register/register.dart';

class Routes {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesName.onbording:
        return MaterialPageRoute(
            builder: (
          BuildContext context,
        ) =>
                const Onbording());

      case RoutesName.otp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OtpPage());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LginPage());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterPage());
      case RoutesName.edit:
        return MaterialPageRoute(
            builder: (BuildContext context) => const EditPage());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());
      case RoutesName.highschool:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HighSchool());

      case RoutesName.applicationStatus:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ApplicationStatus());

      case RoutesName.batchDetails:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BatchDetails());

      case RoutesName.eventDetails:
        return MaterialPageRoute(
            builder: (BuildContext context) => const EventDetails());

      case RoutesName.branchLocation:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BranchLocation());

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
