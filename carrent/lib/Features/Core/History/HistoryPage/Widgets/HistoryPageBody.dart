import 'package:carrent/Features/Core/History/HistoryPage/cubit/history_page_cubit.dart';
import 'package:carrent/GeneralWidgets/HistoryComponent.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HistoryPageBody extends StatelessWidget {
  const HistoryPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HistoryPageCubit>();
    return BlocBuilder<HistoryPageCubit, HistoryPageState>(
      builder: (context, state) {
        if (state is HistoryPageLoadingState) {
          return Helper.loadingWidget();
        }
        return RefreshIndicator(
          onRefresh: () async => cubit.getData(),
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemBuilder: (ctx, idx) {
              return HistoryComponent(history: cubit.history[idx]);
            },
            separatorBuilder: (e, idx) => const Gap(0),
            itemCount: cubit.history.length,
          ),
        );
      },
    );
  }
}
