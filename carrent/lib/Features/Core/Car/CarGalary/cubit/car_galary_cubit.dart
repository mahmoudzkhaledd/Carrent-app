import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:carrent/Features/Core/Car/Service/CarService.dart';
import 'package:carrent/Models/Car.dart';
import 'package:carrent/Models/Image.dart';
import 'package:carrent/services/GeneralServices/HandelNetworkRequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../Helper/Helper.dart';

part 'car_galary_state.dart';

class CarGalaryCubit extends Cubit<CarGalaryState> {
  CarGalaryCubit(this.car) : super(CarGalaryInitial());
  final List<String> chosenImages = [];
  final Car car;
  final CarService service = CarService();
  int get getFillNumber => chosenImages.length + car.images.length;
  void removeFileImage(String e) async {
    if (!await Helper.showYesNoMessage(
      "Delete Image",
      "Are you sure to delete this image?",
      icon: Icons.delete,
    )) return;
    chosenImages.remove(e);
    emit(CarGalaryChagneImage());
  }

  void removeNetworkImage(int idx) async {
    if (!await Helper.showYesNoMessage(
      "Delete Image",
      "Are you sure to delete this image?",
      icon: Icons.delete,
    )) return;
    final res = await Helper.showLoading(
      "Please Wait",
      "Deleting the image",
      () => service.deleteImage(car.id, car.images[idx].id),
    );
    if (res.success) {
      car.images.removeAt(idx);
      emit(CarGalaryChagneImage());
    }
  }

  void choseImage() async {
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
      chosenImages.add(image.path);
      emit(CarGalaryChagneImage());
    }
  }

  void viewImage(String? imageUrl, File? imageFile) async {
    await Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: imageUrl != null
              ? Helper.loadNetworkImage(imageUrl, 'car.png')
              : imageFile != null
                  ? Image.file(imageFile)
                  : const SizedBox(),
        ),
      ),
    );
  }

  void uploadImages() async {
    int c = 1;
    for (int i = 0; i < chosenImages.length; i++) {
      String strImg = base64Encode(File(chosenImages[i]).readAsBytesSync());
      final res = await Helper.showLoading(
        "Please Wait",
        "Uploading the image #$c.",
        () => service.uploadCarImage(strImg, car.id),
      );
      if (res.success) {
        chosenImages.removeAt(i);
        i--;
        car.images.add(ImageModel.fromJson(res.data['image']));
        c++;
      } else {
        await HandelNetworkRequest.handelRequest(res);
        return;
      }
    }
    emit(CarGalaryChagneImage());
  }
}
