part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeFailedState extends HomeState {}

class HomeSuccessState extends HomeState {}
