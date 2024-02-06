import 'package:carrent/Models/Pair.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../GeneralWidgets/AppText.dart';
import '../../../../../GeneralWidgets/CustomContainer.dart';
import '../../../../../Shared/AppColors.dart';
import '../../../../../Shared/SharedTextStyles.dart';

class RentDetailCard extends StatelessWidget {
  const RentDetailCard({
    super.key,
    required this.title,
    required this.rows,
    this.icon,
    this.onTap,
  });
  final String title;
  final IconData? icon;
  final Function()? onTap;
  final List<Pair<String, String>> rows;
  TableRow buildTableRow(String title, String data) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppText(
              title,
              style: FontStyles.p,
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppText(
              data,
              style: FontStyles.listTitle.copyWith(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: 10,
      verticalPadding: 15,
      horizontalPadding: 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText(
                title,
                style: FontStyles.listTitle,
              ),
              const Spacer(),
              if (icon != null)
                IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    icon,
                  ),
                ),
            ],
          ),
          Divider(
            color: AppColors.instance.borderText,
          ),
          const Gap(10),
          Table(
            children:
                rows.map((e) => buildTableRow(e.first, e.second)).toList(),
          ),
        ],
      ),
    );
  }
}
