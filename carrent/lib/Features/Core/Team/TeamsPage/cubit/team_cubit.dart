import 'package:bloc/bloc.dart';
import 'package:carrent/Features/Core/Team/Services/TeamServices.dart';
import 'package:carrent/Models/Team.dart';
import 'package:meta/meta.dart';

part 'team_state.dart';

class UserTeamsCubit extends Cubit<UserTeamsState> {
  final services = TeamServices();

  final List<Team> leadingTeams = [];
  final List<Team> teams = [];

  UserTeamsCubit() : super(TeamInitial()) {
    getData();
  }
  void getData() async {
    teams.clear();
    leadingTeams.clear();
    emit(TeamPageLoadingState());
    final res = await services.getUserTeams();

    if (!res.success ||
        res.data['teams'] is! List<dynamic> ||
        res.data['leadingTeams'] is! List<dynamic>) {
      emit(
        TeamPageFailState(
          res.msg ?? "Error occured, please try again later",
        ),
      );
      return;
    }
    for (var i in res.data['teams']) {
      teams.add(Team.fromJson(i));
    }
    for (var i in res.data['leadingTeams']) {
      leadingTeams.add(Team.fromJson(i));
    }

    emit(TeamPageSuccessState());
  }
}
