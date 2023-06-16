// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// class FileUploadPage extends StatefulWidget {
//   @override
//   _FileUploadPageState createState() => _FileUploadPageState();
// }

// class _FileUploadPageState extends State<FileUploadPage> {
//   File? files;
//   int selectedIndex = -1;

//   Future<void> _uploadFile(int index) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       // String? filePath = result.files.single.path;

//       setState(() {
//         files = File(result.files.single.path!);
//       });

//       print('Selected file at index $index: $files');
//     }
//   }

//   String? path;
//   String? showfile;

//   selectFileByIndex(int index) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       path = result.files.single.path!;
//       if (path != null) {
//         setState(() {
//           showfile = path!;
//         });

//         print("edkll" + "${index} kkfk" + "${showfile}");
//         // Handle the selected file using the given index

//         print('Selected file at index $index: $path');
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   selectFile(int index) {
//     showfile;
//     // ignore: unrelated_type_equality_checks
//     return showfile;
//   }

//   List item = ["1", "2", "3"];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('File Upload'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               //  _uploadFile();
//               //  print(selectedIndex);
//             },
//             child: Text('Upload File'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: item.length,
//               itemBuilder: (BuildContext context, int index) {
//                 String fileName =
//                     files != null ? files!.path : 'No file selected';
//                 return ListTile(
//                   title: Column(
//                     children: [
//                       // Text(files[index]),
//                       InkWell(
//                           onTap: () {
//                             selectFileByIndex(index);
//                             // selectFileByIndex(index);
//                             setState(() {
//                               // selectFile(index);
//                             });
//                           },
//                           child: Column(
//                             children: [
//                               // Text(files != null ? files!.path : ''),
//                               Text(index.toString()),
//                               // for (int i = 0; i <= fileName.length; i++)
//                               Text(selectFile(index).toString()),

//                               // Text("$index" + selectFile(index).toString())
//                             ],
//                           ))
//                     ],
//                   ),
//                   // selected: selectedIndex == index,
//                   //onTap: () => selectFile(index),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;
// import 'package:file_picker/file_picker.dart';

// class FileData {
//   File file;
//   String fieldName;

//   FileData(this.file, this.fieldName);
// }

// class FileHandlingScreen extends StatefulWidget {
//   @override
//   _FileHandlingScreenState createState() => _FileHandlingScreenState();
// }

// class _FileHandlingScreenState extends State<FileHandlingScreen> {
//   List fileDataList = [];

//   List addfile = []; // List to store file data
//   String? fileName;
//   int selectedIndex = -1;

//   void addFileData(int index) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       List<File> pickedFiles = result.paths.map((path) => File(path!)).toList();
//       for (File file in pickedFiles) {
//         fileName = path.basename(file.path);
//         //debugger();
//         FileData fileData = FileData(file, fileName!);

//         setState(() {
//           fileDataList.add(fileData);

//           print("edbjbljfe" + fileData.fieldName.toString());
//           // Add file data to the list
//           selectedIndex = index;
//           print("$index: $fileName");
//         });
//       }
//     }
//   }

//   void removeFileData(int index) {
//     setState(() {
//       fileDataList.removeAt(index); // Remove file data from the list
//     });
//   }

//   // adddFileData(int index) {
//   //   return fileDataList.contains(index); // Remove file data from the list
//   // }

//   showfile(int index) {
//     String? fileData = fileName;

//     // index == selectedIndex;
//     // if (selectedIndex == index) {
//     //   print("3");
//     // }

//     // fileData = selectedIndex.toString();
//     return fileData;
//   }

//   List item = [1, 2, 3, 4];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('File Handling'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: item.length,
//               itemBuilder: (context, index) {
//                 // FileData fileData = fileDataList[index];

//                 return ListTile(
//                   title: Column(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           // debugger();
//                           setState(() {
//                             //selectedIndex = index;

//                             //   String filedata = fileName;
//                             print(selectedIndex);
//                             showfile(selectedIndex);

//                             print(
//                                 "$index" + showfile(selectedIndex).toString());
//                             addFileData(index);

//                             addfile.contains(fileDataList);
//                             // print(addfile);
//                           });
//                         },
//                         child: Text('Add File'),
//                       ),

//                       //  Text(showfile(selectedIndex).toString()),

//                       selectedIndex == index
//                           ? Text("$index" + showfile(index).toString())
//                           : Container(),

//                       Text(item[index].toString()),
//                       // for (int i = 0; i < fileDataList.length; i++)
//                       //   Text(fileDataList[i].toString())
//                     ],
//                   ),
//                   // trailing: IconButton(
//                   //   icon: Icon(Icons.remove),
//                   //   onPressed: () => removeFileData(index),
//                   // ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final int? index;
  final String? title;
  final String? imageUrl;
  final Function(Post)? removePost;

  const Post({Key? key, this.index, this.title, this.imageUrl, this.removePost})
      : super(key: key);

//  factory Post.fromDocument(DocumentSnapshot doc) {
//    return Post(
//      title: doc['title'],
//      imageUrl: doc['imageUrl'],
//    );
//  }

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  // List<String> selectedFiles = [];

  // List addfile = [];

  // Future<void> _pickFiles() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(allowMultiple: true);

  //   if (result != null) {
  //     setState(() {
  //       selectedFiles = result.paths.map((path) => path!).toList();
  //       // addfile.add(selectedFiles);
  //       print(selectedFiles);
  //     });
  //   }
  // }

  List<String> files = [];
  List addfile = [];
  List joindata = [];
  // List<String> selectedFiles = [];

  int selectedIndex = -1;
  // Future<void> _uploadFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     String? filePath = result.files.single.path;
  //     if (filePath != null) {
  //       setState(() {
  //         files.add(filePath);
  //         addfile.add(files);
  //         print("+++++ $files");
  //         print("+++++ $addfile");

  //         //join list2 to list1
  //         //  addfile.forEach((element) => joindata.add(element));

  //         print("edcjknkrfkj $joindata");
  //       });
  //     }
  //   }
  // }

  List<File> selectedFile = [];
  List<TextEditingController> selectedfiledata = [];
  bool isFileSelected = false;
  void selectFile() async {
    if (selectedFile.length > 11) {
      // ToastHelper().showErrorToast(message: 'File Cannot Select more than 12.');
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        if (files.length + selectedFile.length > 12) {
          // ToastHelper()
          //     .showErrorToast(message: 'File Cannot Select more than 12.');
        } else {
          setState(() {
            selectedFile.addAll(files);
            print(selectedFile);
            // selectedFilePassword.a
            isFileSelected = true;
          });
          for (int i = 0; i < selectedFile.length; i++) {
            TextEditingController controller = TextEditingController();
            selectedfiledata.add(controller);
          }
        }
      } else {
        // User canceled the picker
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: SingleChildScrollView(
            child: Container(
              height: 200,
              child: Column(
                children: <Widget>[
                  Text(selectedFile.toString() +
                      widget.index.toString()), // Testing passed index here
                  // Text(widget.imageUrl.toString()),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (joindata.contains(files)) {
                          joindata.add(files);
                        }
                        selectFile();
                        //  addfile.add(files);
                        // addfile.add(
                        //     selectedFiles.toString() + widget.index.toString());
                        print(addfile);
                      });
                    },
                    // => widget.removePost!(widget),
                    icon: Icon(Icons.delete),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
