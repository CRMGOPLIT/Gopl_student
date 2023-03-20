import 'package:flutter/material.dart';

import 'package:global_student/utils/color.dart';
import 'package:global_student/view/helper/errorDialog.dart';

class ErrorDialogHelper {
  void callErrorDialog(
      {required BuildContext context,
      required String title,
      required String description,
      required Function onPressed}) {
    showDialog<void>(
        context: context,
        barrierColor: AppColors.PrimaryMainColor,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ErrorDialog(
              image: "",
              title: title,
              onPressed: () {
                onPressed();
              });
        });
  }
}
