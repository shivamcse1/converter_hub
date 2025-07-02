// ignore_for_file: unnecessary_null_comparison,
import 'dart:io';
import 'package:converter_hub/core/constant/app_string.dart';
import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/core/helper/ui_helper.dart';
import 'package:converter_hub/presentation/widget/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ImageToTextProvider extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();
  final TextRecognizer textRecognizer = TextRecognizer();

  bool _isLoading = false;
  final List<String> _extractTextList = [];
  List<File> _pickedImageList = [];
  List<File> get pickedImageList => _pickedImageList;
  List<String> get extractTextList => _extractTextList;
  bool get isLoading => _isLoading;

  ///This method is used for pick images from device
  Future<void> pickImage({
    required BuildContext context,
    required ImageSource source,
    int imageQuantity = 10,
  }) async {
    List<XFile?> pickedImages = [];

    CustomLoader.showLoader(
      context: context,
      indigatorColor: AppColors.whiteColor,
    );
    if (source == ImageSource.gallery) {
      pickedImages = await imagePicker.pickMultiImage(limit: imageQuantity);
    } else {
      pickedImages.add(await imagePicker.pickImage(source: source));
    }

    if (pickedImages != null && pickedImages.isNotEmpty) {
      _pickedImageList =
          pickedImages.map((img) {
            extractText();
            return File(img!.path);
          }).toList();

      for (var img in _pickedImageList) {
        await extractText(image: img);
      }
    } else {
      UiHelper.customToast(msg: "Image not picked");
    }

    CustomLoader.dismisLoader();
    notifyListeners();
  }

  Future<void> removePickImages({
    required int index,
    required BuildContext context,
  }) async {
    CustomLoader.showLoader(
      context: context,
      indigatorColor: AppColors.whiteColor,
    );
    await Future.delayed(Duration(milliseconds: 600), () {
      _pickedImageList.removeAt(index);
      _extractTextList.removeAt(index);
      _isLoading = false;
      notifyListeners();
    });
    CustomLoader.dismisLoader();
  }

  ///This method is used to extract text from image
  Future<void> extractText({File? image}) async {
    if (image == null) return;
    try {
      final InputImage inputImage = InputImage.fromFile(image);
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      if (recognizedText.text.isNotEmpty) {
        _extractTextList.add(recognizedText.text);
        UiHelper.dbugPrint("Recognized Text is not empty");
      } else {
        _extractTextList.add("No Text Found");
      }
    } catch (ex) {
      UiHelper.dbugPrint(
        "${AppString.exceptionOccurred} while extracting text from image : $ex",
      );
    } finally {
      textRecognizer.close();
      notifyListeners();
    }
  }
}
