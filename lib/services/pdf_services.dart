import 'dart:io';

import 'package:converter_hub/config/app_config.dart';
import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/data/models/pdf_image_model.dart';
import 'package:converter_hub/services/permission_handler_service.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfServices {
  static final PdfServices _instance = PdfServices._singleton();

  ///Private named constructor
  PdfServices._singleton();

  // factroy constructor
  factory PdfServices() {
    return _instance;
  }

  ///---------------main for pdf generation ------------------

  Future<void> convertToPDf({
    required List<PdfImageModel> imageList,
    PdfPageFormat pageFormat = PdfPageFormat.a4,
    pw.EdgeInsetsGeometry? margin,
    String? pdfName,
  }) async {
    //This line create simple a pdf Documnet but now it is empty
    final pw.Document pdf = pw.Document();
    for (int i = 0; i < imageList.length; i++) {
      /// this convert Xfile to file type object
      File image = File(imageList[i].image.path);

      // convert file to binay/byte image
      final Uint8List binaryImage = await image.readAsBytes();
      final pw.MemoryImage finalImage = pw.MemoryImage(binaryImage);
      pdf.addPage(
        pw.Page(
          pageFormat: pageFormat,
          margin: margin ?? pw.EdgeInsets.all(AppDecoration.radius15),
          build: (context) {
            return pw.Center(child: pw.Image(finalImage));
          },
        ),
      );
    }

    ///---- for saving pdf file in stoarge -------
    await savePdf(pdf: pdf, documentName: pdfName);
  }

  Future<void> savePdf({required pw.Document pdf, String? documentName}) async {
    try {
      if (await PermissionHandlerService.storagePermissionHandler()) {
        final downloadDirectory = Directory(AppConfig.internalStoragePath);

        //if download folder not exist then create it
        if (!await downloadDirectory.exists()) {
          await downloadDirectory.create(recursive: true);
        }
        final pdfName =
            documentName != null
                ? "$documentName.pdf"
                : "${AppConfig.appName}${DateTime.now().millisecondsSinceEpoch}.pdf";
        final pdfPath = "${downloadDirectory.path}/$pdfName";
        final file = File(pdfPath);

        // ye pdf document ko memory me encode karke byte data(Uint8List) return karta hai
        final pdfByteData = await pdf.save();

        // ye byte data  ko actual file banakar storage me likhta hai
        await file.writeAsBytes(pdfByteData);
        UiHelper.showCustomToast(msg: AppString.pdfSaveSuccessfully);
      } else {
        UiHelper.showCustomToast(msg: "Storage Permission Not Allowed");
      }
    } catch (ex) {
      UiHelper.showCustomToast(msg: AppString.somethingWentWrong);
    }
  }

  Future<List<File>> getPdfFilesFromDirectory({
    String folderPath = AppConfig.internalStoragePath,
  }) async {
    final Directory pathDirectory = Directory(folderPath);
    final List<File> pdfFiles = [];
    if (await pathDirectory.exists()) {
      try {
        final entities = await pathDirectory.list().toList();

        for (var entity in entities) {
          if (entity is File && entity.path.toLowerCase().endsWith('.pdf')) {
            pdfFiles.add(entity);
          }
        }
      } catch (e) {
        debugPrint('Error while reading files: $e');
      }
    }
    return pdfFiles;
  }
}
