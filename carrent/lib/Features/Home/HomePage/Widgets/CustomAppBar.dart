import 'package:carrent/Features/Core/Notifications/NotificationPage/View/NotificationPage.dart';
import 'package:carrent/Features/Home/HomePage/Widgets/HomePageBottomSheet.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomIconButton.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Helper.showBottomSheetWidget(const HomePageBottomSheet());
                },
                icon: const Icon(Icons.menu_rounded),
              ),
              const Icon(
                Icons.account_circle_rounded,
                size: 45,
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "Hello!",
                    style: FontStyles.body,
                  ),
                  AppText(
                    "Mahmoud",
                    style: FontStyles.listTitle,
                  ),
                ],
              ),
            ],
          ),
          CustomIconButton(
            onTap: () {
              Get.to(() => const NotificationPage());
            },
            icon: Icons.notifications,
            backColor: AppColors.instance.secondary,
            borderRadius: 200,
          ),
        ],
      ),
    );
  }
}
