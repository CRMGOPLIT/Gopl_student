import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:global_student/utils/routes/routes.dart';
import 'package:global_student/utils/routes/routes_name.dart';


import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;

bool? screenboard;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  screenboard = prefs.getBool('screenboard') ?? false;
  // isViewed = prefs.getInt('onBoard');
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
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //  home: HomePageData(),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
