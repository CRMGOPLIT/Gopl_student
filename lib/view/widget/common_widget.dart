

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
