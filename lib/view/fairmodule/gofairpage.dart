import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/view/fairmodule/appointmenthistory.dart';
import 'package:global_student/view/fairmodule/bookappointmentpage.dart';
import 'package:global_student/view/fairmodule/student_fair_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/gofairbloc.dart';
import '../../model/gofairdetails.dart';
import '../../utils/color.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/text_style.dart';
import '../dashboard/dash_grid_model.dart';
import '../widget/app_bar.dart';

class GoFairPage extends StatefulWidget {
  const GoFairPage({super.key});

  @override
  State<GoFairPage> createState() => _GoFairPageState();
}

class _GoFairPageState extends State<GoFairPage> {
  late GoFairBloc goFairBloc;
  List<dynamic> page = [
    const BookAppointment(),
    const StudentFairDetails(),
    const AppointmentHistory()
  ];

  Gofairdetails? getfairModel;
  String? studentid;
  bool loading1 = true;

  @override
  void initState() {
    goFairBloc = GoFairBloc();
    getgofairDetails();
    _getgofairData();
    super.initState();
  }

  getgofairDetails() {
    goFairBloc.gofairdetailsStream.listen((event) {
      if (event != null) {
        getfairModel = Gofairdetails.fromJson(event);
        setState(() {
          loading1 = false;
        });
      }
    });
  }

  _getgofairData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentid = prefs.getString("studentId");
    Map<String, dynamic> data = {
      "f_student_id": studentid.toString(),
    };
    goFairBloc.callGofairdetailsDetails(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Education Fair",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.bottomnav
                // (routes) => false,
                );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0).w,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.r, right: 8.r),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.r,
                      mainAxisSpacing: 10.r,
                      childAspectRatio: 10.r / 8.r),
                  itemCount: gofairlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => page[index]));
                      },
                      child: Card(
                        elevation: 4,
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.PrimaryMainColor.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        color: AppColors.PrimaryWhiteColor,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.sp),
                                alignment: Alignment.center,
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: batchlist[index].color,
                                    shape: BoxShape.circle),
                                child: Image.asset(
                                  gofairlist[index].image!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(gofairlist[index].title.toString(),
                                  textAlign: TextAlign.center,
                                  style: batchtext2(
                                    AppColors.PrimaryBlackColor,
                                  )),
                            ]),
                      ),
                    );
                  },
                ),
              ),
            ),
            Center(
                child: Image.asset(
              "assets/images/educationfairimg.png",
              height: 300.h,
              width: double.infinity,
            ))
          ],
        ),
      ),
    );
  }
}
