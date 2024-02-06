import 'package:carrent/Features/Core/Notifications/NotificationPage/Widgets/NotificationBody.dart';
import 'package:carrent/Features/Core/Notifications/NotificationPage/cubit/notification_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Your Notifications"),
      ),
      body: BlocProvider(
        create: (context) => NotificationCubit(),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoadingState) {
              return Helper.loadingWidget();
            }
            if (state is NotificationFailedState) {
              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<NotificationCubit>().getData(),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    LoadingFailsWidget(
                      title: state.message,
                      image: "not found.png",
                    )
                  ],
                ),
              );
            }

            return const NotificationBody();
          },
        ),
      ),
    );
  }
}
