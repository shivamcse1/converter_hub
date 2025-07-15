import 'package:converter_hub/core/app_imports.dart';

class PdfImageModel {
  static int _counter = 0;
  String id;
  String imageName;
  double rotationAngle;
  XFile image;

  PdfImageModel({
    String? id,
    required this.image,
    required this.rotationAngle,
    required this.imageName,
  }) : id = id ?? (++_counter).toString();

  factory PdfImageModel.fromJson(Map<String, dynamic> json) {
    return PdfImageModel(
      image: json["image"],
      rotationAngle: json["rotationAngle"],
      imageName: json["imageName"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "image": image,
      "rotationAngle": rotationAngle,
      "imageName": imageName,
    };
  }
}
