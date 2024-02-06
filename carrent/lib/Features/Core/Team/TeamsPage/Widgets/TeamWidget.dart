import 'package:carrent/Features/Core/Team/TeamPage/View/TeamPage.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/Models/Team.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeamWidget extends StatelessWidget {
  const TeamWidget({super.key, required this.team});
  final Team team;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.instance.borderText,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      onTap: () {
        Get.to(
          () => TeamPage(
            teamId: team.id,
          ),
        );
      },
      title: AppText(
        team.name,
        style: FontStyles.listTitle,
      ),
      subtitle: AppText(
        "Created at: ${DateFormat.yMMMEd('en_US').format(team.createdAt)}",
        style: FontStyles.p,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
