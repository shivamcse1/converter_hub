// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';
import 'package:converter_hub/config/app_config.dart';
import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/core/helper/image_picker_helper.dart';
import 'package:converter_hub/services/pdf_services.dart';
import '../data/models/pdf_image_model.dart';

class ImageToPdfProvider extends ChangeNotifier {
  PageController pageController = PageController();
  ScrollController pdfScrollController = ScrollController();
  TextEditingController imageNameController = TextEditingController();
  TextEditingController pdfNameController = TextEditingController();
  PdfServices pdfServices = PdfServices();
  bool isLoading = false;
  List<PdfImageModel> pdfImages = [];
  List<File> _allGeneratedPdf = [];
  double roationAngle = 0.0;
  bool isExapnded = false;
  int _currentIndex = 0;
  String pdfName = "Converter Hub_${DateTime.now().millisecondsSinceEpoch}";
  List<File> get allGeneratedPdf => _allGeneratedPdf;
  int get currentIndex => _currentIndex;

  @override
  void dispose() {
    pageController.dispose();
    pdfScrollController.dispose();
    imageNameController.dispose();
    pdfNameController.dispose();
    super.dispose();
  }

  void init() {
    fetchAllPdf();
  }

  void updatePageIndex({required int index}) {
    roationAngle = 0.0;
    _currentIndex = index;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

  void updatePdfImageInfo({
    double angle = pi / 2,
    String imageName = "Converter Hub",
    required bool isLeft,
    required bool isAngle,
  }) {
    if (isAngle) {
      pdfImages[currentIndex].rotationAngle =
          pdfImages[currentIndex].rotationAngle + (isLeft ? -angle : angle);
    } else {
      pdfImages[currentIndex].imageName = imageName;
    }

    notifyListeners();
  }

  Future<void> scrollToBottom() async {
    await Future.delayed(Duration(milliseconds: 900));
    pdfScrollController.animateTo(
      pdfScrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
    );

    notifyListeners();
  }

  Future<void> saveToPdf() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    await pdfServices.convertToPDf(imageList: pdfImages);
    isLoading = false;
    pdfImages = [];
    notifyListeners();
  }

  Future<void> addImageInPdf({
    bool isBoth = false,
    required BuildContext context,
  }) async {
    List<XFile> pickedImages = [];
    if (isBoth) {
      await ImagePickerHelper.imagePickerDialog(
        context: context,
        onCameraTap: () async {
          Navigator.pop(context);
          pickedImages = await ImagePickerHelper.pickImage(
            imageSource: ImageSource.camera,
          );

          for (var image in pickedImages) {
            pdfImages.add(
              PdfImageModel(
                image: image,
                rotationAngle: 0,
                imageName: image.name,
              ),
            );
          }
          notifyListeners();
        },
        onGalleryTap: () async {
          Navigator.pop(context);
          pickedImages = await ImagePickerHelper.pickImage();
          for (var image in pickedImages) {
            pdfImages.add(
              PdfImageModel(
                image: image,
                rotationAngle: 0,
                imageName: image.name,
              ),
            );
          }
          notifyListeners();
        },
      );
    } else {
      pickedImages = await ImagePickerHelper.pickImage();
      for (var image in pickedImages) {
        pdfImages.add(
          PdfImageModel(image: image, rotationAngle: 0, imageName: image.name),
        );
      }

      notifyListeners();
    }
    scrollToBottom();
  }

  Future<void> fetchAllPdf() async {
    try {
      _allGeneratedPdf = await pdfServices.getPdfFilesFromDirectory(
        folderPath: AppConfig.internalStoragePath,
      );
      if (_allGeneratedPdf.isNotEmpty) {
        debugPrint("Pdf fetch Successfully");
      } else {
        debugPrint("Pdf fetch failed");
      }
    } catch (ex) {
      debugPrint("${AppString.exceptionOccurred} while fetching pdf $ex");
    } finally {
      notifyListeners();
    }
  }
}
