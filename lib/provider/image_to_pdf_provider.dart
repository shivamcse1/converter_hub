// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'dart:math';
import 'package:converter_hub/config/app_config.dart';
import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/core/helper/image_picker_helper.dart';
import 'package:converter_hub/data/models/pdf_model.dart';
import 'package:converter_hub/services/pdf_services.dart';
import 'package:converter_hub/services/permission_handler_service.dart';
import 'package:path/path.dart' as p;
import '../data/models/pdf_image_model.dart';

class ImageToPdfProvider extends ChangeNotifier {
  PageController pageController = PageController();
  ScrollController pdfScrollController = ScrollController();
  TextEditingController imageNameController = TextEditingController();
  TextEditingController pdfNameController = TextEditingController();
  PdfServices pdfServices = PdfServices();
  bool isLoading = false;
  List<PdfImageModel> pdfImages = [];
  List<PdfModel> _allGeneratedPdf = [];
  double roationAngle = 0.0;
  bool _isExapnded = false;
  int _currentIndex = 0;
  String pdfName = "Converter Hub ${DateTime.now().millisecondsSinceEpoch}";
  List<PdfModel> get allGeneratedPdf => _allGeneratedPdf;
  int get currentIndex => _currentIndex;
  bool get isExapnded => _isExapnded;

  @override
  void dispose() {
    pageController.dispose();
    pdfScrollController.dispose();
    imageNameController.dispose();
    pdfNameController.dispose();
    super.dispose();
  }

  void init() async {
    await fetchAllPdf();
  }

  void setExpandFAB() {
    _isExapnded = !_isExapnded;
    notifyListeners();
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
    await pdfServices.convertToPDf(imageList: pdfImages, pdfName: pdfName);
    isLoading = false;
    pdfImages = [];
    await fetchAllPdf();
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
      isLoading = true;
      notifyListeners();
      if (!await PermissionHandlerService.storagePermissionHandler()) return;
      final allPdf = await pdfServices.getPdfFilesFromDirectory(
        folderPath: AppConfig.internalStoragePath,
      );
      if (allPdf.isNotEmpty) {
        _allGeneratedPdf = await Future.wait(
          allPdf.map((singlePdf) async {
            final date = await fetchPdfDate(pdfFile: singlePdf);
            return PdfModel(
              pdf: singlePdf,
              createDate: date,
              pdfName: p.basename(singlePdf.path),
              size: (singlePdf.lengthSync() / (1024 * 1024)).toStringAsFixed(2),
            );
          }),
        );

        debugPrint("Pdf fetch Successfully");
      } else {
        debugPrint("Pdf fetch failed");
      }
    } catch (ex) {
      debugPrint("${AppString.exceptionOccurred} while fetching pdf $ex");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String> fetchPdfDate({required File pdfFile}) async {
    final pdfDate = await pdfFile.stat();
    return '${pdfDate.changed.day}/${pdfDate.changed.month}/${pdfDate.changed.year}';
  }

  Future<void> deletePdf({required File pdfFile}) async {
    try {
      if (await pdfFile.exists()) {
        await pdfFile.delete();
        UiHelper.showCustomToast(msg: "File deleted successfully");
      } else {
        UiHelper.showCustomToast(msg: "File does not exist!");
      }
    } catch (ex) {
      debugPrint("Exception occurred while deleting pdf file:$ex");
    } finally {
      notifyListeners();
    }
  }
}
