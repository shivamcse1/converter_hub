// ignore_for_file: use_build_context_synchronously
import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/core/helper/share_helper.dart';
import 'package:converter_hub/presentation/views/home/image_to_pdf/image_picker_loder_view.dart';
import 'package:converter_hub/presentation/views/home/image_to_pdf/pdf_view.dart';
import 'package:converter_hub/presentation/widget/custom_expanded_fab.dart';
import 'package:converter_hub/provider/image_to_pdf_provider.dart';
import '../../../../data/models/pdf_model.dart';

class ImageToPdfView extends StatefulWidget {
  const ImageToPdfView({super.key});

  @override
  State<ImageToPdfView> createState() => _ImageToPdfViewState();
}

class _ImageToPdfViewState extends State<ImageToPdfView> {
  late ImageToPdfProvider imageToPdfProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      imageToPdfProvider = context.read<ImageToPdfProvider>();
      imageToPdfProvider.fetchAllPdf();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        isBackBtnVisible: true,
        title: AppString.imageToPdf,
        titleStyle: AppTextStyles.nunito18W700H1_4.copyWith(
          color: AppColors.whiteColor,
        ),
        isTitleCentered: true,
        appBarColor: AppColors.primaryColor,
      ),
      body: Consumer<ImageToPdfProvider>(
        builder: (context, imageToPdfProvider, child) {
          return imageToPdfProvider.isLoading
              ? Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              )
              : imageToPdfProvider.allGeneratedPdf.isNotEmpty
              ? ListView.separated(
                itemCount: imageToPdfProvider.allGeneratedPdf.length,
                separatorBuilder: (context, index) {
                  return Divider(color: AppColors.greyColor);
                },
                itemBuilder: (context, index) {
                  final pdfData = imageToPdfProvider.allGeneratedPdf[index];
                  return _buildPdfItem(
                    pdfData: pdfData,
                    index: index,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  PdfPageView(pdfData: pdfData),
                        ),
                      );
                    },
                  );
                },
              )
              : _emptyImageSection();
        },
      ),

      floatingActionButton: Consumer<ImageToPdfProvider>(
        builder: (ctx, imageToPdfProvider, child) {
          return CustomExpandedFAB(
            fabIcon: imageToPdfProvider.isExapnded ? Icons.clear : Icons.add,
            fabTap: () {
              imageToPdfProvider.setExpandFAB();
            },
            isExpand: imageToPdfProvider.isExapnded,

            expandedFAB: [
              ExpandedFABItem(
                icon: Icons.camera_alt,
                label: AppString.camera,
                onTap: () {
                  imageToPdfProvider.setExpandFAB();
                  Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder:
                          (_) => ChangeNotifierProvider.value(
                            value: imageToPdfProvider,
                            child: ImagePickerLoaderView(),
                          ),
                    ),
                  );
                },
              ),
              ExpandedFABItem(
                icon: Icons.image,
                label: AppString.gallery,
                onTap: () {
                  imageToPdfProvider.setExpandFAB();
                  Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder:
                          (context) => ChangeNotifierProvider.value(
                            value: imageToPdfProvider,
                            child: ImagePickerLoaderView(),
                          ),
                    ),
                  );
                },
              ),
              // ExpandedFABItem(
              //   icon: Icons.folder,
              //   label: AppString.file,
              //   onTap: () {},
              // ),
            ],
          );
        },
      ),
    );
  }

  Widget _emptyImageSection() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: CustomImage(
              image: ImageConstant.cloudUploadIc,
              height: 100.h,
              width: 100.w,
            ),
          ),
          CustomText(
            text: AppString.uploadOrPickImageFromDevice,
            style: AppTextStyles.nunito16W500H1_4,
          ),

          SizedBox(height: 70.h),
        ],
      ),
    );
  }

  Widget _buildPdfItem({
    required PdfModel pdfData,
    required int index,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDecoration.radius10),
          ),
          child: Image.asset(ImageConstant.pdf2Img),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              maxLines: 3,
              text: pdfData.pdfName,
              style: AppTextStyles.nunito14W700H1_4,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: "${pdfData.size} MB",
                  style: AppTextStyles.nunito12W500H1_4.copyWith(
                    color: AppColors.darkGreyColor,
                  ),
                ),
                SizedBox(width: 10.w),
                CustomText(
                  text: pdfData.createDate,
                  style: AppTextStyles.nunito12W500H1_4.copyWith(
                    color: AppColors.darkGreyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          padding: EdgeInsets.only(left: 30.w),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 1,
                onTap: () {
                  ShareHelper.shareFiles(
                    singlefile: pdfData.pdf,
                    sharingText: "Checkout this pdf${pdfData.pdfName}",
                  );
                },
                child: CustomText(text: "Share"),
              ),
              PopupMenuItem(
                value: 2,
                onTap: () async {
                  await imageToPdfProvider.deletePdf(pdfFile: pdfData.pdf);
                  imageToPdfProvider.allGeneratedPdf.removeAt(index);
                },
                child: CustomText(text: "Delete"),
              ),
            ];
          },
        ),
      ),
    );
  }
}
