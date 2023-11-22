// import 'package:flutter/material.dart';

// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   String? selectedCategory;
//   String? selectedSubcategory;
//   List<String> categories = ['Mobile', 'Labtop', 'Fruit'];

//   List<String> categories2 = [
//     'Category 1 ',
//     'Category2 ',
//     'Category3 ',
//     'Category4 ',
//     'Category5 '
//   ];

//   // Map to hold subcategories for each category
//   Map<String, List<String>> subcategories = {
//     'Category 1': ['Subcategory 1.1', 'Subcategory 1.2', 'Subcategory 1.3'],
//     'Category 2': ['Subcategory 2.1', 'Subcategory 2.2', 'Subcategory 2.3'],
//     'Category 3': ['Subcategory 3.1', 'Subcategory 3.2', 'Subcategory 3.3'],
//   };

//   // Function to clear the items in the subcategory dropdown
//   void clearSubcategoryDropdown() {
//     setState(() {
//       selectedSubcategory = null;
//       // Set the items to an empty list to clear the subcategory dropdown
//       // subcategories[selectedCategory] = [];
//     });
//   }

//   List parentSports = [
//     {
//       "parentSportName": "Basketball",
//       "sports": [
//         {"sportName": "Men's Basketball", "path": "mbasket", "sportID": 7},
//         {"sportName": "Women's BasketBall", "path": "wcc", "sportID": 8},
//         {"sportName": "BasketballMen's ", "path": "mbasket", "sportID": 7},
//         {"sportName": "Women's B", "path": "wcc", "sportID": 8},
//         {"sportName": "Men's Bask", "path": "mbasket", "sportID": 7},
//         {"sportName": "Women's ", "path": "wcc", "sportID": 8}
//       ]
//     },
//     {
//       "parentSportName": "Cross Country",
//       "sports": [
//         {"sportName": "Women's Cross Country", "path": "wbasket", "sportID": 9},
//         {"sportName": "Men's Cross Country", "path": "mcc", "sportID": 10}
//       ]
//     },
//     {
//       "parentSportName": "Cricket",
//       "sports": [
//         {"sportName": "Women's Cross Cricket", "path": "wbasket", "sportID": 9},
//         {"sportName": "Men's Cross Country", "path": "mcc", "sportID": 10}
//       ]
//     },
//     {
//       "parentSportName": "hocky",
//       "sports": [
//         {"sportName": "Women's Cross hocky", "path": "wbasket", "sportID": 9},
//         {"sportName": "Men's Cross Country", "path": "mcc", "sportID": 10}
//       ]
//     }
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(actions: []),
//         body: ListView(
//           children: [
//             for (int i = 0; i < parentSports.length; i++)
//               Container(
//                 margin: EdgeInsets.all(9),
//                 height: 250,
//                 width: 400,
//                 color: Colors.red,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                         child: Text(
//                             parentSports[i]["parentSportName"].toString())),
//                     Expanded(
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           shrinkWrap: true,
//                           itemCount: parentSports[i]["sports"].length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               margin: EdgeInsets.all(10),
//                               height: 50,
//                               width: 100,
//                               color: Colors.yellow,
//                               child: Text(parentSports[i]["sports"][index]
//                                       ["sportName"]
//                                   .toString()),
//                             );
//                           }),
//                     ),
//                   ],
//                 ),
//               ),
//             Container(
//               height: 100,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.all(10),
//                       height: 50,
//                       width: 100,
//                       color: Colors.yellow,
//                     );
//                   }),
//             ),

//             // Container(
//             //   margin: EdgeInsets.all(9),
//             //   height: 300,
//             //   width: 400,
//             //   color: Colors.red,
//             // ),
//             // Container(
//             //   margin: EdgeInsets.all(9),
//             //   height: 300,
//             //   width: 400,
//             //   color: Colors.red,
//             // )
//           ],
//         )

//         //  Column(
//         //   children: [
//         //     for (int i = 0; i < categories.length; i++) Text("Category"),
//         //     ListView.builder(
//         //         shrinkWrap: true,
//         //         itemCount: 5,
//         //         itemBuilder: (context, index) {
//         //           return Column(
//         //             children: [
//         //               // ListView.builder(
//         //               //     scrollDirection: Axis.horizontal,
//         //               //     shrinkWrap: true,
//         //               //     itemCount: 4,
//         //               //     itemBuilder: (context, index1) {
//         //               //       return Text("djnkj");
//         //               //     }),
//         //               // ListTile(
//         //               //   title: Text("DJLKJ"),
//         //               // ),
//         //               ListView(
//         //                 shrinkWrap: true,
//         //                 scrollDirection: Axis.horizontal,
//         //                 children: [Text("dn;kl")],
//         //               ),
//         //               //      ListView(
//         //               // scrollDirection: Axis.horizontal,
//         //               // children: new List.generate(10, (int index) {
//         //               //   return new Card(
//         //               //     color: Colors.blue[index * 100],
//         //               //     child: new Container(
//         //               //       width: 50.0,
//         //               //       height: 50.0,
//         //               //       child: new Text("$index"),
//         //               //     ),
//         //               //   )})
//         //               Text("Category"),
//         //               Text("subcategories")
//         //             ],
//         //           );
//         //         })
//         //   ],
//         // ),

//         );
//   }
// }

// class Temperatures {
//   final int categoryId;
//   final String name;
//   final List<SubCategory> subCategories;

//   Temperatures({
//     required this.categoryId,
//     required this.name,
//     required this.subCategories,
//   });
// }

// class SubCategory {
//   final int subCategoryId;
//   final String name;

//   SubCategory({
//     required this.subCategoryId,
//     required this.name,
//   });
// }

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/monthModel.dart';
import '../../utils/color.dart';
import '../../utils/text_style.dart';

class MyFileList extends StatefulWidget {
  @override
  _MyFileListState createState() => _MyFileListState();
}

class _MyFileListState extends State<MyFileList> {
  List<String> selectedPDFs = [];

  Future<void> _openFileExplorer(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      List<String> pdfPaths = result.files
          .map((file) => file.path!)
          .where((path) => path.toLowerCase().endsWith('.pdf'))
          .toList();

      setState(() {
        selectedPDFs.addAll(pdfPaths);
      });

      print('Selected PDFs paths: $selectedPDFs');
      // Handle selected PDF files according to your needs
    } else {
      // User canceled the picker
      print('User canceled the file picker');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF File List'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: 400,
            child: RepeatedDropdown(
              options: timeappointment,
              selectedOption: timeappointment,
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text("click"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFileExplorer(context),
        tooltip: 'Select PDFs',
        child: Icon(Icons.add),
      ),
    );
  }
}

class RepeatedDropdown extends StatefulWidget {
  final List<dynamic> options;
  dynamic selectedOption;

  RepeatedDropdown({required this.options, required this.selectedOption});

  @override
  _RepeatedDropdownState createState() =>
      _RepeatedDropdownState(selectedOption: selectedOption);
}

class _RepeatedDropdownState extends State<RepeatedDropdown> {
  dynamic selectedOption;

  _RepeatedDropdownState({this.selectedOption});
  dynamic _selectedOption; // Default selected option

  // @override
  // void initState() {
  //   super.initState();
  //   //_selectedOption;
  //   _selectedOption = widget.options.first; // Set default value
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // DropdownButton<String>(
          //   value: _selectedOption,
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       _selectedOption = newValue!;
          //     });
          //   },
          //   items: widget.options.map<DropdownMenuItem<String>>((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          // ),
          Container(
            padding: EdgeInsets.only(left: 10.r, right: 10.r),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField2(
                isDense: false,
                isExpanded: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: AppColors.hintcolor, width: 1.0),
                  ),
                  isCollapsed: true,
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please Select University Visit';
                  }
                  return null;
                },
                hint: Text(
                  'Please Select University Visit',
                  style: batchtext2(AppColors.hintcolor),
                ),
                items: widget.options
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item.name.toString(),
                            style: batchtext2(AppColors.PrimaryMainColor),
                          ),
                        ))
                    .toList(growable: false),
                value: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                    widget.selectedOption = _selectedOption.name;

                    print(widget.selectedOption);
                    // widget.universitydrop = value;

                    // print(
                    //     universitydrop?.name.toString());
                    // print(gofairlistdata.length);

                    // isSelected = true;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: 55.h,
                  padding: EdgeInsets.all(10.r),
                ),
                dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppColors.PrimaryWhiteColor,
                        border: Border.all()),
                    maxHeight: 300.h,
                    elevation: 10),
                menuItemStyleData: MenuItemStyleData(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 40.h,
                ),
                onMenuStateChange: (isOpen) {
                  if (isOpen) {
                    // textEditingController.clear();
                  }
                },
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.PrimaryMainColor,
                  ),
                  iconSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Option {
  final int id;
  final String name;

  Option(this.id, this.name);
}
