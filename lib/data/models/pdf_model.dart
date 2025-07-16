class PdfModel {
  String pdfName;
  String? image;
  String size;
  String createDate;
  String? time;

  PdfModel({required this.createDate, this.image, required this.pdfName, required this.size,this.time});

  factory PdfModel.fromJson(Map<String, dynamic> json) {
    return PdfModel(
      pdfName: json["pdfName"],
      createDate: json["createDate"],
      image: json["image"],
      size: json["size"],
      time : json["size"]
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "image" :image,
      "createDate" : createDate,
      "pdfName" : pdfName,
      "size" : size,
      "time" : time
    };
  }
}
