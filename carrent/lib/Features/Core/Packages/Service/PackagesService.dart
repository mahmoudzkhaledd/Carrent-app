import 'package:carrent/Models/Car.dart';
import 'package:carrent/Models/Package.dart';

import 'package:carrent/Models/ResponseResult.dart';
import 'package:carrent/services/GeneralServices/NetworkService.dart';

class PackagesService {
  final dio = NetworkService.instance;
  Future<ResponseResult> subscribe(String id) async {
    final res = await NetworkService.handelRequest(
      future: dio.post('/packages/$id/subscribe' , data: {}),
    );
    if (res == null) {
      return ResponseResult(
        data: null,
        icon: null,
        internet: false,
        msg: null,
        success: false,
      );
    }
    if(res.statusCode == 200){
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        success: true,
      );
    }
    return ResponseResult(
      data: res.data,
      icon: null,
      msg: res.data['msg']?? "Unknown error occured, please try again later",
      success: false,
    );
  }

  // Future<ResponseResult> updateCar(Car car) async {
  //   final res = await NetworkService.handelRequest(
  //     future: dio.put(
  //       'cars/${car.id}',
  //       data: car.toJson(),
  //     ),
  //   );
  //   if (res == null) {
  //     return ResponseResult(
  //       data: null,
  //       icon: null,
  //       internet: false,
  //       msg: null,
  //       success: false,
  //     );
  //   }
  //   switch (res.statusCode) {
  //     case 400:
  //       return ResponseResult(
  //         data: res.data,
  //         icon: null,
  //         msg: "There exist a car with the same plate number.",
  //         success: false,
  //       );
  //     case 401:
  //       return ResponseResult(
  //         data: res.data,
  //         icon: null,
  //         msg:
  //             "Problem with deleting the image in the server, please call the technical support.",
  //         success: false,
  //       );
  //     case 404:
  //       return ResponseResult(
  //         data: res.data,
  //         icon: null,
  //         msg: "We can't find the car you search for.",
  //         success: false,
  //       );
  //     case 200:
  //       return ResponseResult(
  //         data: res.data,
  //         icon: null,
  //         msg: null,
  //         success: true,
  //       );
  //   }
  //   return ResponseResult(
  //     data: res.data,
  //     icon: null,
  //     msg: "Unknown error occured, please try again later",
  //     success: false,
  //   );
  // }

  Future<List<Package>?> getPackages() async {
    final res = await NetworkService.handelRequest(
        future: dio.get('packages'));
    if (res == null) {
      return null;
    }
    switch (res.statusCode) {
      case 200:
        return (res.data['packages'] as List<dynamic>)
            .map((e) => Package.fromJson(e))
            .toList();
    }
    return null;
  }
}
