part of 'rent_details_cubit.dart';

@immutable
sealed class RentDetailsState {}

final class RentDetailsInitial extends RentDetailsState {}

final class RentDetailsLoadingState extends RentDetailsState {}

final class RentDetailsSuccessState extends RentDetailsState {}

final class RentDetailsFailedState extends RentDetailsState {}
