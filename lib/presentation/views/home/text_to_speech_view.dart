import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/core/constant/language_constant.dart';
import 'package:converter_hub/core/utils/app_utils.dart';
import 'package:converter_hub/presentation/widget/custom_button.dart';
import 'package:converter_hub/presentation/widget/custom_floating_sheet.dart';
import 'package:converter_hub/provider/text_to_speech_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constant/app_key.dart';

class TextToSpeechView extends StatefulWidget {
  const TextToSpeechView({super.key});

  @override
  State<TextToSpeechView> createState() => _TextToSpeechViewState();
}

class _TextToSpeechViewState extends State<TextToSpeechView> {
  late TextToSpeechProvider textToSpeechProvider;

  @override
  void initState() {
    super.initState();
    textToSpeechProvider = Provider.of<TextToSpeechProvider>(
      context,
      listen: false,
    );
    textToSpeechProvider.speakListner();
  }

  @override
  void dispose() {
    textToSpeechProvider.textController.text = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UiHelper.dbugPrint("ramam");
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        isBackBtnVisible: true,
        title: AppString.textToSpeech,
        titleStyle: AppTextStyles.nunito18W700H1_4.copyWith(
          color: AppColors.whiteColor,
        ),
        isTitleCentered: true,
        appBarColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<TextToSpeechProvider>(
          builder: (context, textToSpeechProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: textToSpeechProvider.textController,
                  minLines: 8,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Type Something here....',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                CustomText(
                  text: "Choose Language",
                  style: AppTextStyles.nunito15W700H1_4,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.whiteColor,
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10.r),
                      menuMaxHeight: 300.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      value: textToSpeechProvider.selectedLanguage,
                      items:
                          LanguageConstant.languageList.map((singleItem) {
                            return DropdownMenuItem(
                              value: singleItem[AppKey.code],
                              child: CustomText(
                                text:
                                    "${AppUtils.getFlagEmoji(singleItem[AppKey.flag]!)}  ${singleItem[AppKey.name]}",
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        textToSpeechProvider.language = value ?? "";
                        textToSpeechProvider.selectedLanguage = value ?? "";
                        textToSpeechProvider.update();
                      },
                    ),
                  ),
                ),

                SizedBox(height: 10.h),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: CustomFloatingSheet(
          backgroundColor: AppColors.whiteColor,
          onCopy: () {
            UiHelper.copyData(data: textToSpeechProvider.textController.text);
          },
          onShare: () {
            final videoLink =
                "https://www.youtube.com/watch?v=3wOlcOMrYZ8&list=RD3wOlcOMrYZ8&start_radio=1";
            Share.share('Check out this link: $videoLink');
          },
          onDelete: () {
            textToSpeechProvider.textController.clear();
            textToSpeechProvider.update();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: CustomElevatedButton(
              radius: 0,
              buttonColor: AppColors.primaryColor,
              buttonTextStyle: AppTextStyles.nunito14W700H1_4.copyWith(
                color: AppColors.whiteColor,
              ),
              preWidget: Icon(
                textToSpeechProvider.isSpeaking
                    ? Icons.pause
                    : Icons.play_arrow,
                color: AppColors.whiteColor,
              ),
              buttonText: textToSpeechProvider.isSpeaking ? "Stop" : "Speak",

              onTap:
                  textToSpeechProvider.isSpeaking
                      ? null
                      : () {
                        textToSpeechProvider.startSpeak(
                          lang: textToSpeechProvider.language,
                        );
                      },
            ),
          ),

          Expanded(
            child: CustomElevatedButton(
              radius: 0,
              buttonColor: AppColors.greyColor,
              preWidget: Icon(Icons.stop, color: AppColors.whiteColor),
              buttonTextStyle: AppTextStyles.nunito14W700H1_4.copyWith(
                color: AppColors.whiteColor,
              ),
              buttonText: "Stop",
              onTap: () {
                textToSpeechProvider.stopSpeaking();
              },
            ),
          ),
        ],
      ),
    );
  }
}
