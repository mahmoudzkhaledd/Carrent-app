import 'package:carrent/Models/Image.dart';

class Car {
  String id = "";
  String userId = "";
  String name = "";
  String model = "";
  String panelNumber = "";
  String thumbnailImage = "";
  ImageModel? thumbnailImageModel;
  String notes = "";
  int passengersNumber = 0;

  List<ImageModel> images = [];
  String createdAt = "";
  String updatedAt = "";

  Car();

  Car.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    name = json['name'];
    model = json['model'];
    passengersNumber = json['passengersNumber'] ?? 0;

    panelNumber = json['panelNumber'];
    updatedAt = json['updatedAt'];
    thumbnailImageModel = (json['thumbnailImage'] != null &&
            json['thumbnailImage'] is Map<String, dynamic>)
        ? ImageModel.fromJson(json['thumbnailImage'])
        : null;

    if (json['images'] is List<dynamic>) {
      images = (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e))
          .toList();
    }

    notes = json['notes'] ?? "";
    createdAt = json['createdAt'].toString().split('T')[0];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['model'] = model;
    data['passengersNumber'] = passengersNumber;
    data['panelNumber'] = panelNumber;
    data['thumbnailImage'] = thumbnailImage;
    //data['images'] = images;
    data['notes'] = notes;
    return data;
  }
}
