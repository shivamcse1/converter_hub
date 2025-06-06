// ignore_for_file: use_build_context_synchronously

import 'package:converter_hub/core/constant/image_constant.dart';
import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/core/theme/app_styles.dart';
import 'package:converter_hub/core/utils/permission_handler/permission_handler.dart';
import 'package:converter_hub/presentation/views/home/widget/speech_recognition_dialog_box.dart';
import 'package:converter_hub/presentation/widget/custom_app_bar.dart';
import 'package:converter_hub/presentation/widget/custom_image.dart';
import 'package:converter_hub/state_management/provider/speech_to_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/app_string.dart';
import '../../widget/custom_text.dart';

class SpeechToTextView extends StatefulWidget {
  const SpeechToTextView({super.key});

  @override
  State<SpeechToTextView> createState() => _SpeechToTextViewState();
}

class _SpeechToTextViewState extends State<SpeechToTextView> {
  @override
  void initState() {
    super.initState();
    context.read<SpeechToTextProvider>().recognizedText = '';
    Provider.of<SpeechToTextProvider>(context, listen: false).intialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackBtnVisible: true,
        title: AppString.speechToText,
        isTitleCentered: true,
      ),

      body: Container(
        width: double.infinity,
        color: AppColors.backgroundColor,
        padding: EdgeInsets.only(bottom: 70.h),
        child: Consumer<SpeechToTextProvider>(
          builder: (context, speechToTextProvider, child) {
            return Column(
              children: [
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(10.r),
                    elevation: 1,
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        child: CustomText(
                          maxLines: 100,
                          text: speechToTextProvider.recognizedText,
                          style: AppTextStyles.nunito18W700H1_4,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: speechToTextProvider.recognizedText,
                                ),
                              );
                            },
                            child: Icon(
                              Icons.copy,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          CustomText(
                            text: AppString.copy,
                            style: AppTextStyles.nunito16W700H1_4.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              speechToTextProvider.clearSpeechText();
                            },
                            child: Icon(
                              Icons.delete,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          CustomText(
                            text: AppString.delete,
                            style: AppTextStyles.nunito16W700H1_4.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Material(
        borderRadius: BorderRadius.circular(50.r),
        elevation: 4,
        child: InkWell(
          onTap: () async {
            final isValid = await PermissionHandler.micPermissionHandler();
            if (isValid) {
              await showDialog(
                context: context,
                builder: (context) {
                  return SpeechRecognitionDialogBox();
                },
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,
            ),
            child: CustomImage(image: ImageConstant.voiceImg),
          ),
        ),
      ),
    );
  }
}
