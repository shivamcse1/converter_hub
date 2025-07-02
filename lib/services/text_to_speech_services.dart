import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechServices {
  static final TextToSpeechServices _instance =
      TextToSpeechServices._singleton();

  /// Named private constructor
  TextToSpeechServices._singleton();

  factory TextToSpeechServices() {
    return _instance;
  }

  /// main function for text to speech conversion ///

  FlutterTts textToSpeech = FlutterTts();

  ///main method used for speech
  Future<void> speak({
    required String text,
    String language = "hi-IN",
    double picth = 1.0,
    double speechRate = .4,
  }) async {
    await textToSpeech.setLanguage(language);
    await textToSpeech.setPitch(picth);
    await textToSpeech.setSpeechRate(speechRate);
    await textToSpeech.speak(text);
  }

  Future<void> setPicth({double pitch = 1.0}) async {
    await textToSpeech.setPitch(pitch);
  }

  Future<void> setSpeechSpeed({double speed = 0.5}) async {
    await textToSpeech.setSpeechRate(speed);
  }

  Future<void> setLanguage({String language = "hi-IN"}) async {
    await textToSpeech.setLanguage(language);
  }

  Future<void> stopSpeech() async {
    await textToSpeech.stop();
  }

  Future<void> pauseSpeech() async {
    await textToSpeech.pause();
  }
}
