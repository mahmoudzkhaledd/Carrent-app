import 'package:bloc/bloc.dart';
import 'package:carrent/Models/Rent.dart';
import 'package:carrent/services/GeneralServices/RentServices.dart';

import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    getData();
  }
  final RentServices services = RentServices();
  List<Rent> rents = [];
  void getData() async {
    rents.clear();
    emit(HomeLoadingState());
    rents = await services.getUserRents("", 0, 'date', 5) ?? [];

    emit(HomeSuccessState());
  }
}
