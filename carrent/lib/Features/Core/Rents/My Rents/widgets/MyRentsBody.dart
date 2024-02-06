import 'package:carrent/Features/Core/Rents/My%20Rents/cubit/my_rents_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomContainer.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../Shared/AppColors.dart';
import 'RentWidget.dart';

class MyRentsBody extends StatelessWidget {
  const MyRentsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyRentsCubit>();

    return BlocBuilder<MyRentsCubit, MyRentsState>(
      builder: (context, state) {
        if (state is MyRentsLoadingState) {
          return Helper.loadingWidget();
        }
        if (state is MyRentsFailState) {
          return const LoadingFailsWidget(
            title:
                "There is a problem with fetching data, please try again later.",
            image: "not found.png",
          );
        }

        return BlocBuilder<MyRentsCubit, MyRentsState>(
          buildWhen: (previous, current) => current is MyRentsSelectDate,
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async => cubit.getData(),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                children: cubit.rents.isEmpty
                    ? [
                        const Gap(50),
                        const LoadingFailsWidget(
                          title: 'No Rents Yet!',
                          image: "not found.png",
                        ),
                      ]
                    : [
                        Row(
                          children: [
                            AppText(
                              'My Rents',
                              style: FontStyles.title,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: cubit.switchListView,
                              icon: Icon(cubit.listView
                                  ? Icons.calendar_month_outlined
                                  : Icons.list),
                            ),
                          ],
                        ),
                        const Gap(10),
                        if (!cubit.listView)
                          CustomContainer(
                            backColor: Colors.transparent,
                            borderRadius: 10,
                            borderColor: AppColors.instance.borderText,
                            borderWidth: 1,
                            bordered: true,
                            height: 450,
                            child: TableCalendar(
                              headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                              ),
                              eventLoader: (day) {
                                final ev = cubit
                                    .rentsDates[day.toString().split(' ')[0]];

                                if (ev == null) {
                                  return [];
                                } else {
                                  return ev;
                                }
                              },
                              rangeStartDay: cubit.rangeStartDay,
                              rangeEndDay: cubit.rangeEndDay,
                              onDaySelected: cubit.selectDate,
                              focusedDay: cubit.currentDate,
                              selectedDayPredicate: (day) =>
                                  isSameDay(day, cubit.currentDate),
                              firstDay: DateTime(2010),
                              lastDay: DateTime.now()
                                  .add(const Duration(days: 1000)),
                            ),
                          )
                        else
                          ...cubit.rents.map(
                            (rent) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: RentWidget(
                                rent: rent,
                                listView: cubit.listView,
                                selectRent: cubit.selectRent,
                              ),
                            ),
                          ),
                        const Gap(20),
                        if (!cubit.listView)
                          if (cubit.selectedRent.isNotEmpty)
                            ...cubit.selectedRent
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: RentWidget(
                                      rent: e,
                                      selectRent: cubit.selectRent,
                                    ),
                                  ),
                                )
                                .toList()
                          else
                            CustomContainer(
                              borderRadius: 10,
                              borderWidth: 1,
                              height: 100,
                              child: Center(
                                child: AppText(
                                  "No rents in this date!",
                                  style: FontStyles.body,
                                ),
                              ),
                            ),
                      ],
              ),
            );
          },
        );
      },
    );
  }
}
