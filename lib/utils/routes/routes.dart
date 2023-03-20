import 'package:flutter/material.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/view/applicationStatus/application_status.dart';
import 'package:global_student/view/batch_details/batch_details.dart';
import 'package:global_student/view/branch_location/branch_location.dart';
import 'package:global_student/view/comapre.dart';
import 'package:global_student/view/course_details/course_details.dart';
import 'package:global_student/view/couse_search/course_search.dart';
import 'package:global_student/view/dashboard/home_page.dart';
import 'package:global_student/view/drawerpage/aboutus.dart';
import 'package:global_student/view/drawerpage/contactus.dart';
import 'package:global_student/view/edit/edit_page.dart';
import 'package:global_student/view/event_details/event_detils.dart';
import 'package:global_student/view/login/login_page.dart';
import 'package:global_student/view/qualification/highschool.dart';
import 'package:global_student/view/search/search.dart';
import 'package:global_student/view/second.dart';
import 'package:global_student/view/splash/splash_screen.dart';
import 'package:global_student/view/visa/visa_page.dart';
import 'package:global_student/view/widget/bottomnavbar.dart';
import 'package:global_student/view/widget/common_widget.dart';
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
            builder: (BuildContext context) => SplashScreen());

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
      case RoutesName.cpmpare:
        return MaterialPageRoute(builder: (BuildContext context) => Compare());

      case RoutesName.multiple:
        return MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage());

      case RoutesName.courseSearch:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CourseSerach());
      case RoutesName.searchPage:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SearchPage());

      case RoutesName.courseDetails:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CourseDetails());

      case RoutesName.visaPage:
        return MaterialPageRoute(
            builder: (BuildContext context) => const VisaPage());

      case RoutesName.myform:
        return MaterialPageRoute(
            builder: (BuildContext context) => MyFormWidget());

      case RoutesName.aboutpage:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AboutUs());

      case RoutesName.contactpage:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ContactUs());

      case RoutesName.bottomnav:
        return MaterialPageRoute(builder: (BuildContext context) => Bottom());

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
