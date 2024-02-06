part of 'car_page_cubit.dart';

@immutable
sealed class CarPageState {}

final class CarPageInitial extends CarPageState {}

final class CarPageAddImageState extends CarPageState {}

final class CarPageChangeImageIndex extends CarPageState {}

final class CarPageLoadingState extends CarPageState {}

final class CarPageSuccesState extends CarPageState {}

final class CarPageFailState extends CarPageState {}
