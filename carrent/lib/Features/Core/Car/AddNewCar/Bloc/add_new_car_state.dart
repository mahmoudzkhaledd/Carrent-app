part of 'add_new_car_cubit.dart';

@immutable
sealed class AddNewCarState {}

final class AddNewCarInitial extends AddNewCarState {}

final class AddNewCarLoadingState extends AddNewCarState {}

final class AddNewCarFailedState extends AddNewCarState {}

final class AddNewCarSuccessState extends AddNewCarState {}

final class ChangeCarRentDate extends AddNewCarState {}

final class ChangeAddNewCarPage extends AddNewCarState {}

final class AddNewCarChangeImageIndex extends AddNewCarState {}

final class AddNewImageAddNewCar extends AddNewCarState {}
