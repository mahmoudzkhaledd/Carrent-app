part of 'create_team_cubit.dart';

@immutable
sealed class CreateTeamState {}

final class CreateTeamInitial extends CreateTeamState {}

final class CreateTeamLoadingState extends CreateTeamState {}

final class CreateTeamFailedState extends CreateTeamState {}

final class CreateTeamSuccessState extends CreateTeamState {}
