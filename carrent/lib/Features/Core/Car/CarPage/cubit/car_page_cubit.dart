import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../Models/Car.dart';
import '../../Service/CarService.dart';

part 'car_page_state.dart';

class CarPageCubit extends Cubit<CarPageState> {
  CarPageCubit(this.id) : super(CarPageInitial()) {
    getData();
  }
  final String id;
  Car car = Car();
  final services = CarService();
  bool loading = true;
  String search = "";
  int currentPageIndex = 0;

  void getData() async {
    loading = true;
    emit(CarPageLoadingState());
    final res = await services.getUserCar(id);
    loading = false;
    if (res != null) {
      car = res;
      emit(CarPageSuccesState());
    } else {
      emit(CarPageFailState());
    }
  }

  void changePage(int value) {
    currentPageIndex = value;
    emit(CarPageChangeImageIndex());
  }
}
