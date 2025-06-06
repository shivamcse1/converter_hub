import 'package:converter_hub/core/routes/app_routes.dart';
import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/state_management/provider/image_to_text_provider.dart';
import 'package:converter_hub/state_management/provider/speech_to_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      builder: (_, child) {
        return MultiProvider(
          providers: [
              ChangeNotifierProvider(create: (context)=> SpeechToTextProvider()),
              ChangeNotifierProvider(create: (context)=> ImageToTextProvider()),
          ],
          builder: (context,child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: AppRoutes.bottomNavBar,
              routes: AppRoutes.routes,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              ),
            );
          }
        );
      },
    );
  }
}
