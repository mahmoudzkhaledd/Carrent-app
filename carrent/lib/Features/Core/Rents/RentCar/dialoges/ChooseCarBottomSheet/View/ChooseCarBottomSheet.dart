import 'package:carrent/GeneralWidgets/CarWidget.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomButton.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../Controller/ChooseCarBottomsheetCtrl.dart';

class ChooseCarBottomSheet extends GetView<ChooseCarBottomsheetCtrl> {
  const ChooseCarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseCarBottomsheetCtrl>(
      builder: (ctrl) {
        if (ctrl.loading) {
          return Helper.loadingWidget();
        }
        if (ctrl.cars == null) {
          return const Center(
            child: LoadingFailsWidget(
              title: "Error while loading cars, please try again later",
              image: "not found.png",
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  AppText(
                    'Choose car to rent',
                    style: FontStyles.listTitle,
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'Choose',
                    onTap: ctrl.chooseCar,
                  ),
                ],
              ),
              const Gap(5),
              Divider(color: AppColors.instance.borderText),
              const Gap(30),
              ...ctrl.cars!.map(
                (e) => CarWidget(
                  car: e,
                  chooseMode: true,
                  onTap: ctrl.selectCar,
                  cornerWidget: ctrl.selectedCar == e
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.instance.primary,
                          size: 26,
                        )
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
