import 'package:carrent/Models/Car.dart';

class Rent {
  String id = "";
  String userId = "";
  String carId = "";

  Car? car;
  String clientName = "";
  String clientPhone = "";
  String clientIdentity = "";
  bool finished = false;
  String startingDate = DateTime.now().toString();
  String endingDate = DateTime.now().add(const Duration(days: 1)).toString();
  double totalPrice = 0;
  double paidPrice = 0;
  double remainingPrice = 0;
  String createdAt = "";
  String updatedAt = "";
  Rent();
  Rent.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    userId = json["userId"];
    if (json["carId"] is String) {
      carId = json["carId"];
    } else if (json["carId"] is Map<String, dynamic>) {
      car = Car.fromJson(json["carId"]);
    }
    startingDate = json["startingDate"];
    endingDate = json["endingDate"];
    finished = json["finished"] ?? false;
    clientName = json["clientName"];
    clientPhone = json["clientPhone"];
    clientIdentity = json["clientIdentity"];
    totalPrice = json["totalPrice"] * 1.0;
    paidPrice = json["paidPrice"] * 1.0;
    remainingPrice = json["remainingPrice"] * 1.0;
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }
  Map<String, dynamic> toJson() => {
        "startingDate": startingDate,
        "endingDate": endingDate,
        "clientName": clientName,
        "clientPhone": clientPhone,
        "carId": carId,
        "clientIdentity": clientIdentity,
        "totalPrice": totalPrice,
        "paidPrice": paidPrice,
        "remainingPrice": remainingPrice,
      };
}
