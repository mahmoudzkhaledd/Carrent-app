import 'package:carrent/Features/Core/Car/MyCars/bloc/my_cars_cubit.dart';
import 'package:carrent/Features/Core/Packages/AllPackages/View/widgets/PackageWidget.dart';
import 'package:carrent/Features/Core/Packages/AllPackages/bloc/all_packages_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomTextBox.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../GeneralWidgets/CarWidget.dart';

class AllPackagesBody extends StatelessWidget {
  const AllPackagesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AllPackagesCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: BlocBuilder<AllPackagesCubit, AllPackagesState>(
          builder: (context, state) {
            if (state is AllPackagesLoadingState) {
              return Helper.loadingWidget();
            }
            if (state is AllPackagesFailState) {
              return const LoadingFailsWidget(
                title: "Error while loading, please try again later",
                image: null,
              );
            }
            return RefreshIndicator(
              onRefresh: () async => cubit.getData(),
              child: ListView.separated(
                itemBuilder: (context, index) => index == 0
                    ? AppText(
                        'Pick a membership that fits you',
                        style: FontStyles.bigTitle,
                      )
                    : PackageWidget(
                        package: cubit.packages[index - 1],
                        onTap: cubit.subscribe,
                      ),
                separatorBuilder: (context, index) => const Gap(20),
                itemCount: cubit.packages.length + 1,
                padding: const EdgeInsets.all(10),
              ),
            );
          },
        ),
      ),
    );
  }
}
