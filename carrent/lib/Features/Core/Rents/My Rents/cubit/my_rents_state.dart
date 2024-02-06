part of 'my_rents_cubit.dart';

@immutable
sealed class MyRentsState {}

final class MyRentsInitial extends MyRentsState {}

final class MyRentsLoadingState extends MyRentsState {}

final class MyRentsSuccesState extends MyRentsState {}

final class MyRentsFailState extends MyRentsState {}

final class MyRentsSelectDate extends MyRentsState {}
