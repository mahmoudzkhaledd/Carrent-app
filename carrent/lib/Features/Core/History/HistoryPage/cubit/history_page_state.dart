part of 'history_page_cubit.dart';

@immutable
sealed class HistoryPageState {}

final class HistoryPageInitial extends HistoryPageState {}

final class HistoryPageLoadingState extends HistoryPageState {}

final class HistoryPageSuccessState extends HistoryPageState {}
