import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/dashboardBloc.dart';
import 'package:global_student/model/visamodelget.dart';
import 'package:global_student/utils/text_style.dart';

import '../../utils/color.dart';
import '../../utils/routes/routes_name.dart';
import 'app_bar.dart';
import 'button.dart';

class DialogDemo extends StatefulWidget {
  const DialogDemo({super.key});

  @override
  _DialogDemoState createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo> {
  // State and variables related to the dialog data
  String dialogData = '';

  // Method to show the dialog
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Data'),
          content: TextField(
            onChanged: (value) {
              dialogData = value;
            },
          ),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // Call a callback method with the retrieved data
                _dataCallback(dialogData);
              },
            ),
          ],
        );
      },
    );
  }

  // Callback method to handle retrieved data
  void _dataCallback(String data) {
    setState(() {
      // Update the state with the retrieved data
      dialogData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Data from Dialog: $dialogData'),
            ElevatedButton(
              child: Text('Open Dialog'),
              onPressed: _showDialog,
            ),
          ],
        ),
      ),
    );
  }
}

class VisaPage extends StatefulWidget {
  VisaPage({
    super.key,
  });

  @override
  State<VisaPage> createState() => _VisaPageState();
}

class _VisaPageState extends State<VisaPage> {
  String dropdownvalue = 'SDS';

  String selectedvalue = "";

  var data2 = Get.arguments;

  // List of items in our dropdown menu
  var items = [
    'SDS',
    'Non SDS',
  ];
  bool isSelected = false;
  File? file;

  void selected(value) {
    if (value == "Country") {
    } else if (value == "Item 2") {}
    setState(() {
      dropdownvalue = value;
      isSelected = false;
    });
  }

  bool loanding = true;
  late DashBoardBloc dashBoardBloc;
  List<VisaGetModel> datavisa = [];
  List batchData = [];
  List<String> selectedFiles = [];

  @override
  void initState() {
    dashBoardBloc = DashBoardBloc();
    getBranchDetails();
    _gethomeData();
    super.initState();
    // GetCourseData();
    // callcourseDetails();
  }

  List<String> files = [];
  // List<String> selectedFiles = [];

  int selectedIndex = -1;
  Future<void> _uploadFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          files.add(filePath);
        });
      }
    }
  }

  void _selectFile(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  getBranchDetails() async {
    dashBoardBloc.getvisadetailscontrollerStream.listen((event) {
      // debugger();
      // print(event);
      if (event != null) {
        batchData = event;
        for (int i = 0; i < batchData.length; i++) {
          VisaGetModel visaGetModel = VisaGetModel.fromJson(event[i]);

          datavisa.add(visaGetModel);

          // int cf = data[i].confirmedWithFullPayment;
          // int cp = data[i].confirmedWithPartialPayment;
          // int totl = int.parse(data[i].fBatchSize);

          // avl = totl - (cf + cp);
        }
        setState(() {
          loanding = false;
        });
      }
    });
  }
  //  Future<void> _pickFiles() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(allowMultiple: true);

  //   if (result != null) {
  //     setState(() {
  //       selectedFiles = result.paths.map((path) => path!).toList();
  //       print("selected file ");
  //     });
  //   }
  // }

  int count = 0;
  _gethomeData() {
    Map<String, String> visadata = {
      "f_countryid": data2[0].toString(),
      "f_CountryStream": "",
    };

    dashBoardBloc.callGetvisadetails(visadata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroungcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarCustom(
          title: "Apply Visa",
          onpress: () {
            Navigator.pushNamed(context, RoutesName.bottomnav);
          },
        ),
      ),
      body: loanding
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text("State",
                        //     style: FieldTextStyle(
                        //       AppColors.PrimaryBlackColor,
                        //     )),
                        Container(
                            height: 50.h,
                            width: 160.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.PrimaryWhiteColor),
                            child: Center(
                                child: Text(
                              "Canada",
                              style: FieldTextStyle(AppColors.PrimaryMainColor),
                            ))),

                        Container(
                          height: 50.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.PrimaryWhiteColor),
                          child: DropdownButtonFormField(
                            // hint: Text("djkbkjbe"),
                            style: const TextStyle(
                                color: AppColors.PrimaryMainColor,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: const BorderSide(
                                    color: AppColors.PrimaryGreyColor,
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: const BorderSide(
                                  color: AppColors.PrimaryBlackColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            value: dropdownvalue,
                            isExpanded: true,
                            icon: Padding(
                              padding: EdgeInsets.only(
                                right: 10.r,
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 25.sp,
                                color: AppColors.PrimaryMainColor,
                              ),
                            ),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.r),
                                  child: Text(items),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedvalue = newValue!;
                                isSelected = true;
                                // selected(dropdownvalue);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(data2[1].toString()),
                    Container(
                      height: 800,
                      child: ListView.builder(
                          itemCount: datavisa.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Post(
                                    // index: index,
                                    // titled: datavisa[index]
                                    //     .fDocumentName
                                    //     .toString(),
                                    // imageUrl: files.toString(),
                                    removePost: () {}),
                                ElevatedButton(
                                    onPressed: () {
                                      _uploadFile(index);
                                    },
                                    child: Text("Upload"))
                              ],
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.r, left: 15.r, right: 15.r),
            child: ButtonPrimary(
              title: "Submit",
              onPressed: () {},
            ),
          )),
    );
  }

  // void selectFiles(int index) async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowMultiple: false,
  //       allowedExtensions: ['pdf', 'docx'],
  //       type: FileType.custom,
  //     );

  //     if (result != null) {
  //       setState(() {
  //         file = File(result.files.single.path!);
  //       });
  //     } else {
  //       // User canceled the picker
  //     }
  //   } catch (e) {
  //     // debugger();
  //     //print(e);
  //   }
  // }
}

class ApplyVisaone extends StatelessWidget {
  const ApplyVisaone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Text("IMM 1294 From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("IMM 5654 From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("SPQ From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("Passport  copy color front and back page",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}

class ApplyVisaTwo extends StatelessWidget {
  const ApplyVisaTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Text("IMM 1294 From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("IMM 5654 From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("SPQ From",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text("Passport  copy color front and back page",
            style: FieldTextStyle(
              AppColors.PrimaryBlackColor,
            )),
        Container(
          height: 70.h,
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.PrimaryWhiteColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Icon(
            Icons.upload,
            size: 50.sp,
            color: AppColors.PrimaryMainColor,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: AppColors.PrimaryWhiteColor,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 8, //or null
                decoration: InputDecoration.collapsed(
                  hintText: "Remarks",
                ),
              ),
            )),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}

class Post extends StatefulWidget {
  final int? index;
  final String? titled;
  final String? imageUrl;
  final Function removePost;

  const Post(
      {Key? key,
      this.index,
      this.titled,
      this.imageUrl,
      required this.removePost})
      : super(key: key);

//  factory Post.fromDocument(DocumentSnapshot doc) {
//    return Post(
//      title: doc['title'],
//      imageUrl: doc['imageUrl'],
//    );
//  }

  @override
  _PostState createState() =>
      _PostState(titled: titled, removePost: removePost, imageUrl: imageUrl);
}

class _PostState extends State<Post> {
  final int? index;
  final String? titled;
  final String? imageUrl;
  final Function removePost;
  _PostState(
      {this.index, this.titled, this.imageUrl, required this.removePost});
  List<String> selectedFiles = [];

  String dropdownvalue = 'SDS';

  String selectedvalue = "";

  var data2 = Get.arguments;

  // List of items in our dropdown menu
  var items = [
    'SDS',
    'Non SDS',
  ];
  bool isSelected = false;
  File? file;

  void selected(value) {
    if (value == "Country") {
    } else if (value == "Item 2") {}
    setState(() {
      dropdownvalue = value;
      isSelected = false;
    });
  }

  // bool loanding = true;
  // late DashBoardBloc dashBoardBloc;
  // List<VisaGetModel> datavisa = [];
  // List batchData = [];

  // @override
  // void initState() {
  //   dashBoardBloc = DashBoardBloc();
  //   getBranchDetails();
  //   _gethomeData();
  //   super.initState();
  //   // GetCourseData();
  //   // callcourseDetails();
  // }

  // List<String> files = [];
  // // List<String> selectedFiles = [];

  // int selectedIndex = -1;
  // Future<void> _uploadFile(int index) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     String? filePath = result.files.single.path;
  //     if (filePath != null) {
  //       setState(() {
  //         files.add(filePath);
  //       });
  //     }
  //   }
  // }

  // void _selectFile(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }

  // getBranchDetails() async {
  //   dashBoardBloc.getvisadetailscontrollerStream.listen((event) {
  //     // debugger();
  //     // print(event);
  //     if (event != null) {
  //       batchData = event;
  //       for (int i = 0; i < batchData.length; i++) {
  //         VisaGetModel visaGetModel = VisaGetModel.fromJson(event[i]);

  //         datavisa.add(visaGetModel);

  //         // int cf = data[i].confirmedWithFullPayment;
  //         // int cp = data[i].confirmedWithPartialPayment;
  //         // int totl = int.parse(data[i].fBatchSize);

  //         // avl = totl - (cf + cp);
  //       }
  //       setState(() {
  //         loanding = false;
  //       });
  //     }
  //   });
  // }

  // int count = 0;
  // _gethomeData() {
  //   Map<String, String> visadata = {
  //     "f_countryid": data2[0].toString(),
  //     "f_CountryStream": "",
  //   };

  //   dashBoardBloc.callGetvisadetails(visadata);
  // }

  Future<void> _pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        selectedFiles = result.paths.map((path) => path!).toList();
        print("selected file ");
      });
    }
  }

  List<String> files = [];
  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          files.add(filePath);
          print(files);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          child: Column(
            children: [
              // for (int i = 0; i < datavisa.length; i++)
              Text("$titled"),
              Text("$imageUrl"),
              Text(files.toString()), Text(""), // Testing passed index here
              // Text(widget.imageUrl.toString()),
              // IconButton(
              //   onPressed: () {
              //     removePost;
              //     // setState(() {
              //     //   //files.add(file.toString());

              //     //   print(files.toString());
              //     //   _uploadFile();
              //     // });
              //   },
              //   // => widget.removePost!(widget),
              //   icon: Icon(Icons.delete),
              // )
            ],
          ),
        )
      ],
    );
    // Expanded(
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: datavisa.length,
    //     itemBuilder: (context, index) {
    //       return ListTile(
    //         leading: Icon(Icons.add),
    //         title: Column(
    //           children: [
    //             Text(datavisa[index].fDocumentName.toString()),
    //             // ElevatedButton(
    //             //   onPressed: () {
    //             //     //  _pickFiles(index);
    //             //   },
    //             //   child: Text('Upload Files'),
    //             // ),
    //             // Text(selectedFiles[index]),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}

class FileItem {
  String name;
  String path;

  FileItem({required this.name, required this.path});
}

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  List<FileItem> selectedFiles = [];

  void selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      List<FileItem> files = result.paths.map((path) {
        String fileName = path!.split('/').last;
        return FileItem(name: fileName, path: path);
      }).toList();

      setState(() {
        selectedFiles = files;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: selectFiles,
            child: Text('Select Files'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedFiles.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(selectedFiles[index].name),
                  subtitle: Text(selectedFiles[index].path),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
