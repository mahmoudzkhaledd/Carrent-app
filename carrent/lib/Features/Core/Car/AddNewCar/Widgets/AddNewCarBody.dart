import 'package:carrent/GeneralWidgets/CustomIconButton.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:carrent/GeneralWidgets/CustomButton.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../GeneralWidgets/AppText.dart';
import '../../../../../GeneralWidgets/CustomContainer.dart';
import '../../../../../GeneralWidgets/CustomTextBox.dart';
import '../../../../../Shared/AppColors.dart';
import '../Bloc/add_new_car_cubit.dart';

class AddNewCarBody extends StatelessWidget {
  const AddNewCarBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewCarCubit>();

    return BlocBuilder<AddNewCarCubit, AddNewCarState>(
      buildWhen: (previous, current) =>
          current is AddNewCarLoadingState ||
          current is AddNewCarFailedState ||
          current is AddNewCarSuccessState,
      builder: (context, state) {
        if (state is AddNewCarLoadingState) {
          return Helper.loadingWidget();
        }
        if (state is AddNewCarFailedState) {
          return const LoadingFailsWidget(
            title: "Can't find this car, please try again.",
            image: "not found.png",
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                const Gap(10),
                AppText(
                  cubit.editMode ? "Edit Car Mode" : "Add new car",
                  style: FontStyles.title,
                  textAlign: TextAlign.center,
                ),
                const Gap(9),
                AppText(
                  cubit.editMode
                      ? "Edit Car Mode Edit Car Mode Edit Car Mode Edit Car Mode Edit Car Mode Edit Car Mode Edit Car Mode "
                      : "Add new car Add new car Add new car Add new car Add new car Add new car Add new car ",
                  style: FontStyles.p,
                  textAlign: TextAlign.center,
                ),
                const Gap(30),
                BlocBuilder<AddNewCarCubit, AddNewCarState>(
                  buildWhen: (previous, current) =>
                      current is AddNewImageAddNewCar,
                  builder: (context, state) {
                    return Stack(
                      children: [
                        CustomContainer(
                          width: double.infinity,
                          height: 200,
                          backColor: AppColors.instance.secondarySelect,
                          borderRadius: 10,
                          onTap: cubit.chosenImage == null
                              ? cubit.chooseImage
                              : null,
                          child: cubit.car.thumbnailImageModel == null &&
                                  cubit.chosenImage == null
                              ? const Center(
                                  child: Icon(Icons.add),
                                )
                              : cubit.car.thumbnailImageModel != null
                                  ? Helper.loadNetworkImage(
                                      cubit.car.thumbnailImageModel!.url,
                                      'car.png',
                                    )
                                  : Image.file(
                                      cubit.chosenImage!,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                        if (cubit.car.thumbnailImageModel != null)
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: CustomContainer(
                              width: double.infinity,
                              borderRadius: 10,
                              backColor: Colors.black45,
                              child: Center(
                                child: IconButton(
                                  onPressed: cubit.removeNetworkImage,
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (cubit.chosenImage != null)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Row(
                              children: [
                                CustomIconButton(
                                  verticalPadding: 5,
                                  horizontalPadding: 5,
                                  onTap: cubit.chooseImage,
                                  icon: Icons.edit,
                                  backColor: Colors.white,
                                  iconSize: 18,
                                  borderRadius: 200,
                                ),
                                const Gap(10),
                                CustomIconButton(
                                  verticalPadding: 5,
                                  horizontalPadding: 5,
                                  onTap: cubit.removeImage,
                                  icon: Icons.clear,
                                  iconColor: Colors.white,
                                  iconSize: 18,
                                  backColor: Colors.red,
                                  borderRadius: 200,
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const Gap(20),
                CustomTextBox(
                  icon: FluentIcons.rename_28_regular,
                  hintText: "Name",
                  onChanged: (s) => cubit.car.name = s,
                  maxLength: 32,
                  initialValue: cubit.car.name,
                  validator: (str) {
                    if (str == null || str.length > 32 || str.length < 3) {
                      return "Name must be between 3 and 32 characters.";
                    }
                    return null;
                  },
                ),
                const Gap(10),
                CustomTextBox(
                  icon: FluentIcons.vehicle_car_48_regular,
                  hintText: "Model",
                  initialValue: cubit.car.model,
                  onChanged: (s) => cubit.car.model = s,
                  maxLength: 32,
                  validator: (str) {
                    if (str == null || str.length > 32 || str.length < 3) {
                      return "Model must be between 3 and 32 characters.";
                    }
                    return null;
                  },
                ),
                const Gap(10),
                CustomTextBox(
                  icon: FluentIcons.number_symbol_48_regular,
                  hintText: "Plate Number",
                  initialValue: cubit.car.panelNumber,
                  onChanged: (s) => cubit.car.panelNumber = s,
                  letterSpacing: 5,
                  maxLength: 10,
                  validator: (str) {
                    if (str == null || str.length > 10 || str.length < 3) {
                      return "Plate number must be between 3 and 10 characters.";
                    }
                    return null;
                  },
                ),
                const Gap(10),
                CustomTextBox(
                  icon: FluentIcons.comment_note_24_regular,
                  hintText: "Notes",
                  initialValue: cubit.car.notes,
                  maxLines: null,
                  maxLength: null,
                  onChanged: (s) => cubit.car.notes = s,
                  englishOnly: false,
                ),
                const Gap(50),
                if (cubit.editMode)
                  CustomButton(
                    text: "Galary",
                    onTap: cubit.goToGalary,
                  ),
                if (cubit.editMode) const Gap(10),
                if (cubit.editMode)
                  CustomButton(
                    text: "Delete",
                    onTap: () => cubit.deleteCar(cubit.car.id),
                  ),
                if (cubit.editMode) const Gap(10),
                CustomButton(
                  text: cubit.editMode ? "Save Changes" : 'Add',
                  onTap: cubit.updateAddCar,
                ),
                const Gap(50),
              ],
            ),
          ),
        );
      },
    );
  }
}
