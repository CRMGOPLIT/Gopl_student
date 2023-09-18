import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/routes/customerror.dart';
import 'package:global_student/utils/routes/routes.dart';
import 'package:global_student/utils/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
bool? screenboard;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
                statusBarColor: AppColors.PrimaryWhiteColor,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
            ),
          ),
          // home: MyPage(),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
