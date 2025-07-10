import 'package:converter_hub/core/app_imports.dart';

class PickedImageModel {
  String imageName;
  double rotationAngle;
  XFile image;

  PickedImageModel({
    required this.image,
    required this.rotationAngle,
    required this.imageName,
  });

  factory PickedImageModel.fromJson(Map<String, dynamic> json) {
    return PickedImageModel(
      image: json["image"],
      rotationAngle: json["rotationAngle"],
      imageName: json["imageName"],
    );
  }

  Map<String,dynamic> toMap(){
   return {
    "image" : image,
     "rotationAngle" : rotationAngle,
     "imageName" : imageName
   };
  }
}
