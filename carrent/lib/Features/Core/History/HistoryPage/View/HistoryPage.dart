import 'package:carrent/Features/Core/History/HistoryPage/Widgets/HistoryPageBody.dart';
import 'package:carrent/Features/Core/History/HistoryPage/cubit/history_page_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('History'),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => HistoryPageCubit(),
          child: const HistoryPageBody(),
        ),
      ),
    );
  }
}
