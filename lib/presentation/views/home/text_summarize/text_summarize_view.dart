import 'package:converter_hub/core/app_imports.dart';
import '../../../../provider/text_to_speech_provider.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_floating_sheet.dart';

class TextSummarizeView extends StatefulWidget {
  const TextSummarizeView({super.key});

  @override
  State<TextSummarizeView> createState() => _TextSummarizeViewState();
}

class _TextSummarizeViewState extends State<TextSummarizeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        isBackBtnVisible: true,
        title: AppString.summarizeText,
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
            return SingleChildScrollView(
              child: Column(
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

                  CustomElevatedButton(
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    buttonText: "Summarize Text",
                    buttonTextStyle: AppTextStyles.nunito15W700H1_4.copyWith(
                      color: AppColors.whiteColor,
                    ),
                    buttonColor: AppColors.primaryColor,
                    onTap: () {
                      
                    },
                  ),

                  CustomText(
                    text: "Summarized Text",
                    style: AppTextStyles.nunito15W700H1_4,
                  ),
                  SizedBox(height: 10.h),

                  TextField(
                    minLines: 8,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 50.h),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: CustomFloatingSheet(
        backgroundColor: AppColors.whiteColor,
        onCopy: () {},
        onShare: () {},
        onDelete: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
