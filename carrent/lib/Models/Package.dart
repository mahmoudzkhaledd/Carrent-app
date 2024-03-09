class Package {
  String id = "";
  String name = "";
  String description = "";
  double price = 0;
  int freePeriod = 0;
  List<PackageAdvantge> advantages = [];

  Package.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'] * 1.0;
    freePeriod = json['freePeriod'];
    advantages = (json['advantages'] as List<dynamic>)
        .map((e) => PackageAdvantge.fromJson(e))
        .toList();
  }
}

class PackageAdvantge {
  bool active = true;
  String description = "";

  PackageAdvantge.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    description = json['description'];
  }
}
