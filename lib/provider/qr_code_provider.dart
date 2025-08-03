import 'dart:io';
import 'dart:ui' as ui;

import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/core/helper/image_picker_helper.dart';
import 'package:converter_hub/data/models/qr_code_model.dart';
import 'package:converter_hub/data/services/permission_handler_service.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../config/app_config.dart';

class QrCodeProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final qrKey = GlobalKey();
  TextEditingController qrCodeNameController = TextEditingController();
  TextEditingController contentCategoryController = TextEditingController();
  TextEditingController dataController1 = TextEditingController();
  TextEditingController dataController2 = TextEditingController();
  TextEditingController dataController3 = TextEditingController();

  final List<QrCodeModel> qrCodeInputType = [
    QrCodeModel(title: "URL/Link", icon: Icons.link, id: "Link"),
    QrCodeModel(title: "Text", icon: Icons.text_fields, id: "Text"),
    QrCodeModel(title: "Map", icon: Icons.map, id: "Map"),
    QrCodeModel(title: "Wi-Fi", icon: Icons.wifi, id: "Wifi"),
    QrCodeModel(title: "Phone Number", icon: Icons.phone_android, id: "Phone"),
    QrCodeModel(title: "SMS", icon: Icons.sms, id: "Sms"),
    QrCodeModel(title: "Email", icon: Icons.email, id: "Email"),
    // QrCodeModel(title: "Visiting Card", icon: Icons.link_off, id: "Vcard"),
    QrCodeModel(
      title: "Whatsapp",
      icon: FontAwesomeIcons.whatsapp,
      id: "Whatsapp",
    ),
    QrCodeModel(
      title: "Facebook",
      icon: FontAwesomeIcons.facebook,
      id: "Facebook",
    ),
    QrCodeModel(
      title: "YouTube",
      icon: FontAwesomeIcons.youtube,
      id: "YouTube",
    ),
    QrCodeModel(
      title: "Instagram",
      icon: FontAwesomeIcons.instagram,
      id: "Instagram",
    ),
    QrCodeModel(
      title: "Telegram",
      icon: FontAwesomeIcons.telegram,
      id: "Telegram",
    ),
    QrCodeModel(
      title: "SnapChat",
      icon: FontAwesomeIcons.snapchat,
      id: "Snapchat",
    ),
    QrCodeModel(title: "Github", icon: FontAwesomeIcons.github, id: "Github"),
    QrCodeModel(
      title: "LinkedIn",
      icon: FontAwesomeIcons.linkedin,
      id: "LinkedIn",
    ),
  ];

  final List<Map<String, dynamic>> errorCorrectLevelList = [
    {
      "heading": "Best",
      "title": AppString.maximumDamageResistantPattern,
      "image": ImageConstant.longImg,
      "value": QrErrorCorrectLevel.L,
    },
    {
      "heading": "High",
      "title": AppString.optimalDamageResistantPattern,
      "image": ImageConstant.highImg,
      "value": QrErrorCorrectLevel.H,
    },
    {
      "heading": "Medium",
      "title": AppString.balancedClutteredLookingPattern,
      "image": ImageConstant.mediumImg,
      "value": QrErrorCorrectLevel.M,
    },
    {
      "heading": "Smallest",
      "title": AppString.lessClutteredLookingPattern,
      "image": ImageConstant.qImg,
      "value": QrErrorCorrectLevel.Q,
    },
  ];

  final List<String> logoList = [
    ImageConstant.githubIc,
    ImageConstant.linkedinIc,
    ImageConstant.whatsappIc,
    ImageConstant.telegramIc,
    ImageConstant.instagramIc,
    ImageConstant.facebookIc,
    ImageConstant.twitterIc,
    ImageConstant.youtubeIc,
    ImageConstant.snapchatIc,
    ImageConstant.tiktokIc,
  ];

  final ValueNotifier<int> selectedItem = ValueNotifier(0);
  ValueNotifier<bool> isValid = ValueNotifier(false);
  String pickedLogo = '';
  bool isLogoClear = false;
  int _selectedLogoIndex = -1;
  int _selectedErrorLevelIndex = 1;
  bool isLoading = false;
  late QrCodeModel selectedType;
  int get selectedLogoIndex => _selectedLogoIndex;
  int get selectedErrorLevelIndex => _selectedErrorLevelIndex;
  String qrCodeData = '';
  bool isQrCodeGenerated = false;

  void update() {
    notifyListeners();
  }

  void setLogoIndex(int index) {
    _selectedLogoIndex = index;
    if (pickedLogo.isNotEmpty) {
      pickedLogo = "";
    }
    if (isLogoClear) {
      isLogoClear = false;
    }
    notifyListeners();
  }

  void setQrCodeTypesIndes(int index) {
    selectedItem.value = index;
    isQrCodeGenerated = false;
    qrCodeData = '';
    clearController();
    notifyListeners();
  }

  void clearLogo() {
    isLogoClear = true;
    _selectedLogoIndex = -1;
    if (pickedLogo.isNotEmpty) {
      pickedLogo = "";
    }
    notifyListeners();
  }

  void setErrorLevelIndex(int index) {
    _selectedErrorLevelIndex = index;
    notifyListeners();
  }

  void validateInputData() {
    if (formKey.currentState!.validate()) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }

  Future<void> pickLogo({required ImageSource imageSource}) async {
    final pickedImage = await ImagePickerHelper.pickImage(
      imageSource: imageSource,
    );
    if (pickedImage.isNotEmpty) {
      pickedLogo = pickedImage[0].path;
    }

    notifyListeners();
  }

  Future<void> generateQRCode({required BuildContext context}) async {
    UiHelper.showLoder(context: context);
    bool matched = true;
    await Future.delayed(Duration(seconds: 2));
    switch (selectedType.id) {
      case AppString.link:
      case AppString.snapchat:
      case AppString.telegram:
      case AppString.instagram:
      case AppString.whatsapp:
      case AppString.youtube:
      case AppString.facebook:
      case AppString.github:
      case AppString.linkedin:
      case AppString.text:
        qrCodeData = dataController1.text.trim();
        break;
      case "Phone":
        qrCodeData = "tel:+91${dataController1.text.trim()}";
        break;
      case "Sms":
        qrCodeData =
            "SMSTO:+91${dataController1.text.trim()}:${dataController2.text}";
        break;
      case AppString.email:
        String email = "shivam@example.com";
        String subject = Uri.encodeComponent(dataController2.text.trim());
        String body = Uri.encodeComponent(dataController3.text.trim());
        qrCodeData = "mailto:$email?subject=$subject&body=$body";
        break;
      case AppString.map:
        qrCodeData = dataController1.text.trim();
        break;
      case AppString.wifi:
        String ssidName = dataController1.text.trim();
        String encryption = dataController2.text.trim();
        String password = dataController3.text.trim();
        qrCodeData = "WIFI:S:$ssidName;T:$encryption;P:$password;;";
        break;
      default:
        qrCodeData = "Converter Hub";
        matched = false;
    }

    isQrCodeGenerated = matched;
    
    UiHelper.dismissLoder();
    notifyListeners();
  }

  Future<void> saveQrCode() async {
    try {
      if (!await PermissionHandlerService.checkStoragePermission()) return;
      isLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 1));
      String qrCodeName =
          qrCodeNameController.text.isEmpty
              ? "${AppConfig.appName} ${DateTime.now().millisecondsSinceEpoch}"
              : qrCodeNameController.text;
      RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final file = File("${AppConfig.internalStoragePath}/$qrCodeName.png");
      await file.writeAsBytes(pngBytes);

      isLoading = false;
      notifyListeners();
      UiHelper.showCustomToast(msg: "QR Code Save Successfully");
    } on PathAccessException catch (ex) {
      UiHelper.showCustomToast(msg: ex.osError!.message);
    } catch (ex) {
      debugPrint("Exception occurred while saving Qr code $ex");
    }
  }

  void clearController() {
    qrCodeNameController.clear();
    contentCategoryController.clear();
    dataController1.clear();
    dataController2.clear();
    dataController3.clear();
    notifyListeners();
  }
}
