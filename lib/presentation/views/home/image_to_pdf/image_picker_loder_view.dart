import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/data/models/pdf_image_model.dart';
import '../../../../core/helper/image_picker_helper.dart';
import '../../../../provider/image_to_pdf_provider.dart';
import 'selected_image_view.dart';

class ImagePickerLoaderView extends StatefulWidget {
  final ImageSource? source;
  const ImagePickerLoaderView({super.key, this.source});

  @override
  State<ImagePickerLoaderView> createState() => _ImagePickerLoaderViewState();
}

class _ImagePickerLoaderViewState extends State<ImagePickerLoaderView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final pickedImages = await ImagePickerHelper.pickImage(
        imageSource: widget.source,
      );
        
        ///meaning of mounted "Kya ye widget abhi screen pe hai ya destroy ho chuka hai?"
      if (!mounted) return;

      if (pickedImages.isNotEmpty) {
        final imageToPdfProvider = context.read<ImageToPdfProvider>();
        imageToPdfProvider.pdfImages =
            pickedImages.map((singleItem) {
              return PdfImageModel(
                image: singleItem,
                imageName: singleItem.name,
                rotationAngle: 0,
              );
            }).toList();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ChangeNotifierProvider.value(
                  value: imageToPdfProvider,
                  child: SelectedImageView(),
                ),
          ),
        );
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(
        child: CircularProgressIndicator(color: AppColors.whiteColor),
      ),
    );
  }
}
