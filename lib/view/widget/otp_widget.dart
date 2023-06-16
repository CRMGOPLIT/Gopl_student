import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class PinInput extends StatefulWidget {
  PinInput({Key? key, required this.controller}) : super(key: key);

  TextEditingController controller;

  @override
  // ignore: no_logic_in_create_state
  State<PinInput> createState() => _PinInputState(controller);
}

class _PinInputState extends State<PinInput> {
  TextEditingController controller;
  _PinInputState(this.controller);
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      //padding: EdgeInsets.all(30),
      margin: const EdgeInsets.all(10),
      width: 60.w,
      height: 60.h,
      textStyle: OtpText(AppColors.PrimaryBlackColor),
      decoration: BoxDecoration(
        //color: AppColors.PrimaryGreyColor,
        border: Border.all(color: AppColors.PrimaryGreyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              pinAnimationType: PinAnimationType.rotation,
              controller: controller,
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              // validator: (value) {
              //   return value == '2222' ? null : 'Pin is incorrect';
              // },
              // onClipboardFound: (value) {
              //   debugPrint('onClipboardFound: $value');
              //   pinController.setText(value);
              // },
              // hapticFeedbackType: HapticFeedbackType.lightImpact,
              // onCompleted: (pin) {
              //   debugPrint('onCompleted: $pin');
              // },
              // onChanged: (value) {
              //   debugPrint('onChange0 d: $value');
              // },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 9,
                    ),
                    width: 22,
                    height: 1,
                    // color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.PrimaryGreyColor,
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: AppColors.PrimaryGreyColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
