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

  String? _selectedDropdownOption;

  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 90.h,
          ),
          SizedBox(
            height: 50.h,
            width: 300.w,
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
                      height: 50.h,
                      width: 200.w,
                      child: StatefulBuilder(
                        builder: (BuildContext context, change) {
                          return CheckboxListTile(
                            title: Text(option),
                            value: _selectedFruits.contains(option),
                            onChanged: (_) {
                              change(() {
                                setState(() {
                                  _selectedFruits.contains(option)
                                      ? _selectedFruits.remove(option)
                                      : _selectedFruits.add(option);
                                });
                              });
                            },
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



//PODS:
//   - connectivity_plus (0.0.1):
//     - Flutter
//     - ReachabilitySwift
//   - DKImagePickerController/Core (4.3.4):
//     - DKImagePickerController/ImageDataManager
//     - DKImagePickerController/Resource
//   - DKImagePickerController/ImageDataManager (4.3.4)
//   - DKImagePickerController/PhotoGallery (4.3.4):
//     - DKImagePickerController/Core
//     - DKPhotoGallery
//   - DKImagePickerController/Resource (4.3.4)
//   - DKPhotoGallery (0.0.17):
//     - DKPhotoGallery/Core (= 0.0.17)
//     - DKPhotoGallery/Model (= 0.0.17)
//     - DKPhotoGallery/Preview (= 0.0.17)
//     - DKPhotoGallery/Resource (= 0.0.17)
//     - SDWebImage
//     - SwiftyGif
//   - DKPhotoGallery/Core (0.0.17):
//     - DKPhotoGallery/Model
//     - DKPhotoGallery/Preview
//     - SDWebImage
//     - SwiftyGif
//   - DKPhotoGallery/Model (0.0.17):
//     - SDWebImage
//     - SwiftyGif
//   - DKPhotoGallery/Preview (0.0.17):
//     - DKPhotoGallery/Model
//     - DKPhotoGallery/Resource
//     - SDWebImage
//     - SwiftyGif
//   - DKPhotoGallery/Resource (0.0.17):
//     - SDWebImage
//     - SwiftyGif
//   - file_picker (0.0.1):
//     - DKImagePickerController/PhotoGallery
//     - Flutter
//   - Flutter (1.0.0)
//   - image_picker_ios (0.0.1):
//     - Flutter
//   - path_provider_foundation (0.0.1):
//     - Flutter
//     - FlutterMacOS
//   - ReachabilitySwift (5.0.0)
//   - SDWebImage (5.18.1):
//     - SDWebImage/Core (= 5.18.1)
//   - SDWebImage/Core (5.18.1)
//   - shared_preferences_foundation (0.0.1):
//     - Flutter
//     - FlutterMacOS
//   - smart_auth (0.0.1):
//     - Flutter
//   - SwiftyGif (5.4.4)
//   - url_launcher_ios (0.0.1):
//     - Flutter

// DEPENDENCIES:
//   - connectivity_plus (from `.symlinks/plugins/connectivity_plus/ios`)
//   - file_picker (from `.symlinks/plugins/file_picker/ios`)
//   - Flutter (from `Flutter`)
//   - image_picker_ios (from `.symlinks/plugins/image_picker_ios/ios`)
//   - path_provider_foundation (from `.symlinks/plugins/path_provider_foundation/darwin`)
//   - shared_preferences_foundation (from `.symlinks/plugins/shared_preferences_foundation/darwin`)
//   - smart_auth (from `.symlinks/plugins/smart_auth/ios`)
//   - url_launcher_ios (from `.symlinks/plugins/url_launcher_ios/ios`)

// SPEC REPOS:
//   trunk:
//     - DKImagePickerController
//     - DKPhotoGallery
//     - ReachabilitySwift
//     - SDWebImage
//     - SwiftyGif

// EXTERNAL SOURCES:
//   connectivity_plus:
//     :path: ".symlinks/plugins/connectivity_plus/ios"
//   file_picker:
//     :path: ".symlinks/plugins/file_picker/ios"
//   Flutter:
//     :path: Flutter
//   image_picker_ios:
//     :path: ".symlinks/plugins/image_picker_ios/ios"
//   path_provider_foundation:
//     :path: ".symlinks/plugins/path_provider_foundation/darwin"
//   shared_preferences_foundation:
//     :path: ".symlinks/plugins/shared_preferences_foundation/darwin"
//   smart_auth:
//     :path: ".symlinks/plugins/smart_auth/ios"
//   url_launcher_ios:
//     :path: ".symlinks/plugins/url_launcher_ios/ios"

// SPEC CHECKSUMS:
//   connectivity_plus: 413a8857dd5d9f1c399a39130850d02fe0feaf7e
//   DKImagePickerController: b512c28220a2b8ac7419f21c491fc8534b7601ac
//   DKPhotoGallery: fdfad5125a9fdda9cc57df834d49df790dbb4179
//   file_picker: ce3938a0df3cc1ef404671531facef740d03f920
//   Flutter: f04841e97a9d0b0a8025694d0796dd46242b2854
//   image_picker_ios: 4a8aadfbb6dc30ad5141a2ce3832af9214a705b5
//   path_provider_foundation: 29f094ae23ebbca9d3d0cec13889cd9060c0e943
//   ReachabilitySwift: 985039c6f7b23a1da463388634119492ff86c825
//   SDWebImage: ebdbcebc7933a45226d9313bd0118bc052ad458b
//   shared_preferences_foundation: 5b919d13b803cadd15ed2dc053125c68730e5126
//   smart_auth: 4bedbc118723912d0e45a07e8ab34039c19e04f2
//   SwiftyGif: 93a1cc87bf3a51916001cf8f3d63835fb64c819f
//   url_launcher_ios: 08a3dfac5fb39e8759aeb0abbd5d9480f30fc8b4

// PODFILE CHECKSUM: dbb0e6aba35bf829d8eac796a2593ccf1006133d

// COCOAPODS: 1.12.1
