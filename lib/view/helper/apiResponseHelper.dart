import 'package:flutter/material.dart';
import 'package:global_student/networking/response.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/view/helper/apierrorDialog.dart';
import 'package:global_student/view/helper/errorHelper.dart';


class ApiResponseHelper {
  bool handleResponse({
    required dynamic event,
    required BuildContext context,
  }) {
    if (event.status == Status.COMPLETED) {
      if (event.data['status'] == 'FAILURE') {
        //IF Anything going wrong
        showDialog<void>(
            context: context,
            barrierColor: AppColors.PrimaryMainColor,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return ApiErrorDialog(
                  image: "",
                  description: event.data['statusMessage'],
                  onPressed: () {
                    Navigator.pop(context);
                    return false;
                  });
            });
      } else {
        return true;
      }
    } else {
      ErrorDialogHelper().callErrorDialog(
          context: context,
          title: 'Something Went Wrong!',
          description: event.message,
          onPressed: () {
            Navigator.pop(context);
            return false;
            // callGetAplicationDetails();
          });
    }
    return false;
  }
}
