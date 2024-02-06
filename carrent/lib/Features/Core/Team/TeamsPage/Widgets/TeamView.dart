import 'package:carrent/Features/Core/Team/CreateTeamPage/View/CreateTeamPage.dart';
import 'package:carrent/Features/Core/Team/TeamsPage/Widgets/TeamWidget.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/Image.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/Team.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TeamView extends StatelessWidget {
  const TeamView({super.key, required this.leadingTeams, required this.teams});
  final List<Team> leadingTeams;
  final List<Team> teams;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      children: [
        Center(
          child: CustomImage(
            'team.png',
            width: Helper.size(context).width * 4 / 5,
          ),
        ),
        AppText(
          "Leading Teams",
          style: FontStyles.title,
        ),
        const Gap(20),
        if (leadingTeams.isEmpty)
          const LoadingFailsWidget(title: "No Teams Added yet", image: null)
        else
          ...leadingTeams.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TeamWidget(team: e),
            ),
          ),
        ListTile(
          title: AppText(
            "Create your Team",
            style: FontStyles.listTitle,
          ),
          subtitle: AppText(
            "Click to create your team",
            style: FontStyles.p,
          ),
          onTap: () {
            Get.to(const CreateTeamPage());
          },
          trailing: const Icon(Icons.add),
        ),
        const Gap(20),
        AppText(
          "Member Teams",
          style: FontStyles.title,
        ),
        const Gap(10),
        if (teams.isEmpty)
          const LoadingFailsWidget(
            title: "You're not in a team yet!",
            image: null,
          )
        else
          ...teams.map(
            (e) => TeamWidget(team: e),
          ),
        const Gap(50),
      ],
    );
  }
}
