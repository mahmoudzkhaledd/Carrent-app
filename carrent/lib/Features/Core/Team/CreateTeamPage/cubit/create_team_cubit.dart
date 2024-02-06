import 'package:bloc/bloc.dart';
import 'package:carrent/Features/Core/Team/Services/TeamServices.dart';
import 'package:carrent/Features/Core/Team/TeamPage/View/TeamPage.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/Team.dart';
import 'package:carrent/services/GeneralServices/HandelNetworkRequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'create_team_state.dart';

class CreateTeamCubit extends Cubit<CreateTeamState> {
  String teamName = "";
  CreateTeamCubit() : super(CreateTeamInitial());
  final services = TeamServices();
  void createTeam() async {
    if (teamName.length > 100 || teamName.length < 3) {
      await Helper.showMessage(
        "Team name",
        "Team name must be between 3 and 100 characters",
        icon: Icons.my_library_books,
      );
      return;
    }
    emit(CreateTeamLoadingState());
    final res = await Helper.showLoading(
      "Creating your team",
      "Please wait",
      () => services.createUserTeam(teamName),
    );

    if (!res.success || res.data['team'] is! Map<String, dynamic>) {
      await HandelNetworkRequest.handelRequest(res);
      emit(CreateTeamFailedState());
      return;
    }

    Get.off(TeamPage(
      team: Team.fromJson(res.data['team']),
    ));
  }
}
