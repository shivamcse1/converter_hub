import 'package:converter_hub/core/app_imports.dart';

class ImageToPdfProvider extends ChangeNotifier {
  PageController pageController = PageController();
  TextEditingController imageNameController = TextEditingController();
  double roationAngle = 0.0;
  bool isExapnded = false;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void onDispose() {
    pageController.dispose();
  }

  void updatePageIndex({required int index}) {
    roationAngle = 0.0;
    _currentIndex = index;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
