// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:global_student/utils/color.dart';
// import 'package:global_student/view/register/services.dart';

// class DropDoownList extends StatefulWidget {
//   List<DropdownMenuItem<String>>? item;
//   String dropdoownList;
//   DropDoownList({super.key, this.item, required this.dropdoownList});

//   @override
//   State<DropDoownList> createState() =>
//       _DropDoownListState(item, dropdoownList.toString());
// }

// class _DropDoownListState extends State<DropDoownList> {
//   String dropdoownList;
//   List<DropdownMenuItem<String>>? item;
//   _DropDoownListState(this.item, this.dropdoownList);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50.h,
//       width: 480.w,
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           borderRadius: BorderRadius.circular(10)),
//       child: DropdownButton(
//         value: dropdoownList,
//         underline: Container(),
//         isExpanded: true,
//         icon: Padding(
//           padding: EdgeInsets.only(right: 10.r),
//           child: Icon(
//             Icons.keyboard_arrow_down,
//             size: 30.sp,
//             color: AppColors.PrimaryMainColor,
//           ),
//         ),
//         items: Services.servicesOption().map((String item) {
//           return DropdownMenuItem(
//             value: item,
//             child: Padding(
//               padding: EdgeInsets.only(left: 10.r),
//               child: Text(item),
//             ),
//           );
//         }).toList(),
//         onChanged: (String? newValue) {
//           setState(() {
//             dropdoownList = newValue!;
//           });
//         },
//       ),
//     );
//   }
// }
