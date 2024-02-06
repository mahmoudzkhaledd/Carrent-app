part of 'team_page_cubit.dart';

@immutable
sealed class TeamPageState {}

final class TeamPageInitial extends TeamPageState {}

final class TeamPageLoadingState extends TeamPageState {}

final class TeamPageFailedState extends TeamPageState {
  final String message;
  TeamPageFailedState(this.message);
}

final class TeamPageSuccessState extends TeamPageState {}
