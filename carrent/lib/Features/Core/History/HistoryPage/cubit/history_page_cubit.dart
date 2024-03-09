import 'package:bloc/bloc.dart';
import 'package:carrent/Models/HistoryRecord.dart';
import 'package:meta/meta.dart';

import '../../../../../services/GeneralServices/HistoryServices.dart';

part 'history_page_state.dart';

class HistoryPageCubit extends Cubit<HistoryPageState> {
  final List<HistoryRecord> history = [];
  HistoryPageCubit() : super(HistoryPageInitial()) {
    getData();
  }
  final HistoryServices services = HistoryServices();
  void getData() async {
    history.clear();
    emit(HistoryPageLoadingState());
    history.addAll(await services.getUserHistory(null) ?? []);
    emit(HistoryPageSuccessState());
  }
}
