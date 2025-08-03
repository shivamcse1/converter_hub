import 'dart:io';
import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/data/models/pdf_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPageView extends StatefulWidget {
  final PdfModel pdfData;
  const PdfPageView({super.key, required this.pdfData});

  @override
  State<PdfPageView> createState() => _PdfPageViewState();
}

class _PdfPageViewState extends State<PdfPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        isBackBtnVisible: true,
        title: widget.pdfData.pdfName,
        titleStyle: AppTextStyles.nunito18W700H1_4.copyWith(
          color: AppColors.whiteColor,
        ),
        appBarColor: AppColors.primaryColor,
      ),
      body: SfPdfViewer.file(
        File(widget.pdfData.pdf.path),
        enableTextSelection: true,
      ),
    );
  }
}
