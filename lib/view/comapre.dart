// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:global_student/view/onborarding/onboarding_model.dart';


// class Compare extends StatefulWidget {
//   const Compare({super.key});

//   @override
//   State<Compare> createState() => _CompareState();
// }

// class _CompareState extends State<Compare> {
//   // List month = ["jan", "feb", 'mar', 'april', "may"];
// //  List sub = ["erg", "ewg", 'ewgwe', 'rwg', "ewfgwe"];
//   // ValueSetter<IntroModel>? temparray;
//   List<IntroModel> cart = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: 600,
//             child: ListView.builder(
//                 itemCount: contents.length,
//                 itemBuilder: (context, index) {
//                   return Builder(builder: (context) {
//                     return InkWell(
//                       onTap: () {
//                         showDialog<void>(
//                           context: context,
//                           barrierDismissible: false, // user must tap button!
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               // <-- SEE HERE
//                               title: const Text('Cancel booking'),
//                               content: SingleChildScrollView(
//                                 child: ListBody(
//                                   children: const <Widget>[
//                                     Text(
//                                         'Are you sure want to cancel booking?'),
//                                   ],
//                                 ),
//                               ),
//                               actions: <Widget>[
//                                 TextButton(
//                                   child: const Text('No'),
//                                   onPressed: () {
//                                     // Navigator.of(context).pop();
//                                   },
//                                 ),
//                                 TextButton(
//                                   child: const Text('Yes'),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         );

// // --- Button Widget --- //

//                         setState(() {
//                           //cart.add(contents[index]);

//                           //temparray.add(contents[index]);
//                           if (cart.contains(contents[index])) {
//                             cart.remove(contents[index]);
//                           } else {
//                             cart.add(contents[index]);
//                             //temparray.add(sub[index].toString());
//                           }
//                         });
//                         // showModalBottomSheet<void>(
//                         //   context: context,
//                         //   builder: (BuildContext context) {
//                         //     return SizedBox(
//                         //       height: 800,
//                         //       child: ListView.builder(
//                         //           itemCount: temparray.length,
//                         //           itemBuilder: (context, index) {
//                         //             return Builder(builder: (context) {
//                         //               return Card(
//                         //                 child: ListTile(
//                         //                   leading:
//                         //                       Text(temparray[index].toString()),
//                         //                   subtitle: Text("uhyvluyfu"),
//                         //                 ),
//                         //               );
//                         //             });
//                         //           }),
//                         //     );
//                         //   },
//                         // );

                   
//                       },
//                       child: Card(
//                         child: ListTile(
//                           leading: Text(contents[index].title.toString()),
//                           // subtitle: Text([sub[index]].toString()),
//                           // title: InkWell(
//                           //   onTap: () {},
//                           //   child: Container(
//                           //     height: 50.h,
//                           //     width: 80.w,
//                           //     decoration: BoxDecoration(
//                           //         color: Colors.green,
//                           //         borderRadius: BorderRadius.circular(20)),
//                           //     child: Center(child: Text("ADd")),
//                           //   ),
//                           // ),
//                           trailing: Container(
//                             height: 50.h,
//                             width: 80.w,
//                             decoration: BoxDecoration(
//                                 color: cart.contains(contents[index])
//                                     ? Colors.red
//                                     : Colors.green,
//                                 borderRadius: BorderRadius.circular(20)),
//                             child: Center(
//                                 child: cart.contains(contents[index])
//                                     ? Text("Remove")
//                                     : Text("Add")),
//                           ),
//                         ),
//                       ),
//                     );
//                   });
//                 }),
//           ),
//           // Text(cart.toString()),
//         ],
//       ),
//       floatingActionButton: cart.length > 1 
//           ? FloatingActionButton(
//               child: Icon(Icons.add),
//               onPressed: () {
//                 showModalBottomSheet<void>(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return SizedBox(
//                       height: 800,
//                       child: ListView.builder(
//                           itemCount: cart.length,
//                           itemBuilder: (context, index) {
//                             return Builder(builder: (context) {
//                               return Card(
//                                 child: ListTile(
//                                   leading: Text(cart[index].title.toString()),
//                                   subtitle:
//                                       Text(cart[index].discription.toString()),
//                                 ),
//                               );
//                             });
//                           }),
//                     );
//                   },
//                 );
//               })
//           : Container(),
//     );
//   }
// }
