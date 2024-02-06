import 'package:carrent/Features/Core/Team/TeamPage/Widgets/TeamBody.dart';
import 'package:carrent/Features/Core/Team/TeamPage/cubit/team_page_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/Team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({
    super.key,
    this.team,
    this.teamId,
  });
  final Team? team;
  final String? teamId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Team"),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => TeamPageCubit(team, teamId),
          child: BlocBuilder<TeamPageCubit, TeamPageState>(
            builder: (context, state) {
              if (state is TeamPageLoadingState) {
                return Helper.loadingWidget();
              }
              if (state is TeamPageFailedState) {
                return RefreshIndicator(
                  onRefresh: () async =>
                      context.read<TeamPageCubit>().getData(),
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      children: [
                        LoadingFailsWidget(
                          title: state.message,
                          image: 'not found.png',
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const TeamBody();
            },
          ),
        ),
      ),
    );
  }
}
