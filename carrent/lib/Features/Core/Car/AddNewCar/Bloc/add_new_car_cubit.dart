import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:carrent/Features/Core/Car/CarPage/view/CarPage.dart';
import 'package:carrent/Features/Core/Car/CarPage/view/CarPage.dart';
import 'package:carrent/Features/Core/Car/Service/CarService.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/Car.dart';
import 'package:carrent/services/GeneralServices/HandelNetworkRequest.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../CarGalary/View/CarGalary.dart';

part 'add_new_car_state.dart';

class AddNewCarCubit extends Cubit<AddNewCarState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final Car car;
  bool editMode = false;
  File? chosenImage;
  final CarService service = CarService();
  int page = 0;
  int currentPageIndex = 0;

  AddNewCarCubit(Car? car) : super(AddNewCarInitial()) {
    editMode = car != null;
    if (car != null) {
      getData(car.id);
    } else {
      this.car = Car();
    }
  }
  void getData(id) async {
    emit(AddNewCarLoadingState());
    final car = await service.getUserCar(id);
    if (car == null) {
      emit(AddNewCarFailedState());
      return;
    }
    this.car = car;
    emit(AddNewCarSuccessState());
  }

  void chooseImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    final image = await ImagePicker.platform.getImageFromSource(
      source: ImageSource.gallery,
    );

    if (image != null) {
      if (await image.length() > 1048576) {
        await Helper.showMessage(
          "Size error",
          "The maximum image size is 1 MB.",
        );
        return;
      }
      chosenImage = File(image.path);
      emit(AddNewImageAddNewCar());
    }
  }

  removeImage() {
    chosenImage = null;
    emit(AddNewImageAddNewCar());
  }

  void updateAddCar() async {
    if (!formKey.currentState!.validate()) return;
    if (chosenImage != null) {
      car.thumbnailImage = base64Encode(chosenImage!.readAsBytesSync());
    }
    final res = await Helper.showLoading(
      editMode ? "Editing your car" : "Adding your car",
      "Please wait",
      () => editMode ? service.updateCar(car) : service.addNewCar(car.toJson()),
    );
    car.thumbnailImage = "";
    final ans = await HandelNetworkRequest.handelRequest(res);
    if (!ans) return;
    await Helper.showMessage(
      "Success",
      editMode ? "The car edited succefully" : 'The car added succefully',
      icon: FluentIcons.checkmark_20_regular,
    );
    if (res.data != null &&
        res.data['car'] != null &&
        res.data['car']["_id"] != null) {
      Get.off(() => CarPage(id: res.data['car']["_id"]));
    }
  }

  void removeNetworkImage() async {
    final ans = await Helper.showYesNoMessage(
      "Warning",
      "Are you sure to delete this image?",
    );
    if (!ans && car.thumbnailImageModel != null) return;
    final res = await Helper.showLoading(
      'Deleting Image',
      "Please wait",
      () => service.deleteImage(car.id, car.thumbnailImageModel!.id),
    );
    bool result = await HandelNetworkRequest.handelRequest(res);
    if (!result) {
      return;
    }
    car.thumbnailImageModel = null;
    emit(AddNewImageAddNewCar());
  }

  void goToGalary() {
    Get.to(() => CarGalary(
          car: car,
        ));
  }

  void deleteCar(String id) async {
    emit(AddNewCarLoadingState());
    final res = await service.deleteCar(id);
    if (res.success == false) {
      Helper.showMessage("Error", res.msg!);
      emit(AddNewCarFailedState());
      return;
    }
    await Helper.showMessage("Success", "The car deleted successfully");
    Get.back(result: true);
    emit(AddNewCarSuccessState());
  }
}
