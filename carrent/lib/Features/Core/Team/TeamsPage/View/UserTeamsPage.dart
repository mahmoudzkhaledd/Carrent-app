import 'package:carrent/Features/Core/Team/TeamsPage/Widgets/UserTeamsBody.dart';
import 'package:carrent/Features/Core/Team/TeamsPage/cubit/team_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTeamsPage extends StatelessWidget {
  const UserTeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Team"),
      ),
      body: BlocProvider(
        create: (context) => UserTeamsCubit(),
        child: const SafeArea(child: UserTeamsBody()),
      ),
    );
  }
}
