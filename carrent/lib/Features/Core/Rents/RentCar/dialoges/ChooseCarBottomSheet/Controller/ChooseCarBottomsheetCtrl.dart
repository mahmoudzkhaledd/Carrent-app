import 'package:carrent/Features/Core/Car/Service/CarService.dart';
import 'package:carrent/Models/Car.dart';
import 'package:get/get.dart';

class ChooseCarBottomsheetCtrl extends GetxController {
  ChooseCarBottomsheetCtrl() {
    getCars();
  }
  bool loading = true;
  final CarService service = CarService();
  List<Car>? cars;
  Car? selectedCar;
  void getCars() async {
    loading = true;
    update();
    cars = await service.getUserCars('', 0);
    loading = false;
    update();
  }

  selectCar(Car c) {
    selectedCar = c;
    update();
  }

  void chooseCar() {
    if (selectedCar != null) {
      Get.back<Car>(result: selectedCar);
    }
  }
}
