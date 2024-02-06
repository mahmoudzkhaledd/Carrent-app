import 'package:carrent/Features/Core/Team/TeamPage/cubit/team_page_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomContainer.dart';
import 'package:carrent/GeneralWidgets/CustomIconButton.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:carrent/Shared/Fonts/FontModel.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeamPageHeader extends StatelessWidget {
  const TeamPageHeader({super.key});
  Widget makeDescription(String title, String data, [bool toggle = false]) {
    return Column(
      crossAxisAlignment:
          toggle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          toggle ? data : title,
          style: FontStyles.listTitle,
        ),
        AppText(
          toggle ? title : data,
          style: FontStyles.p,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeamPageCubit>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(222, 239, 255, 1),
      ),
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          CustomContainer(
            backColor: AppColors.instance.secondarySelect,
            horizontalPadding: 20,
            verticalPadding: 20,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        child: AppText(
                          cubit.team.name[0],
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: FontFamily.black,
                          ),
                        ),
                      ),
                      AppText(
                        cubit.team.leader.firstName.capitalize ??
                            cubit.team.leader.firstName,
                        style: FontStyles.listTitle,
                        textAlign: TextAlign.center,
                      ),
                      AppText(
                        "#Team Leader",
                        style: FontStyles.p.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      makeDescription("Name", cubit.team.name),
                      const Gap(10),
                      makeDescription(
                        "Members",
                        "${cubit.team.members.length + 1} Member",
                      ),
                      const Gap(10),
                      makeDescription(
                        "Invitations",
                        "${cubit.team.pendingInvitations.length} invite",
                      ),
                      const Gap(10),
                      makeDescription(
                        "Created at",
                        DateFormat.yMMMMd("en_US").format(cubit.team.createdAt),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                      icon: Icons.add,
                      onTap: cubit.showInviteMemberDialog,
                      verticalPadding: 10,
                      horizontalPadding: 10,
                      borderRadius: 200,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: makeDescription(
                  "Cars",
                  "200",
                  true,
                ),
              ),
              Expanded(
                child: makeDescription(
                  "Rents",
                  "50",
                  true,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
