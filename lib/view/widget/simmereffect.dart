// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:global_student/utils/color.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../utils/text_style.dart';

// ShimmerEffect() {
//   return Padding(
//     padding: EdgeInsets.only(
//       top: 10.sp,
//       left: 15.sp,
//       right: 15.sp,
//     ),
//     child: ListView.builder(
//         itemCount: 10,
//         shrinkWrap: true,
//         itemBuilder: ((context, index) {
//           return Card(
//               color: AppColors.PrimaryGreyColor,
//               elevation: 0,
//               child: Shimmer.fromColors(
//                 baseColor: Color.fromARGB(255, 217, 214, 214),
//                 //Color.fromARGB(255, 233, 231, 231),
//                 highlightColor: Color.fromARGB(255, 242, 239, 239),
//                 child: ListTile(
//                   leading: Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(10),
//                     height: 50.h,
//                     width: 50.w,
//                     decoration: BoxDecoration(
//                         color: AppColors.PrimaryGreyColor,
//                         borderRadius: BorderRadius.circular(40)),
//                     child: Text(
//                       "",
//                       style: hometext(AppColors.PrimaryWhiteColor),
//                     ),
//                   ),
//                   title: Padding(
//                       padding: EdgeInsets.only(bottom: 5.sp, top: 10.sp),
//                       child: Container(
//                         height: 20.h,
//                         width: 200.w,
//                         decoration: BoxDecoration(
//                             color: AppColors.PrimaryGreyColor,
//                             borderRadius: BorderRadius.circular(0)),
//                       )),
//                   subtitle: Padding(
//                       padding: EdgeInsets.only(
//                         bottom: 20.sp,
//                         top: 5.sp,
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 10.h,
//                             //  width: 100.w,
//                             decoration: BoxDecoration(
//                                 color: AppColors.PrimaryGreyColor,
//                                 borderRadius: BorderRadius.circular(0)),
//                           ),
//                           // SizedBox(
//                           //   height: 5.h,
//                           // ),
//                           // Container(
//                           //   height: 5.h,
//                           //   //  width: 100.w,
//                           //   decoration: BoxDecoration(
//                           //       color: AppColors.PrimaryGreyColor,
//                           //       borderRadius: BorderRadius.circular(0)),
//                           // ),
//                         ],
//                       )),
//                 ),
//               )
//               // Shimmer.fromColors(
//               //     baseColor: Color.fromARGB(255, 233, 231, 231),
//               //     highlightColor: Color.fromARGB(255, 240, 240, 240),
//               //     child: Container(
//               //       color: AppColors.PrimaryGreyColor,
//               //       height: 30.h,
//               //     )),
//               );
//         })),
//   );
// }
