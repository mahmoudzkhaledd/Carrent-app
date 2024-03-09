part of 'all_packages_cubit.dart';

@immutable
sealed class AllPackagesState {}

final class AllPackagesInitial extends AllPackagesState {}

final class AllPackagesLoadingState extends AllPackagesState {}

final class AllPackagesSuccesState extends AllPackagesState {}

final class AllPackagesFailState extends AllPackagesState {}
