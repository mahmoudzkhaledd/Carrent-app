import 'package:carrent/Features/Core/Rents/My%20Rents/cubit/my_rents_cubit.dart';
import 'package:carrent/Features/Core/Rents/RentDetailsPage/view/RentDetailsPage.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomButton.dart';
import 'package:carrent/GeneralWidgets/CustomIconButton.dart';

import 'package:carrent/Models/Rent.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../GeneralWidgets/CustomContainer.dart';

class RentWidget extends StatelessWidget {
  const RentWidget({
    super.key,
    required this.rent,
    this.listView = false,
    required this.selectRent,
  });
  final bool listView;
  final Function(Rent) selectRent;
  TableRow buildDescription(String title, String data) => TableRow(
        children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AppText(
                title,
                style: FontStyles.p,
              ),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AppText(
                data,
                style: FontStyles.listTitle,
              ),
            ),
          ),
        ],
      );
  final Rent rent;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomContainer(
          verticalPadding: 15,
          horizontalPadding: 20,
          borderRadius: 10,
          borderColor: AppColors.instance.borderText,
          borderWidth: 1,
          bordered: true,
          child: Column(
            children: [
              if (rent.car != null)
                Table(
                  children: [
                    buildDescription('Car name', rent.car!.name),
                    buildDescription('Car model', rent.car!.model),
                    buildDescription('Client name', rent.clientName),
                    buildDescription(
                      'Total price',
                      rent.totalPrice.toStringAsFixed(2),
                    ),
                  ],
                ),
              const Gap(20),
              CustomButton(
                text: "See full details",
                onTap: () {
                  Get.to(
                    () => RentDetailsPage(
                      rentId: rent.id,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        if (!listView)
          Positioned(
            top: -12,
            right: -12,
            child: CustomIconButton(
              verticalPadding: 5,
              horizontalPadding: 5,
              borderRadius: 200,
              iconSize: 20,
              iconColor: Colors.white,
              backColor: AppColors.instance.primary,
              icon: Icons.calendar_month_rounded,
              onTap: () => selectRent(rent),
            ),
          ),
      ],
    );
  }
}
