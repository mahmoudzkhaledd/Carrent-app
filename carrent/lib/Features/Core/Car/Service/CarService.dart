import 'package:carrent/Models/Car.dart';

import 'package:carrent/Models/ResponseResult.dart';
import 'package:carrent/services/GeneralServices/NetworkService.dart';

class CarService {
  final dio = NetworkService.instance;
  Future<ResponseResult> addNewCar(Map<String, dynamic> json) async {
    final res = await NetworkService.handelRequest(
      future: dio.post('cars', data: json),
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
    switch (res.statusCode) {
      case 400:
        return ResponseResult(
          data: res.data,
          icon: null,
          msg: "There exist a car with the same plate number.",
          success: false,
        );
      case 200:
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
      msg: "Unknown error occured, please try again later",
      success: false,
    );
  }

  Future<ResponseResult> updateCar(Car car) async {
    final res = await NetworkService.handelRequest(
      future: dio.put(
        'cars/${car.id}',
        data: car.toJson(),
      ),
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
    switch (res.statusCode) {
      case 400:
        return ResponseResult(
          data: res.data,
          icon: null,
          msg: "There exist a car with the same plate number.",
          success: false,
        );
      case 401:
        return ResponseResult(
          data: res.data,
          icon: null,
          msg:
              "Problem with deleting the image in the server, please call the technical support.",
          success: false,
        );
      case 404:
        return ResponseResult(
          data: res.data,
          icon: null,
          msg: "We can't find the car you search for.",
          success: false,
        );
      case 200:
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
      msg: "Unknown error occured, please try again later",
      success: false,
    );
  }

  Future<List<Car>?> getUserCars(String search, int page) async {
    final res = await NetworkService.handelRequest(
        future: dio.get('cars?search=$search&page=$page'));
    if (res == null) {
      return null;
    }
    switch (res.statusCode) {
      case 200:
        return (res.data['cars'] as List<dynamic>)
            .map((e) => Car.fromJson(e))
            .toList();
    }
    return null;
  }

  Future<Car?> getUserCar(String id) async {
    print(id);
    final res = await NetworkService.handelRequest(future: dio.get('cars/$id'));
    if (res == null || res.statusCode != 200 || res.data['car'] == null) {
      return null;
    }
    return Car.fromJson(res.data['car']);
  }

  Future<ResponseResult> deleteImage(String carId, String imageId) async {
    final res = await NetworkService.handelRequest(
      future: dio.delete('cars/$carId/images/$imageId'),
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
    switch (res.statusCode) {
      case 404:
        return ResponseResult(
          data: res.data,
          icon: null,
          msg: "We can't found the image you want.",
          success: false,
        );
      case 405:
        return ResponseResult(
          data: res.data,
          icon: null,
          msg:
              "Problem with deleting the image in the server, please call the technical support.",
          success: false,
        );
      case 200:
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
      msg: "Unknown error occured, please try again later",
      success: false,
    );
  }

  Future<ResponseResult> uploadCarImage(String image, String carId) async {
    final res = await NetworkService.handelRequest(
      future: dio.post(
        'cars/$carId/images/',
        data: {
          "image": image,
        },
      ),
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

    final ans = ResponseResult(
      data: res.data,
      icon: null,
      msg: null,
      success: false,
    );
    switch (res.statusCode) {
      case 401:
        ans.msg =
            "You are not allowed to upload more images due to the limited number of images in your subscription.";
      case 402:
        ans.msg =
            "Can't upload this image to the server, please contact the customer services.";
      case 404:
        ans.msg =
            "Sorry, the car you want can't be found. Please try again or contact the customer services.";
      case 200:
        ans.success = true;
      default:
        ans.msg = "Unknown error occured, please try again";
    }
    return ans;
  }

  Future<ResponseResult> deleteCar(id) async {
    final res = await NetworkService.handelRequest(
      future: dio.delete('cars/$id'),
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
    if (res.statusCode == 200) {
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
}
