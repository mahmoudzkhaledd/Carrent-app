import 'package:carrent/Models/HistoryRecord.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Features/Core/Car/CarPage/view/CarPage.dart';
import '../Features/Core/Rents/RentDetailsPage/view/RentDetailsPage.dart';
import '../Features/Core/Team/TeamPage/View/TeamPage.dart';
import '../Shared/SharedTextStyles.dart';
import 'AppText.dart';

class HistoryComponent extends StatelessWidget {
  final HistoryRecord history;
  const HistoryComponent({super.key, required this.history});
  String getTitle(HistoryType type) {
    if (type == HistoryType.add_car) {
      return "Added car";
    } else if (type == HistoryType.create_team) {
      return "Create team";
    } else if (type == HistoryType.edit_car) {
      return "Updated car";
    } else if (type == HistoryType.finish_rent) {
      return "Finish rent";
    } else if (type == HistoryType.remove_rent) {
      return "Remove rent";
    } else if (type == HistoryType.rent_car) {
      return "Rent car";
    } else if (type == HistoryType.active_rent) {
      return "Active rent";
    }
    return "None";
  }

  void onTap(HistoryRecord record) {
    final type = record.type;
    if (type == HistoryType.add_car) {
      Get.to(() => CarPage(id: record.carId));
    } else if (type == HistoryType.create_team) {
      Get.to(() => TeamPage(teamId: record.temId));
    } else if (type == HistoryType.edit_car) {
      Get.to(() => CarPage(id: record.carId));
    } else if (type == HistoryType.finish_rent) {
      Get.to(() => RentDetailsPage(rentId: record.rentId));
    } else if (type == HistoryType.remove_rent) {
    } else if (type == HistoryType.rent_car) {
      Get.to(() => RentDetailsPage(rentId: record.rentId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(history),
      contentPadding: EdgeInsets.zero,
      title: AppText(
        getTitle(history.type),
        style: FontStyles.listTitle,
      ),
      leading: const CircleAvatar(
        foregroundColor: Colors.black,
        child: Icon(Icons.time_to_leave),
      ),
      subtitle: AppText(
        DateFormat('DD/MM/yyyy-hh:mm')
            .format(DateTime.parse(history.createdAt)),
        style: FontStyles.p,
      ),
    );
  }
}
