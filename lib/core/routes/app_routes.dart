import 'package:converter_hub/presentation/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:converter_hub/presentation/views/home/home_view.dart';
import 'package:converter_hub/presentation/views/home/image_to_text_view.dart';
import 'package:converter_hub/presentation/views/home/speech_to_text_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  

  /// App Routes
  static const String bottomNavBar = "/";
  static const String homeView = "/home_view";
  static const String historyView = "/history_view";
  static const String speechToTextView = "/speech_to_text_view";
  static const String textToSpeechView = "/text_to_speech_view";
  static const String imageToTextView = "/image_to_text_view";

  
  static Map<String,WidgetBuilder> routes = {
    bottomNavBar : (context)=> BottomNavBar(),
    homeView : (context) => HomeView(),
    speechToTextView : (context) => SpeechToTextView(),
    imageToTextView : (context) => ImageToTextView(),
    

  };

}