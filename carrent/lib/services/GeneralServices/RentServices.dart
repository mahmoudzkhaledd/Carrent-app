import 'package:carrent/Models/Rent.dart';
import 'package:flutter/material.dart';

import '../../Models/ResponseResult.dart';
import 'NetworkService.dart';

class RentServices {
  final dio = NetworkService.instance;
  Future<List<Rent>?> getUserRents(String search, int page,
      [String sort = "", int selectNumber = 0]) async {
    final res = await NetworkService.handelRequest(
      future: dio.get(
        'rents?search=$search&page=$page&sort=$sort&selectNumber=$selectNumber',
      ),
    );
    if (res == null) {
      return null;
    }
    switch (res.statusCode) {
      case 200:
        return (res.data['rents'] as List<dynamic>)
            .map((e) => Rent.fromJson(e))
            .toList();
    }
    return null;
  }

  Future<ResponseResult> rentCar(Rent rent, bool edit) async {
    final res = await NetworkService.handelRequest(
      future: edit
          ? dio.put(
              'rents/${rent.id}',
              data: rent.toJson(),
            )
          : dio.post(
              'rents/cars/${rent.carId}/rent',
              data: rent.toJson(),
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
    print(res.data);
    print(res.statusCode);
    final ans = ResponseResult(
      data: res.data,
      icon: null,
      msg: null,
      success: false,
    );
    switch (res.statusCode) {
      case 404:
        ans.msg = "Rented car can't be found, please try again later.";
      case 405:
        ans.msg = res.data['msg'];
        ans.icon = Icons.error;
      case 200:
        ans.success = true;
      default:
        ans.msg = "Unknown error occured, please try again";
    }
    return ans;
  }

  Future<Rent?> getRent(String rentId) async {
    final res = await NetworkService.handelRequest(
      future: dio.get('rents/$rentId'),
    );

    if (res == null || res.statusCode != 200 || res.data['rent'] == null) {
      return null;
    }
    return Rent.fromJson(res.data['rent']);
  }

  Future<String?> deleteRent(String rentId) async {
    final res = await NetworkService.handelRequest(
      future: dio.delete('rents/$rentId'),
    );

    if (res == null || res.statusCode != 200) {
      return res != null && res.data['msg'] != null
          ? res.data['msg'].toString()
          : "Error has occured, please try again!";
    }
    return null;
  }
}
