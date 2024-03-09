enum HistoryType {
  none,
  add_car,
  edit_car,
  rent_car,
  finish_rent,
  remove_rent,
  create_team,
  active_rent,
}

class HistoryRecord {
  HistoryType type = HistoryType.none;
  String carId = "";
  String rentId = "";
  String temId = "";
  String createdAt = "";
  String updatedAt = "";
  HistoryRecord.fromJson(Map<String, dynamic> json) {
    type = HistoryType.values.byName(json['type'] ?? "none");
    carId = json['carId'] ?? "";
    rentId = json['rentId'] ?? "";
    temId = json['temId'] ?? "";
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }
}
