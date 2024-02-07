import 'package:carrent/Features/Core/Team/TeamsPage/Widgets/TeamView.dart';
import 'package:carrent/Features/Core/Team/TeamsPage/cubit/team_cubit.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTeamsBody extends StatelessWidget {
  const UserTeamsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingFailsWidget(
        title: '404 Not Found', image: 'not found.png');
    final cubit = context.read<UserTeamsCubit>();
    return BlocBuilder<UserTeamsCubit, UserTeamsState>(
      builder: (context, state) {
        if (state is TeamPageLoadingState) {
          return Helper.loadingWidget();
        }

        if (state is TeamPageFailState) {
          return RefreshIndicator(
            onRefresh: () async => cubit.getData(),
            child: ListView(
              children: [
                LoadingFailsWidget(
                  title: state.message,
                  image: 'not found.png',
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => cubit.getData(),
          child: TeamView(
            leadingTeams: cubit.leadingTeams,
            teams: cubit.teams,
          ),
        );
      },
    );
  }
}
