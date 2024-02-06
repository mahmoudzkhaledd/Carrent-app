import 'package:carrent/Features/Core/Rents/RentDetailsPage/view/RentDetailsPage.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/Models/Rent.dart';

import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecentRents extends StatelessWidget {
  const RecentRents({
    super.key,
    required this.rents,
  });
  final List<Rent> rents;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Recent Rents',
          style: FontStyles.title,
        ),
        ...rents.map(
          (e) => ListTile(
            onTap: () {
              Get.to(() => RentDetailsPage(rentId: e.id));
            },
            contentPadding: EdgeInsets.zero,
            title: AppText(
              e.clientName,
              style: FontStyles.listTitle,
            ),
            leading: const CircleAvatar(
              foregroundColor: Colors.black,
              child: Icon(Icons.time_to_leave),
            ),
            subtitle: AppText(
              DateFormat('DD/MM/yyyy').format(DateTime.parse(e.createdAt)),
              style: FontStyles.p,
            ),
            trailing: AppText(
              '${e.paidPrice}\$',
              style: FontStyles.listTitle,
            ),
          ),
        ),
        if (rents.isEmpty) const Gap(30),
        if (rents.isEmpty)
          Center(
            child: AppText(
              "No rents yet!",
              style: FontStyles.input,
            ),
          )
      ],
    );
  }
}
