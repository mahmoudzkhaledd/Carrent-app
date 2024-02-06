import 'package:carrent/Features/Core/Car/AddNewCar/View/AddNewCar.dart';
import 'package:carrent/Features/Core/Car/MyCars/View/MyCars.dart';
import 'package:carrent/Features/Core/Rents/My%20Rents/view/MyRents.dart';
import 'package:carrent/Features/Core/Rents/RentCar/view/RentCar.dart';
import 'package:carrent/GeneralWidgets/CustomIconButton.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OptionsRow extends StatelessWidget {
  const OptionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    const double padding = 12;
    const double spacing = 25;

    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        CustomIconButton(
          onTap: () {
            Get.to(() => const AddNewCarPage());
          },
          icon: Icons.add,
          backColor: AppColors.instance.secondary,
          borderRadius: 200,
          verticalPadding: padding,
          horizontalPadding: padding,
          text: "Add Car",
        ),
        const Gap(spacing),
        CustomIconButton(
          onTap: () {
            Get.to(() => const MyCarsPage());
          },
          icon: Icons.time_to_leave,
          backColor: AppColors.instance.secondary,
          borderRadius: 200,
          verticalPadding: padding,
          horizontalPadding: padding,
          text: "My Cars",
        ),
        const Gap(spacing),
        CustomIconButton(
          onTap: () {
            Get.to(() => const RentCarPage());
          },
          icon: Icons.monetization_on,
          backColor: AppColors.instance.secondary,
          borderRadius: 200,
          verticalPadding: padding,
          horizontalPadding: padding,
          text: "Rent Car",
        ),
        const Gap(spacing),
        CustomIconButton(
          onTap: () {
            Get.to(() => const MyRentsPage());
          },
          icon: Icons.arrow_circle_down_rounded,
          backColor: AppColors.instance.secondary,
          borderRadius: 200,
          verticalPadding: padding,
          horizontalPadding: padding,
          text: "Current Rents",
        ),
      ],
    );
  }
}
