import 'package:converter_hub/core/app_imports.dart';

class ImageToPdfProvider extends ChangeNotifier {
  bool isExapnded = false;


  
  void onDispose(){
     
  }

  void update(){
    notifyListeners();
  }
}
