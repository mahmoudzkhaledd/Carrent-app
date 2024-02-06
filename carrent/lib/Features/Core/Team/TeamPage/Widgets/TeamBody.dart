import 'package:carrent/Features/Core/Team/TeamPage/Widgets/TeamPageHeader.dart';
import 'package:carrent/Features/Core/Team/TeamPage/Widgets/TeamPages.dart';
import 'package:carrent/Features/Core/Team/TeamPage/cubit/team_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TeamBody extends StatelessWidget {
  const TeamBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeamPageCubit>();
    return RefreshIndicator(
      onRefresh: () async => cubit.getData(),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        children: const [
          TeamPageHeader(),
          Gap(20),
          TeamPages(),
        ],
      ),
    );
  }
}
