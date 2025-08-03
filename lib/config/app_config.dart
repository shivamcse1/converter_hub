class AppConfig {
  static const String appName = "Converter Hub";

   // App generated pdf path   
  static const String internalStoragePath ="/storage/emulated/0/Download/$appName";

  // FontFamily used in App
  static const String nunitoFontFamily = "Nunito";


  /// App Info
  static const String appVersion = '1.0.0';

  /// App Environment
  static const bool isDebug = true;
  static const bool isProduction = false;

  /// Timeout Config
  static const Duration apiTimeout = Duration(seconds: 15);

  /// Local Paths or Buckets
  static const String profileImageFolder = 'profile_image';
}
