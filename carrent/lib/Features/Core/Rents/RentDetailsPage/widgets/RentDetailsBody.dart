import 'package:carrent/Features/Core/Car/CarPage/view/CarPage.dart';
import 'package:carrent/Features/Core/Rents/RentCar/view/RentCar.dart';
import 'package:carrent/Features/Core/Rents/RentDetailsPage/cubit/rent_details_cubit.dart';
import 'package:carrent/GeneralWidgets/CustomButton.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/Pair.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'DetailCard.dart';

class RentDetailsBody extends StatelessWidget {
  const RentDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RentDetailsCubit>();
    return BlocBuilder<RentDetailsCubit, RentDetailsState>(
      builder: (context, state) {
        if (state is RentDetailsLoadingState) {
          return Helper.loadingWidget();
        }
        if (state is RentDetailsFailedState) {
          return RefreshIndicator(
            onRefresh: () async => cubit.getData(),
            child: const LoadingFailsWidget(
              title: "Loading filed, please try again later.",
              image: "not found.png",
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => cubit.getData(),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (cubit.rent!.car != null &&
                  cubit.rent!.car!.thumbnailImageModel != null)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Helper.loadNetworkImage(
                      cubit.rent!.car!.thumbnailImageModel!.url,
                      'car.png',
                      BoxFit.cover,
                    ),
                  ),
                ),
              const Gap(20),
              if (cubit.rent!.car != null)
                RentDetailCard(
                  title: "Car Details",
                  icon: FluentIcons.image_search_24_regular,
                  onTap: () {
                    Get.to(() => CarPage(id: cubit.rent!.car!.id));
                  },
                  rows: [
                    Pair("Car name", cubit.rent!.car!.name),
                    Pair("Car model", cubit.rent!.car!.model),
                    Pair("Car panel number", cubit.rent!.car!.panelNumber),
                    Pair(
                      "Car passengers",
                      cubit.rent!.car!.passengersNumber.toString(),
                    ),
                  ],
                ),
              const Gap(20),
              RentDetailCard(
                title: "Client Details",
                rows: [
                  Pair("Client name", cubit.rent!.clientName),
                  Pair("Client phone", cubit.rent!.clientPhone),
                  Pair("Client identity", cubit.rent!.clientIdentity),
                ],
              ),
              const Gap(20),
              RentDetailCard(
                title: "Rent Details",
                rows: [
                  Pair("State", cubit.rent!.finished ? "Finished" : "Active"),
                  Pair("Starting date", cubit.rent!.startingDate.split(' ')[0]),
                  Pair("Ending date", cubit.rent!.endingDate.split(' ')[0]),
                  Pair(
                      "Total price", cubit.rent!.totalPrice.toStringAsFixed(2)),
                  Pair("Paid price", cubit.rent!.paidPrice.toStringAsFixed(2)),
                  Pair("Remaining price",
                      cubit.rent!.remainingPrice.toStringAsFixed(2)),
                  Pair("Created at", cubit.rent!.createdAt.split('T')[0]),
                  Pair("Last update", cubit.rent!.updatedAt.split('T')[0]),
                ],
              ),
              const Gap(20),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomButton(
                        text: "Edit",
                        verticalPadding: 0,
                        onTap: () {
                          Get.to(
                            () => RentCarPage(
                              rent: cubit.rent,
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      flex: 1,
                      child: CustomButton(
                        text: "",
                        verticalPadding: 0,
                        icon: Icon(
                          FluentIcons.delete_12_regular,
                          color: AppColors.dark.text,
                        ),
                        onTap: cubit.suspenseRent,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              CustomButton(
                text: cubit.rent!.finished ? "Active rent" : "Finish rent",
                verticalPadding: 10,
                onTap: cubit.finishRent,
              ),
              const Gap(50),
            ],
          ),
        );
      },
    );
  }
}
