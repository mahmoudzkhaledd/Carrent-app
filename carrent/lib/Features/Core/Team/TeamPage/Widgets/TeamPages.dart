import 'package:carrent/Features/Core/Team/TeamPage/cubit/team_page_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomContainer.dart';
import 'package:carrent/Shared/AppColors.dart';

import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TeamPages extends StatelessWidget {
  const TeamPages({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeamPageCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          "Team Members",
          style: FontStyles.title,
        ),
        const Gap(15),
        if (cubit.team.members.isNotEmpty)
          ...cubit.team.members.map(
            (e) {
              return CustomContainer(
                borderColor: AppColors.instance.borderText,
                bordered: true,
                borderWidth: 1,
                horizontalPadding: 15,
                verticalPadding: 5,
                borderRadius: 10,
                clip: Clip.hardEdge,
                onTap: () {},
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    child: AppText(
                      e.firstName[0].capitalize ?? e.firstName[0],
                      style: FontStyles.listTitle,
                    ),
                  ),
                  title: AppText(
                    e.firstName,
                    style: FontStyles.listTitle,
                  ),
                ),
              );
            },
          )
        else
          Center(
            child: Column(
              children: [
                const Gap(50),
                AppText(
                  "No Members in the team yet!",
                  style: FontStyles.input,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
