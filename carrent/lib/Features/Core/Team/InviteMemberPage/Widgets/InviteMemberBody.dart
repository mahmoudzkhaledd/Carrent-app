import 'package:carrent/Features/Core/Team/InviteMemberPage/cubit/invite_member_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomButton.dart';
import 'package:carrent/GeneralWidgets/CustomTextBox.dart';
import 'package:carrent/GeneralWidgets/Image.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class InviteMemberBody extends StatelessWidget {
  const InviteMemberBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InviteMemberCubit>();
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CustomImage(
                "invite.png",
                width: Helper.size(context).width * 1 / 2,
              ),
            ),
            const Gap(20),
            AppText(
              "Invite Member to your team",
              style: FontStyles.listTitle,
              textAlign: TextAlign.center,
            ),
            AppText(
              "An invitation will be sent to this person in notification center.",
              style: FontStyles.p,
              textAlign: TextAlign.center,
            ),
            const Gap(40),
            CustomTextBox(
              hintText: "User invitation code",
              onChanged: (e) => cubit.userId = e,
            ),
            const Gap(20),
            BlocBuilder<InviteMemberCubit, InviteMemberState>(
              builder: (context, state) {
                return CustomButton(
                  text: "Send invitation",
                  loading: state is InviteMemberLoadingState,
                  onTap: cubit.inviteUser,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
