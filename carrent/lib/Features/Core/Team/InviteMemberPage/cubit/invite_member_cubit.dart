import 'package:bloc/bloc.dart';
import 'package:carrent/Features/Core/Team/Services/TeamServices.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/Team.dart';
import 'package:carrent/Shared/AppUser.dart';
import 'package:carrent/services/GeneralServices/HandelNetworkRequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'invite_member_state.dart';

class InviteMemberCubit extends Cubit<InviteMemberState> {
  InviteMemberCubit(this.team) : super(InviteMemberInitial());
  final Team team;
  final service = TeamServices();
  String userId = "";
  void inviteUser() async {
    if (userId.length != 24) {
      await Helper.showMessage(
        "User id error",
        "Please enter valid user id!",
      );
      return;
    }
    if (userId == Get.find<AppUser>().user!.id) {
      await Helper.showMessage(
        "User id error",
        "You can't invite yourself !",
      );
      return;
    }
    emit(InviteMemberLoadingState());
    final res = await service.inviteUser(team.id, userId);
    if (!await HandelNetworkRequest.handelRequest(res)) {
      emit(InviteMemberInitial());
      return;
    }

    Helper.showMessage(
      "Succeful Operation",
      "Invitation sent succefully",
      icon: Icons.send,
    );
    emit(InviteMemberInitial());
  }
}
