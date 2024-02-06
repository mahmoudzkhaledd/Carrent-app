import 'package:carrent/Features/Core/Car/CarPage/cubit/car_page_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomContainer.dart';
import 'package:carrent/GeneralWidgets/CustomPageIndicator.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../../GeneralWidgets/SubUserDescription.dart';

class CarPageBody extends StatelessWidget {
  const CarPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CarPageCubit>();

    return BlocBuilder<CarPageCubit, CarPageState>(
      builder: (ctx, state) {
        if (state is CarPageLoadingState) {
          return Helper.loadingWidget();
        }
        if (state is CarPageFailState) {
          return RefreshIndicator(
            onRefresh: () async => cubit.getData(),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: LoadingFailsWidget(
                title:
                    "Sorry, We can't find the car you want, please try again later.",
                image: "not found.png",
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => cubit.getData(),
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            children: [
              BlocBuilder<CarPageCubit, CarPageState>(
                buildWhen: (previous, current) =>
                    current is CarPageAddImageState,
                builder: (ctx, state) => SizedBox(
                  height: 200,
                  child: PageView.builder(
                    onPageChanged: cubit.changePage,
                    itemCount: cubit.car.images.length + 1,
                    itemBuilder: (ctx, idx) => Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Helper.loadNetworkImage(
                            idx == 0
                                ? cubit.car.thumbnailImageModel != null
                                    ? cubit.car.thumbnailImageModel!.url
                                    : ""
                                : cubit.car.images[idx - 1].url,
                            'car.png',
                            BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              BlocBuilder<CarPageCubit, CarPageState>(
                buildWhen: (previous, current) =>
                    current is CarPageChangeImageIndex,
                builder: (ctx, state) => CustomPageIndicator(
                  itemCount: cubit.car.images.length + 1,
                  currentIndex: cubit.currentPageIndex,
                  dimentions: 8,
                  selectedColor: AppColors.instance.text,
                  unSelectedColor: AppColors.instance.secondarySelect,
                ),
              ),
              const Gap(20),
              AppText(
                cubit.car.name,
                style: FontStyles.title,
                capitalizeFirst: true,
              ),
              const Gap(5),
              AppText(
                cubit.car.model,
                style:
                    FontStyles.p.copyWith(color: AppColors.instance.textFade),
                capitalizeFirst: true,
              ),
              AppText(
                "Added in: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse(cubit.car.createdAt))}",
                style:
                    FontStyles.p.copyWith(color: AppColors.instance.textFade),
                capitalizeFirst: true,
              ),
              AppText(
                "Last Update in: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse(cubit.car.updatedAt))}",
                style:
                    FontStyles.p.copyWith(color: AppColors.instance.textFade),
                capitalizeFirst: true,
              ),
              const Gap(20),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  SubUserDescription(
                    icon: FluentIcons.people_48_regular,
                    data: cubit.car.passengersNumber.toString(),
                    fontSize: 15,
                  ),
                  SubUserDescription(
                    icon: FluentIcons.number_symbol_48_regular,
                    data: cubit.car.panelNumber,
                    fontSize: 15,
                    letterSpacing: 10,
                  ),
                ],
              ),
              const Gap(20),
              CustomContainer(
                borderRadius: 10,
                verticalPadding: 15,
                horizontalPadding: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "Notes",
                      style: FontStyles.listTitle,
                      capitalizeFirst: true,
                    ),
                    Divider(
                      color: AppColors.instance.borderText,
                    ),
                    const Gap(5),
                    AppText(
                      cubit.car.notes.isNotEmpty
                          ? cubit.car.notes
                          : "No notes added!",
                      style: FontStyles.p,
                      capitalizeFirst: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
