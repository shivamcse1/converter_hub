// ignore_for_file: avoid_print

import 'package:converter_hub/core/constant/app_string.dart';
import 'package:converter_hub/core/utils/ui_helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextProvider extends ChangeNotifier {
  final stt.SpeechToText speechToText = stt.SpeechToText();
  String recognizedText = '';
  bool shouldAutoRestart = true;

  void intialize() async {
    try {
      await speechToText.initialize();
    } catch (ex) {
      UiHelper.dbugPrint(
        "${AppString.exceptionOccurred}while initalize the speech to text$ex",
      );
    }
  }

  void onDispose() async {
    shouldAutoRestart = false;
    await speechToText.cancel();
  }

  Future<void> convertSpeechToText() async {
    try {
      speechToText.statusListener = (status) async {
        ///it only execute only user silence
        if (status == "notListening" && shouldAutoRestart) {
             await speechListen();
        }
      };
       await speechListen();
     
    } catch (ex) {
      UiHelper.dbugPrint("Exception occured while getting voice$ex");
    }
  }
  
  Future<void> speechListen() async{
     await speechToText.listen(
        onResult: _onSpeechResult,
        // maximum time for waiting when user silence
        pauseFor: Duration(minutes: 5),

        ///maximum time of hearing
        listenFor: Duration(minutes: 10),
      );
  }
 
  void _onSpeechResult(SpeechRecognitionResult result) {
    UiHelper.dbugPrint(" ${result.recognizedWords}");
    if (result.finalResult) {
      recognizedText += " ${result.recognizedWords}";
      notifyListeners();
    }
  }

  void clearSpeechText (){
     recognizedText = '';
     notifyListeners();
  }
  
}
