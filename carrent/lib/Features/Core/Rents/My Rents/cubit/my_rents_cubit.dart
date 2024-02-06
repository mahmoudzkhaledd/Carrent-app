import 'package:bloc/bloc.dart';
import 'package:carrent/Models/Rent.dart';
import 'package:meta/meta.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../services/GeneralServices/RentServices.dart';

part 'my_rents_state.dart';

class MyRentsCubit extends Cubit<MyRentsState> {
  DateTime currentDate = DateTime.now();
  DateTime? rangeStartDay;
  DateTime? rangeEndDay;

  List<Rent> selectedRent = [];
  MyRentsCubit() : super(MyRentsInitial()) {
    getData();
  }
  int page = 0;
  bool listView = true;
  final List<Rent> rents = [];
  final services = RentServices();
  final Map<String, List<Rent>> rentsDates = {};
  String search = "";

  void switchListView() {
    listView = !listView;
    emit(MyRentsInitial());
  }

  void getData() async {
    rents.clear();
    rentsDates.clear();
    emit(MyRentsLoadingState());
    final res = await services.getUserRents(search, page);

    if (res != null) {
      rents.addAll(res);
      for (var e in rents) {
        if (rentsDates[e.startingDate.toString().split(' ')[0]] == null) {
          rentsDates[e.startingDate.toString().split(' ')[0]] = [e];
        } else {
          rentsDates[e.startingDate.toString().split(' ')[0]]!.add(e);
        }
      }

      emit(MyRentsSuccesState());
    } else {
      emit(MyRentsFailState());
    }
  }

  void selectDate(DateTime selectedDay, DateTime focusDay) {
    if (isSameDay(selectedDay, currentDate)) {
      return;
    }
    currentDate = selectedDay;
    String date = currentDate.toString().split(' ')[0];
    selectedRent.clear();
    if (rentsDates[date] != null) {
      selectedRent.addAll(rentsDates[date]!);
    } else {
      rangeStartDay = null;
      rangeEndDay = null;
    }

    emit(MyRentsSelectDate());
  }

  selectRent(Rent rent) {
    rangeStartDay = DateTime.parse(rent.startingDate);
    rangeEndDay = DateTime.parse(rent.endingDate);
    emit(MyRentsSelectDate());
  }
}
