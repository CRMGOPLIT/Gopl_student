import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/customerror.dart';
import 'package:global_student/utils/routes/routes.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:global_student/view/payment/test.dart';
import 'package:global_student/view/widget/notificationservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
bool? screenboard;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationServices().showNotification(
    message,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  screenboard = prefs.getBool('screenboard') ?? false;
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return const CustomErrorWidget();
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Global Opportunities',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: AppColors.PrimaryMainColor,
              foregroundColor: Colors.black,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColors.PrimaryMainColor,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
            ),
          ),
          // home: AddQuestion(),

          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
