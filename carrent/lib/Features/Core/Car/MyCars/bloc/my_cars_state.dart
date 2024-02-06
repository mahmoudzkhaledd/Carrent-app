part of 'my_cars_cubit.dart';

@immutable
sealed class MyCarsState {}

final class MyCarsInitial extends MyCarsState {}

final class MyCarsLoadingState extends MyCarsState {}

final class MyCarsSuccesState extends MyCarsState {}

final class MyCarsFailState extends MyCarsState {}
