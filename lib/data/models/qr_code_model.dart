import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QrCodeModel {
final String title;
final String id;
final IconData icon;

QrCodeModel(
  { 
  required this.title, 
  required this.id, 
  required this.icon, 
  }
  );

  factory QrCodeModel.fromJson(Map<String,dynamic> json){
    return QrCodeModel(
      title: json["title"] ?? "", 
      id: json["id"] ?? "",
      icon : json["icon"],
      );
  }
 
 Map<String,dynamic> toJson (){
  return {
   "id" : id,
   "icon" : icon,
   "title" : title
  };
 }

}