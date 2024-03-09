import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/HistoryComponent.dart';
import 'package:carrent/Models/HistoryRecord.dart';

import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../Core/History/HistoryPage/View/HistoryPage.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({
    super.key,
    required this.histories,
  });

  final List<HistoryRecord> histories;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              'Recent Rents',
              style: FontStyles.title,
            ),
            TextButton(
              onPressed: () {
                Get.to(() => const HistoryPage());
              },
              child: AppText(
                "Show more",
                style: FontStyles.p,
              ),
            ),
          ],
        ),
        ...histories.map(
          (e) => HistoryComponent(
            history: e,
          ),
        ),
        if (histories.isEmpty) const Gap(30),
        if (histories.isEmpty)
          Center(
            child: AppText(
              "No actions done yet!",
              style: FontStyles.input,
            ),
          )
      ],
    );
  }
}
