import 'package:carrent/Features/Core/Team/InviteMemberPage/Widgets/InviteMemberBody.dart';
import 'package:carrent/Features/Core/Team/InviteMemberPage/cubit/invite_member_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/Models/Team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InviteMemberPage extends StatelessWidget {
  const InviteMemberPage({super.key, required this.team});
  final Team team;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Invite Member"),
      ),
      body: BlocProvider(
        create: (context) => InviteMemberCubit(team),
        child: const InviteMemberBody(),
      ),
    );
  }
}
