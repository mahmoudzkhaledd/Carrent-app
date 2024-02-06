import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomButton.dart';
import 'package:carrent/Models/Invite.dart';
import 'package:carrent/Shared/Fonts/FontModel.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.notification,
    required this.onChangeState,
  });
  final Invitation notification;
  final Function(String, bool) onChangeState;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        radius: 25,
        child: AppText(
          notification.team.name[0].capitalize ?? notification.team.name[0],
          style: TextStyle(
            fontFamily: FontFamily.black,
            fontSize: 20,
          ),
        ),
      ),
      title: AppText(
        notification.leader.firstName.capitalize ??
            notification.leader.firstName,
        style: FontStyles.listTitle,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            "${notification.leader.firstName.capitalize ?? notification.leader.firstName} is inviting you to join his team.",
            style: FontStyles.p,
          ),
          const Gap(8),
          Row(
            children: [
              CustomButton(
                text: "Accept",
                fontSize: 12,
                verticalPadding: 5,
                horizontalPadding: 10,
                onTap: () => onChangeState(notification.id, true),
              ),
              const Gap(10),
              CustomButton(
                text: "Decline",
                fontSize: 12,
                backgroundColor: Colors.redAccent,
                verticalPadding: 5,
                horizontalPadding: 10,
                onTap: () => onChangeState(notification.id, false),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
