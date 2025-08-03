import 'package:converter_hub/presentation/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:converter_hub/presentation/views/home/home_view.dart';
import 'package:converter_hub/presentation/views/home/image_to_pdf/image_picker_loder_view.dart';
import 'package:converter_hub/presentation/views/home/image_to_pdf/image_to_pdf_view.dart';
import 'package:converter_hub/presentation/views/home/image_to_pdf/selected_image_view.dart';
import 'package:converter_hub/presentation/views/home/image_to_text/image_to_text_view.dart';
import 'package:converter_hub/presentation/views/home/speech_to_text/speech_to_text_view.dart';
import 'package:converter_hub/presentation/views/home/text_to_speech/text_to_speech_view.dart';
import 'package:flutter/material.dart';

import '../../presentation/views/home/image_to_pdf/pdf_save_view.dart';
import '../../presentation/views/home/create_qr_code/create_qr_code_view.dart';
import '../../presentation/views/home/text_summarize/text_summarize_view.dart';

class AppRoutes {
  /// App Routes
  static const String bottomNavBar = "/";
  static const String homeView = "/home_view";
  static const String historyView = "/history_view";
  static const String speechToTextView = "/speech_to_text_view";
  static const String textToSpeechView = "/text_to_speech_view";
  static const String imageToTextView = "/image_to_text_view";
  static const String imageToPdfView = "/image_to_pdf_view";
  static const String pdfSaveView = "/pdf_save_view";
  static const String selectedImageView = "/selected_image_view";
  static const String imagePickerLoaderView = "/image_picker_loader_view";
  static const String textSummarizeView = "/text_summarize_view";
  static const String createQrCodeView = "/create_qr_code_view";

  static Map<String, WidgetBuilder> routes = {
    bottomNavBar: (context) => BottomNavBar(),
    homeView: (context) => HomeView(),
    speechToTextView: (context) => SpeechToTextView(),
    imageToTextView: (context) => ImageToTextView(),
    textToSpeechView: (context) => TextToSpeechView(),
    imageToPdfView: (context) => ImageToPdfView(),
    pdfSaveView: (context) => PdfSaveView(),
    selectedImageView: (context) => SelectedImageView(),
    imagePickerLoaderView: (context) => ImagePickerLoaderView(),
    textSummarizeView: (context) => TextSummarizeView(),
    createQrCodeView: (context) => CreateQrCodeView(),
  };
}
