import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/provider/image_to_pdf_provider.dart';
import 'package:converter_hub/provider/text_to_speech_provider.dart';
import 'provider/speech_to_text_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, 
  ]);
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
              ChangeNotifierProvider(create: (context)=> TextToSpeechProvider()),
              ChangeNotifierProvider(create: (context)=> ImageToPdfProvider()),
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
