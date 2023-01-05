// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:global_student/utils/color.dart';

// class DropDownWidget extends StatefulWidget {
//   final String? dropvalue;

//   final List<DropdownMenuItem<String>>? data;
//   DropDownWidget({super.key, this.dropvalue, required this.data});

//   @override
//   State<DropDownWidget> createState() => _DropDownWidgetState(dropvalue, data);
// }

// class _DropDownWidgetState extends State<DropDownWidget> {
//   String? dropvalue;
//   bool isSelected = true;
//   final List<DropdownMenuItem<String>>? data;

//   _DropDownWidgetState(this.dropvalue, this.data);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 50.h,
//           width: 480.w,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
//           child: DropdownButtonFormField(
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.r),
//                 borderSide:
//                     BorderSide(color: AppColors.PrimaryGreyColor, width: 1),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.r),
//                 borderSide: BorderSide(
//                   color: AppColors.PrimaryBlackColor,
//                   width: 1,
//                 ),
//               ),
//             ),
//             value: dropvalue,
//             isExpanded: true,
//             icon: Padding(
//               padding: EdgeInsets.only(right: 10.r),
//               child: Icon(
//                 Icons.keyboard_arrow_down,
//                 size: 30.sp,
//                 color: AppColors.PrimaryBlackColor,
//               ),
//             ),
//             items: [data.toString()].map((String items) {
//               return DropdownMenuItem<String>(
//                 value: items,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 10.r),
//                   child: Text(items),
//                 ),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 isSelected = true;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
