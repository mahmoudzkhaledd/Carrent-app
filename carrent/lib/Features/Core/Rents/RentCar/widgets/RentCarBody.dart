import 'package:carrent/GeneralWidgets/CarWidget.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomButton.dart';
import 'package:carrent/GeneralWidgets/CustomContainer.dart';
import 'package:carrent/GeneralWidgets/CustomDatePicker.dart';
import 'package:carrent/GeneralWidgets/CustomIconButton.dart';
import 'package:carrent/GeneralWidgets/CustomTextBox.dart';
import 'package:carrent/Shared/AppColors.dart';

import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../cubit/add_rent_car_cubit.dart';

class RentCarBody extends StatelessWidget {
  const RentCarBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddRentCarCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AppText(
                  'Rent Car',
                  style: FontStyles.title,
                  textAlign: TextAlign.center,
                ),
                const Gap(2),
                AppText(
                  'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.',
                  style: FontStyles.p,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Gap(30),
            BlocBuilder<AddRentCarCubit, AddRentCarState>(
              buildWhen: (previous, current) =>
                  current is AddRentCarChangeRentedCar,
              builder: (context, state) {
                if (cubit.rentedCar == null) {
                  return CustomContainer(
                    width: double.infinity,
                    onTap: cubit.rentedCar == null ? cubit.chooseCar : null,
                    height: 200,
                    bordered: true,
                    borderColor: AppColors.instance.borderText,
                    borderWidth: 1,
                    borderRadius: 10,
                    child: const Center(
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                  );
                }
                return CarWidget(
                  car: cubit.rentedCar!,
                  chooseMode: true,
                  cornerWidget: CustomIconButton(
                    icon: Icons.clear,
                    onTap: cubit.removeSelectedCar,
                    borderRadius: 200,
                    iconColor: Colors.white,
                    iconSize: 17,
                    backColor: Colors.red,
                    verticalPadding: 5,
                    horizontalPadding: 5,
                  ),
                );
              },
            ),
            const Gap(20),
            CustomTextBox(
              hintText: 'Client Name',
              icon: FluentIcons.rename_28_regular,
              initialValue: cubit.rent.clientName,
              onChanged: (e) => cubit.rent.clientName = e,
              validator: (e) {
                if (e == null || e.isEmpty) {
                  return "Please enter client Name";
                }
                return null;
              },
            ),
            const Gap(20),
            CustomTextBox(
              hintText: 'Client Phone',
              icon: FluentIcons.phone_48_regular,
              initialValue: cubit.rent.clientPhone,
              onChanged: (e) => cubit.rent.clientPhone = e,
              validator: (e) {
                if (e == null || e.isEmpty) {
                  return "Please enter phone number";
                }
                return null;
              },
            ),
            const Gap(20),
            CustomTextBox(
              hintText: 'Client ID',
              icon: FluentIcons.number_symbol_48_regular,
              initialValue: cubit.rent.clientIdentity,
              onChanged: (e) => cubit.rent.clientIdentity = e,
              validator: (e) {
                if (e == null || e.isEmpty) {
                  return "Please enter client identity";
                }
                return null;
              },
            ),
            const Gap(20),
            BlocBuilder<AddRentCarCubit, AddRentCarState>(
              buildWhen: (previous, current) =>
                  current is AddRentCarChangeRentDate,
              builder: (context, state) {
                return Column(
                  children: [
                    CustomDatePicker(
                      currentDate: DateTime.parse(cubit.rent.startingDate),
                      icon: FluentIcons.calendar_32_regular,
                      onChanged: (d) => cubit.changeRentDate(d, true),
                      firstDate:
                          DateTime.parse(cubit.rent.startingDate).subtract(
                        const Duration(days: 100),
                      ),
                      lastDate: DateTime.now().add(const Duration(days: 1000)),
                      subTitle: "Starting date",
                    ),
                    const Gap(20),
                    CustomDatePicker(
                      currentDate: DateTime.parse(cubit.rent.endingDate),
                      firstDate: DateTime.parse(cubit.rent.startingDate)
                          .add(const Duration(days: 1)),
                      lastDate: DateTime.parse(cubit.rent.startingDate)
                          .add(const Duration(days: 1000)),
                      icon: FluentIcons.calendar_32_regular,
                      onChanged: (d) => cubit.changeRentDate(d, false),
                      subTitle: "Ending date",
                    ),
                  ],
                );
              },
            ),
            const Gap(20),
            CustomTextBox(
              hintText: 'Total Price',
              isDecimal: true,
              icon: FluentIcons.money_24_regular,
              initialValue: cubit.rent.totalPrice.toStringAsFixed(2),
              onChanged: (e) => cubit.changePrice(e, true),
              validator: (e) {
                if (e == null || double.tryParse(e) == null) {
                  return "Please enter valid price";
                }
                return null;
              },
            ),
            const Gap(20),
            CustomTextBox(
              hintText: 'Paid Price',
              icon: FluentIcons.money_24_regular,
              initialValue: cubit.rent.paidPrice.toStringAsFixed(2),
              isDecimal: true,
              onChanged: (e) => cubit.changePrice(e, false),
              validator: (e) {
                if (e == null || double.tryParse(e) == null) {
                  return "Please enter valid price";
                }
                return null;
              },
            ),
            const Gap(20),
            BlocBuilder<AddRentCarCubit, AddRentCarState>(
              buildWhen: (previous, current) =>
                  current is AddRentCarChangeRemainingPrice,
              builder: (context, state) {
                return ListTile(
                  title: AppText(
                    'Remaining price',
                    style: FontStyles.input,
                  ),
                  trailing:
                      AppText(cubit.rent.remainingPrice.toStringAsFixed(2)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: AppColors.instance.borderText,
                        width: 1,
                      )),
                );
              },
            ),
            // CustomTextBox(
            //   hintText: 'Remaining Price',
            //   icon: FluentIcons.money_24_regular,
            //   initialValue: cubit.rent.remainingPrice.toStringAsFixed(2),
            //   isDecimal: true,
            //   onChanged: (e) =>
            //       cubit.rent.remainingPrice = double.tryParse(e) ?? 0,
            //   validator: (e) {
            //     if (e == null || double.tryParse(e) == null) {
            //       return "Please enter valid price";
            //     }
            //     return null;
            //   },
            // ),
            const Gap(20),
            CustomButton(
              text: cubit.editMode ? "Edit" : "Confirm Rent",
              onTap: cubit.rentCar,
            ),
          ],
        ),
      ),
    );
  }
}
