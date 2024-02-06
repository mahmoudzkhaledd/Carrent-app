import 'package:carrent/Features/Home/HomePage/Cubits/HomeCubit/home_cubit.dart';
import 'package:carrent/Features/Home/HomePage/Widgets/CustomAppBar.dart';
import 'package:carrent/Features/Home/HomePage/Widgets/OptionsRow.dart';
import 'package:carrent/Features/Home/HomePage/Widgets/RecentRents.dart';
import 'package:carrent/GeneralWidgets/CustomContainer.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return RefreshIndicator(
      onRefresh: () async => cubit.getData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Helper.loadingWidget();
          }

          return ListView(
            children: [
              const CustomAppBar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomContainer(
                      width: double.infinity,
                      height: 200,
                      backColor: AppColors.instance.primary,
                      borderRadius: 10,
                      child: const SizedBox(),
                    ),
                    const Gap(20),
                    const Center(
                      child: SizedBox(
                        height: 100,
                        child: OptionsRow(),
                      ),
                    ),
                    RecentRents(
                      rents: cubit.rents,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
