import 'package:carrent/Features/Core/Car/AddNewCar/View/AddNewCar.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomContainer.dart';
import 'package:carrent/GeneralWidgets/SubUserDescription.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/Car.dart';
import 'package:carrent/Shared/AppUser.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../Features/Core/Car/CarPage/view/CarPage.dart';
import '../Shared/AppColors.dart';

class CarWidget extends StatelessWidget {
  const CarWidget({
    super.key,
    required this.car,
    this.chooseMode = false,
    this.onTap,
    this.cornerWidget,
  });
  final Car car;
  final bool chooseMode;
  final Function(Car)? onTap;
  final Widget? cornerWidget;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      marginBottom: 15,
      verticalPadding: 15,
      borderColor: AppColors.instance.borderText,
      borderWidth: 1,
      bordered: true,
      horizontalPadding: 20,
      onTap: onTap != null
          ? () {
              onTap!(car);
            }
          : () {
              if (chooseMode) return;
              Get.to(
                () => CarPage(
                  id: car.id,
                ),
              );
            },
      borderRadius: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      car.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FontStyles.listTitle.copyWith(
                        fontSize: 17,
                      ),
                      capitalizeFirst: true,
                    ),
                    AppText(
                      car.model,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: FontStyles.p,
                      capitalizeFirst: true,
                    ),
                  ],
                ),
              ),
              if (cornerWidget != null) cornerWidget!,
              if (car.userId == Get.find<AppUser>().user!.id && !chooseMode)
                IconButton(
                  icon: const Icon(Icons.edit),
                  iconSize: 20,
                  onPressed: () {
                    Get.to(() => AddNewCarPage(car: car));
                  },
                ),
            ],
          ),
          const Gap(10),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Helper.loadNetworkImage(
                    car.thumbnailImageModel != null
                        ? car.thumbnailImageModel!.url
                        : "",
                    'car.png',
                  ),
                ),
              ),
            ),
          ),
          const Gap(10),
          Wrap(
            runSpacing: 5,
            spacing: 5,
            children: [
              SubUserDescription(
                icon: FluentIcons.people_48_regular,
                data: car.passengersNumber.toString(),
                fontSize: 13.4,
              ),
              SubUserDescription(
                icon: FluentIcons.number_symbol_48_regular,
                data: car.panelNumber,
                fontSize: 13.4,
                letterSpacing: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
