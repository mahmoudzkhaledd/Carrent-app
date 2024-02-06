import 'package:bloc/bloc.dart';
import 'package:carrent/Features/Core/Team/InviteMemberPage/View/InviteMemberPage.dart';
import 'package:carrent/Features/Core/Team/Services/TeamServices.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/Team.dart';
import 'package:carrent/Shared/AppUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'team_page_state.dart';

class TeamPageCubit extends Cubit<TeamPageState> {
  late Team team;
  String teamId = "";
  final services = TeamServices();
  TeamPageCubit(Team? team, String? teamId) : super(TeamPageInitial()) {
    if (team != null) {
      this.team = team;
      teamId = team.id;
      emit(TeamPageSuccessState());
    } else if (teamId != null) {
      this.teamId = teamId;
      getData();
    }
  }
  void getData() async {
    emit(TeamPageLoadingState());
    final res = await services.getTeam(teamId);

    if (res == null) {
      emit(TeamPageFailedState(
        "We couldn't find your team, please try again later",
      ));
      return;
    }
    team = res;
    emit(TeamPageSuccessState());
  }

  void showInviteMemberDialog() async {
    if (team.leader.id != Get.find<AppUser>().user!.id) {
      Helper.showMessage(
        "Invite Error",
        "Your are not the team leader!",
      );
      return;
    }
    Get.to(
      () => InviteMemberPage(
        team: team,
      ),
    );
  }
}
