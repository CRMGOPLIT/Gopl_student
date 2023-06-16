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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFormWidget extends StatefulWidget {
  const MyFormWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyFormWidgetState createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  List<String> _selectedFruits = [];

  // List<String> _selectedOptions = [];
  String? _selectedDropdownOption;

  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
    "dfwe",
    "eq1vq"
  ];

  // List<String> _options = [
  //   'Option 1',
  //   'Option 2',
  //   'Option 3',
  //   'Option 4',
  //   'Option 5',
  // ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ElevatedButton(
          //   onPressed: _addFormField,
          //   child: Text('Add Form Field'),
          // ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: _formFields.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return ListTile(
          //       title: TextField(
          //         decoration: InputDecoration(
          //           labelText: _formFields[index].label ?? 'Label',
          //           hintText: _formFields[index].hint ?? 'Hint',
          //         ),
          //       ),
          //       trailing: IconButton(
          //         icon: Icon(Icons.attach_file),
          //         onPressed: () async {
          //           FilePickerResult? result =
          //               await FilePicker.platform.pickFiles();
          //           if (result != null) {
          //             setState(() {
          //               _formFields[index].file =
          //                   File(result.files.single.path.toString());
          //             });
          //           }
          //         },
          //       ),
          //     );
          //   },
          // ),
          // Container(
          //   height: 200,
          //   child: ListView(
          //     children: _fruitsList
          //         .map(
          //           (fruit) => CheckboxListTile(
          //             title: Text(fruit),
          //             value: _selectedFruits.contains(fruit),
          //             onChanged: (value) {
          //               setState(() {
          //                 if (value!) {
          //                   _selectedFruits.add(fruit);
          //                 } else {
          //                   _selectedFruits.remove(fruit);
          //                 }
          //               });
          //             },
          //           ),
          //         )
          //         .toList(),
          //   ),
          // ),
          // Text(_selectedFruits.toString()),
          // Container(
          //   height: 200,
          //   child: ListView.builder(
          //     itemCount: _options.length,
          //     itemBuilder: (context, index) {
          //       return CheckboxListTile(
          //         title: Text(_options[index]),
          //         value: _selectedOptions.contains(_options[index]),
          //         onChanged: (selected) {
          //           setState(() {
          //             if (selected!) {
          //               _selectedOptions.add(_options[index]);
          //             } else {
          //               _selectedOptions.remove(_options[index]);
          //             }
          //           });
          //         },
          //       );
          //     },
          //   ),
          // ),
          // Container(
          //   height: 200,
          //   child: DropdownButton(
          //     hint: Text('Select options'),
          //     value: _selectedOptions.isNotEmpty ? _selectedOptions : null,
          //     onChanged: (newValue) {
          //       setState(() {
          //         _selectedOptions == newValue;
          //       });
          //     },
          //     items: _options.map((option) {
          //       return DropdownMenuItem(
          //         value: _selectedOptions.contains(option),
          //         child: Container(
          //           height: 200,
          //           width: 300,
          //           child: CheckboxListTile(
          //             title: Text(option),
          //             controlAffinity: ListTileControlAffinity.leading,
          //             value: _selectedOptions.contains(_options),
          //             onChanged: (selected) {
          //               setState(() {
          //                 if (selected!) {
          //                   _selectedOptions.add(_options.toString());
          //                 } else {
          //                   _selectedOptions.remove(_options);
          //                 }
          //               });
          //             },
          //           ),
          //         ),
          //       );
          //     }).toList(),
          //   ),
          // ),
          SizedBox(
            height: 90.h,
          ),
          SizedBox(
            height: 50,
            width: 300,
            child: DropdownButton(
              hint: const Text('Select options'),
              value: null,
              onChanged: (newValue) {
                setState(() {
                  _selectedFruits = newValue as List<String>;
                });
              },
              items: _options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Center(
                    child: SizedBox(
                      height: 50,
                      width: 200,
                      child: StatefulBuilder(
                        builder: (BuildContext context, change) {
                          return CheckboxListTile(
                            title: Text(option),
                            // controlAffinity: ListTileControlAffinity.leading,
                            value: _selectedFruits.contains(option),
                            onChanged: (_) {
                              change(() {
                                setState(() {
                                  _selectedFruits.contains(option)
                                      ? _selectedFruits.remove(option)
                                      : _selectedFruits.add(option);

                                  // print(_selectedFruits);
                                });
                              });
                            },
                            // onChanged: (value) {
                            //   setState(() {
                            //     if (value!) {
                            //      _selectedFruits.add(option);
                            //       print(_selectedFruits);
                            //     } else {
                            //       _selectedFruits.remove(option);
                            //       print(_selectedFruits);
                            //     }
                            //   });
                            // },
                          );
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          Text(_selectedFruits.toString()),

          DropdownButton(
            hint: const Text('Select an option'),
            value: _selectedDropdownOption,
            items: _options.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (selectedOption) {
              setState(() {
                _selectedDropdownOption = selectedOption;
              });
            },
          ),
        ],
      ),
    );
  }
}

class FormFieldData {
  String? label;
  String? hint;
  File? file;

  FormFieldData({this.label, this.hint, this.file});
}
