import 'package:bloc/bloc.dart';
import 'package:carrent/Features/Core/Car/Service/CarService.dart';
import 'package:carrent/Models/Car.dart';
import 'package:meta/meta.dart';

part 'my_cars_state.dart';

class MyCarsCubit extends Cubit<MyCarsState> {
  int page = 0;
  final List<Car> cars = [];
  final services = CarService();
  MyCarsCubit() : super(MyCarsInitial()) {
    getData();
  }

  String search = "";

  void getData() async {
    cars.clear();

    emit(MyCarsLoadingState());
    final res = await services.getUserCars(search, page);

    if (res != null) {
      cars.addAll(res);
      emit(MyCarsSuccesState());
    } else {
      emit(MyCarsFailState());
    }
  }
}
