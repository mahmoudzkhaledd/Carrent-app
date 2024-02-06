import 'package:carrent/Features/Auth/StartingPage/View/StartingPage.dart';
import 'package:carrent/Features/Core/Team/TeamsPage/View/UserTeamsPage.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:carrent/services/GeneralServices/StorageService.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomePageBottomSheet extends StatelessWidget {
  const HomePageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          const Gap(20),
          ListTile(
            onTap: () {
              Get.off(() => const UserTeamsPage());
            },
            contentPadding: EdgeInsets.zero,
            title: AppText(
              'My Team',
              style: FontStyles.listTitle,
            ),
            subtitle: AppText(
              'Create your team',
              style: FontStyles.p,
            ),
            leading: const CircleAvatar(
              foregroundColor: Colors.black,
              child: Icon(Icons.people_alt_rounded),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: AppText(
              "My profile",
              style: FontStyles.listTitle,
            ),
            subtitle: AppText(
              'Go to profile settings',
              style: FontStyles.p,
            ),
            leading: const CircleAvatar(
              foregroundColor: Colors.black,
              child: Icon(Icons.settings),
            ),
          ),
          ListTile(
            onTap: () async {
              bool res = await StorageServices.instance.removeUserToken();
              if (res) {
                Get.offAll(() => const LandingPage());
              }
            },
            contentPadding: EdgeInsets.zero,
            title: AppText(
              "Logout",
              style: FontStyles.listTitle,
            ),
            leading: const CircleAvatar(
              foregroundColor: Colors.black,
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}
