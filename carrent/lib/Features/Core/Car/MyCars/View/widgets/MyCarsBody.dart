import 'package:carrent/Features/Core/Car/MyCars/bloc/my_cars_cubit.dart';
import 'package:carrent/GeneralWidgets/CustomTextBox.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../GeneralWidgets/CarWidget.dart';

class MyCarsBody extends StatelessWidget {
  const MyCarsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyCarsCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: BlocBuilder<MyCarsCubit, MyCarsState>(
          builder: (context, state) {
            if (state is MyCarsLoadingState) {
              return Helper.loadingWidget();
            }
            if (state is MyCarsFailState) {
              return const LoadingFailsWidget(
                title: "Error while loading, please try again later",
                image: null,
              );
            }
            return RefreshIndicator(
              onRefresh: () async => cubit.getData(),
              child: Column(
                children: [
                  CustomTextBox(
                    onChanged: (e) => cubit.search = e,
                    hintText: "Search",
                    initialValue: cubit.search,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: cubit.getData,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: cubit.cars.isNotEmpty
                        ? ListView.builder(
                            itemCount: cubit.cars.length,
                            itemBuilder: (ctx, idx) {
                              return CarWidget(car: cubit.cars[idx]);
                            },
                          )
                        : const Center(
                            child: LoadingFailsWidget(
                              title: "No results found !",
                              image: "not found.png",
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
