// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   File? imageFile;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select & Crop Image'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20.0,
//             ),
//             Text(imageFile.toString()),
//             imageFile == null
//                 ? Image.asset(
//                     "assets/images/uploadimg.png",
//                     height: 300.0,
//                     width: 300.0,
//                   )
//                 : ClipRRect(
//                     borderRadius: BorderRadius.circular(150.0),
//                     child: Image.file(
//                       imageFile!,
//                       height: 300.0,
//                       width: 300.0,
//                       fit: BoxFit.fill,
//                     )),
//             const SizedBox(
//               height: 20.0,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 Map<Permission, PermissionStatus> statuses = await [
//                   Permission.storage,
//                   Permission.camera,
//                 ].request();
//                 if (statuses[Permission.storage]!.isGranted &&
//                     statuses[Permission.camera]!.isGranted) {
//                   showImagePicker(context);
//                 } else {
//                   print("csknnkcd");
//                   //   Map<Permission, PermissionStatus> statuses = await [
//                   //     Permission.storage,
//                   //     Permission.camera,
//                   //   ].request();
//                   //   if (statuses[Permission.storage]!.isGranted &&
//                   //       statuses[Permission.camera]!.isGranted) {
//                   //     showImagePicker(context);
//                   //   }
//                 }
//               },
//               child: Text('Select Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   final picker = ImagePicker();

//   void showImagePicker(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (builder) {
//           return Card(
//             child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 5.2,
//                 margin: const EdgeInsets.only(top: 8.0),
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                         child: InkWell(
//                       child: const Column(
//                         children: const [
//                           Icon(
//                             Icons.image,
//                             size: 60.0,
//                           ),
//                           SizedBox(height: 12.0),
//                           Text(
//                             "Gallery",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontSize: 16, color: Colors.black),
//                           )
//                         ],
//                       ),
//                       onTap: () {
//                         _imgFromGallery();
//                         Navigator.pop(context);
//                       },
//                     )),
//                     Expanded(
//                         child: InkWell(
//                       child: SizedBox(
//                         child: Column(
//                           children: const [
//                             Icon(
//                               Icons.camera_alt,
//                               size: 60.0,
//                             ),
//                             SizedBox(height: 12.0),
//                             Text(
//                               "Camera",
//                               textAlign: TextAlign.center,
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.black),
//                             )
//                           ],
//                         ),
//                       ),
//                       onTap: () {
//                         _imgFromCamera();
//                         Navigator.pop(context);
//                       },
//                     ))
//                   ],
//                 )),
//           );
//         });
//   }

//   _imgFromGallery() async {
//     await picker
//         .pickImage(source: ImageSource.gallery, imageQuality: 50)
//         .then((value) {
//       if (value != null) {
//         _cropImage(File(value.path));
//       }
//     });
//   }

//   _imgFromCamera() async {
//     await picker
//         .pickImage(source: ImageSource.camera, imageQuality: 50)
//         .then((value) {
//       if (value != null) {
//         _cropImage(File(value.path));
//       }
//     });
//   }

//   _cropImage(File imgFile) async {
//     final croppedFile = await ImageCropper().cropImage(
//         sourcePath: imgFile.path,
//         aspectRatioPresets: Platform.isAndroid
//             ? [
//                 CropAspectRatioPreset.square,
//                 CropAspectRatioPreset.ratio3x2,
//                 CropAspectRatioPreset.original,
//                 CropAspectRatioPreset.ratio4x3,
//                 CropAspectRatioPreset.ratio16x9
//               ]
//             : [
//                 CropAspectRatioPreset.original,
//                 CropAspectRatioPreset.square,
//                 CropAspectRatioPreset.ratio3x2,
//                 CropAspectRatioPreset.ratio4x3,
//                 CropAspectRatioPreset.ratio5x3,
//                 CropAspectRatioPreset.ratio5x4,
//                 CropAspectRatioPreset.ratio7x5,
//                 CropAspectRatioPreset.ratio16x9
//               ],
//         uiSettings: [
//           AndroidUiSettings(
//               toolbarTitle: "Image Cropper",
//               toolbarColor: Colors.deepOrange,
//               toolbarWidgetColor: Colors.white,
//               initAspectRatio: CropAspectRatioPreset.original,
//               lockAspectRatio: false),
//           IOSUiSettings(
//             title: "Image Cropper",
//           )
//         ]);
//     if (croppedFile != null) {
//       imageCache.clear();
//       setState(() {
//         imageFile = File(croppedFile.path);
//       });
//       // reload();
//     }
//   }
// }

import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 300,
            height: 200,
            margin: const EdgeInsets.only(top: 24, bottom: 16),
            decoration: ShapeDecoration(
                shape: WeirdBorder(radius: 32), color: Colors.red),
          ),
          Container(
            width: 200,
            height: 100,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: ShapeDecoration(
                shape: WeirdBorder(radius: 16, pathWidth: 8),
                color: Colors.green),
          ),
          Container(
            width: 300,
            height: 200,
            decoration: ShapeDecoration(
                shape: WeirdBorder(radius: 12, pathWidth: 2),
                color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class WeirdBorder extends ShapeBorder {
  final double radius;
  final double pathWidth;

  WeirdBorder({required this.radius, this.pathWidth = 1});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect, textDirection: textDirection), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _createPath(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => WeirdBorder(radius: radius);

  Path _createPath(Rect rect) {
    final innerRadius = radius + pathWidth;
    final innerRect = Rect.fromLTRB(rect.left + pathWidth, rect.top + pathWidth,
        rect.right - pathWidth, rect.bottom - pathWidth);

    final outer = Path.combine(PathOperation.difference, Path()..addRect(rect),
        _createBevels(rect, radius));
    final inner = Path.combine(PathOperation.difference,
        Path()..addRect(innerRect), _createBevels(rect, innerRadius));
    return Path.combine(PathOperation.difference, outer, inner);
  }

  Path _createBevels(Rect rect, double radius) {
    return Path()
      ..addOval(
          Rect.fromCircle(center: Offset(rect.left, rect.top), radius: radius))
      ..addOval(Rect.fromCircle(
          center: Offset(rect.left + rect.width, rect.top), radius: radius))
      ..addOval(Rect.fromCircle(
          center: Offset(rect.left, rect.top + rect.height), radius: radius))
      ..addOval(Rect.fromCircle(
          center: Offset(rect.left + rect.width, rect.top + rect.height),
          radius: radius));
  }
}
