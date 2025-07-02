import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/services/text_to_speech_services.dart';

import '../core/constant/app_key.dart';
import '../core/constant/language_constant.dart';

class TextToSpeechProvider extends ChangeNotifier {
  TextEditingController textController = TextEditingController();
  TextToSpeechServices textToSpeechServices = TextToSpeechServices();
  String selectedLanguage =  LanguageConstant.languageList[0][AppKey.code]!;
  bool _isSpeaking = false;
  String language = "hi-IN";

  bool get isSpeaking => _isSpeaking;

  void onDispose() {
    textController.dispose();
  }

  void update(){
    notifyListeners();
  }

  void speakListner() async {
    final language = await textToSpeechServices.textToSpeech.getLanguages;
    UiHelper.dbugPrint("language is $language");

    ///it execute when start speaking
    textToSpeechServices.textToSpeech.setStartHandler(() {
      _isSpeaking = true;
      notifyListeners();
    });

    ///it execute when continue speaking like after pause
    textToSpeechServices.textToSpeech.setContinueHandler(() {
      _isSpeaking = true;
      notifyListeners();
    });

    //it execute when speaking complete
    textToSpeechServices.textToSpeech.setCompletionHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });

    textToSpeechServices.textToSpeech.setCancelHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });
  }

  ///This mehtod is is used for start speaking
  Future<void> startSpeak({String lang = "hi-IN"}) async {
    if (textController.text.isEmpty) return;
    try {
      await textToSpeechServices.speak(text: textController.text,language: lang);
    } catch (ex) {
      UiHelper.dbugPrint("${AppString.exceptionOccurred} while speaking $ex");
    } finally {
      notifyListeners();
    }
  }

  /// this mehtod is used for stop speaking
  Future<void> stopSpeaking() async {
    await textToSpeechServices.stopSpeech();
  }

  /// this mehtod is used for stop speaking
  Future<void> pauseSpeaking() async {
    await textToSpeechServices.pauseSpeech();
  }
}
