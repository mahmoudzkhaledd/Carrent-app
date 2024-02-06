import 'package:bloc/bloc.dart';
import 'package:carrent/Features/Core/Rents/RentDetailsPage/view/RentDetailsPage.dart';
import 'package:carrent/services/GeneralServices/RentServices.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/Rent.dart';
import 'package:carrent/services/GeneralServices/HandelNetworkRequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../../../Models/Car.dart';
import '../dialoges/ChooseCarBottomSheet/Controller/ChooseCarBottomsheetCtrl.dart';
import '../dialoges/ChooseCarBottomSheet/View/ChooseCarBottomSheet.dart';

part 'add_rent_car_state.dart';

class AddRentCarCubit extends Cubit<AddRentCarState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final service = RentServices();
  late final Rent rent;
  late final bool editMode;
  AddRentCarCubit(Rent? rent) : super(AddRentCarInitial()) {
    this.rent = rent ?? Rent();
    editMode = (rent != null);
    if (rent != null) {
      rentedCar = rent.car;
    }
  }
  Car? rentedCar;
  void chooseCar() async {
    Get.put(ChooseCarBottomsheetCtrl());
    rentedCar =
        await Helper.showBottomSheetWidget<Car>(const ChooseCarBottomSheet());
    Get.delete<ChooseCarBottomsheetCtrl>();
    if (rentedCar != null) {
      emit(AddRentCarChangeRentedCar());
    }
  }

  void rentCar() async {
    if (rentedCar == null) {
      await Helper.showMessage(
        'Rented Car',
        "Please Choose Car to rent",
        icon: Icons.error,
      );
      return;
    }
    if (!formKey.currentState!.validate()) return;
    rent.carId = rentedCar!.id;

    final res = await Helper.showLoading(
      "Please wait",
      'Uploading rent data.',
      () => service.rentCar(rent, editMode),
    );
    bool ans = await HandelNetworkRequest.handelRequest(res);

    if (ans) {
      await Helper.showMessage(
        "Successful operation",
        "The rental has been scheduled successfully.",
        icon: Icons.check,
      );
      if (res.data?['rent']?["_id"] != null) {
        Get.off(() => RentDetailsPage(rentId: res.data?['rent']?["_id"]));
      }
    }
  }

  void removeSelectedCar() {
    if (rentedCar == null) return;
    rentedCar = null;
    emit(AddRentCarChangeRentedCar());
  }

  changeRentDate(DateTime date, bool start) {
    if (start) {
      rent.startingDate = date.toString().split(' ')[0];
      if (DateTime.parse(rent.startingDate)
              .compareTo(DateTime.parse(rent.endingDate)) >
          0) {
        rent.endingDate = DateTime.parse(rent.startingDate)
            .add(const Duration(days: 1))
            .toString()
            .split(' ')[0];
      }
    } else {
      rent.endingDate = date.toString().split(' ')[0];
    }
    emit(AddRentCarChangeRentDate());
  }

  changePrice(String e, bool total) {
    if (total) {
      rent.totalPrice = double.tryParse(e) ?? 0;
    } else {
      rent.paidPrice = double.tryParse(e) ?? 0;
    }
    rent.remainingPrice = rent.totalPrice - rent.paidPrice;
    emit(AddRentCarChangeRemainingPrice());
  }
}
