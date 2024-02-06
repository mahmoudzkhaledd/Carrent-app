import 'package:carrent/Features/Core/Team/CreateTeamPage/cubit/create_team_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomButton.dart';
import 'package:carrent/GeneralWidgets/CustomTextBox.dart';
import 'package:carrent/GeneralWidgets/Image.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CreateTeamBody extends StatelessWidget {
  const CreateTeamBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateTeamCubit>();
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        children: [
          AppText(
            "Meet Your Car Rental Team",
            textAlign: TextAlign.center,
            style: FontStyles.listTitle,
          ),
          Center(
            child: AppText(
              "Where every team member is geared towards your satisfaction.",
              textAlign: TextAlign.center,
              style: FontStyles.p,
            ),
          ),
          const CustomImage('team.png'),
          CustomTextBox(
            hintText: "Team name",
            icon: Icons.text_format_sharp,
            maxLength: 100,
            onChanged: (e) => cubit.teamName = e,
          ),
          const Gap(20),
          CustomButton(
            text: "Create One",
            onTap: cubit.createTeam,
          ),
        ],
      ),
    );
  }
}
