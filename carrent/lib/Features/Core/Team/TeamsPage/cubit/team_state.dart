part of 'team_cubit.dart';

@immutable
sealed class UserTeamsState {}

final class TeamInitial extends UserTeamsState {}

final class TeamPageLoadingState extends UserTeamsState {}

final class TeamPageNoTeamState extends UserTeamsState {}

final class TeamPageSuccessState extends UserTeamsState {}

final class TeamPageFailState extends UserTeamsState {
  final String message;
  TeamPageFailState(this.message);
}
