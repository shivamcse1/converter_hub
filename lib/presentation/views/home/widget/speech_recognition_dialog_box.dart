import 'package:converter_hub/core/constant/image_constant.dart';
import 'package:converter_hub/core/decoration/app_decoration.dart';
import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/core/theme/app_styles.dart';
import 'package:converter_hub/presentation/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../provider/speech_to_text_provider.dart';

class SpeechRecognitionDialogBox extends StatefulWidget {
  const SpeechRecognitionDialogBox({super.key});

  @override
  State<SpeechRecognitionDialogBox> createState() =>
      _SpeechRecognitionDialogBoxState();
}

class _SpeechRecognitionDialogBoxState
    extends State<SpeechRecognitionDialogBox> {
  late SpeechToTextProvider speechToTextProvider;
  @override
  void initState() {
    super.initState();
    speechToTextProvider = Provider.of<SpeechToTextProvider>(
      context,
      listen: false,
    );
    speechToTextProvider.convertSpeechToText();
  }

  @override
  void dispose() {
    super.dispose();
    speechToTextProvider.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDecoration.radius10),
          color: AppColors.whiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(ImageConstant.voiceListner, height: 120.h),
            Lottie.asset(ImageConstant.waveLoder),

            CustomText(
              text: "Try Say Somthing!",
              style: AppTextStyles.nunito16W700H1_4,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
