import 'package:bloc/bloc.dart';
import 'package:carrent/Models/HistoryRecord.dart';
import 'package:carrent/Models/Rent.dart';
import 'package:carrent/services/GeneralServices/HistoryServices.dart';
import 'package:carrent/services/GeneralServices/RentServices.dart';

import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    getData();
  }
  final HistoryServices services = HistoryServices();
  List<HistoryRecord> history = [];
  void getData() async {
    history.clear();
    emit(HomeLoadingState());
    history = await services.getUserHistory(10) ?? [];

    emit(HomeSuccessState());
  }
}
