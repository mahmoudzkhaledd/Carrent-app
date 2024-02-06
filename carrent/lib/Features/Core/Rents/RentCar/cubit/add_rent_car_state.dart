part of 'add_rent_car_cubit.dart';

@immutable
sealed class AddRentCarState {}

final class AddRentCarInitial extends AddRentCarState {}

final class AddRentCarChangeRentedCar extends AddRentCarState {}

final class AddRentCarChangeRentDate extends AddRentCarState {}

final class AddRentCarChangeRemainingPrice extends AddRentCarState {}
