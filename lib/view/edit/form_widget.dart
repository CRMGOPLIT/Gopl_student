import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/view/edit/form_model.dart';

// ignore: must_be_immutable
class ContactFormItemWidget extends StatefulWidget {
  ContactFormItemWidget(
      {Key? key,
      required this.contactModel,
      required this.onRemove,
      this.index})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final index;
  ContactModel contactModel;
  final Function onRemove;
  final state = _ContactFormItemWidgetState();

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return state;
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
}

class _ContactFormItemWidgetState extends State<ContactFormItemWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)).w,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Contact - ${widget.index}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: Colors.orange),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                //Clear All forms Data
                                widget.contactModel.name = "";
                                widget.contactModel.number = "";
                                widget.contactModel.email = "";
                                widget._nameController.clear();
                                widget._contactController.clear();
                                widget._emailController.clear();
                              });
                            },
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.blue),
                            )),
                        TextButton(
                            onPressed: () => widget.onRemove(),
                            child: const Text(
                              "Remove",
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                  ],
                ),
                TextFormField(
                  controller: widget._nameController,
                  // initialValue: widget.contactModel.name,
                  onChanged: (value) => widget.contactModel.name = value,
                  onSaved: (value) => widget.contactModel.name = value,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter Name",
                    labelText: "Name",
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: widget._contactController,
                  onChanged: (value) => widget.contactModel.number = value,
                  onSaved: (value) => widget.contactModel.name = value,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter Number",
                    labelText: "Number",
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: widget._emailController,
                  onChanged: (value) => widget.contactModel.email = value,
                  onSaved: (value) => widget.contactModel.email = value,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter Email",
                    labelText: "Email",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
