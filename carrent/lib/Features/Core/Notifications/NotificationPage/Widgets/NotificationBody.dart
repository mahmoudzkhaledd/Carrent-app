import 'package:carrent/Features/Core/Notifications/NotificationPage/Widgets/NotificationWidget.dart';
import 'package:carrent/Features/Core/Notifications/NotificationPage/cubit/notification_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();
    return RefreshIndicator(
      onRefresh: () async => cubit.getData(),
      child: cubit.notifications.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImage(
                    'not found.png',
                    width: 200,
                  ),
                  Gap(20),
                  AppText(
                    'There are no notifications right now!',
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: cubit.notifications.length,
              itemBuilder: (context, index) {
                return NotificationWidget(
                  key: UniqueKey(),
                  notification: cubit.notifications[index],
                  onChangeState: cubit.onChangeStateNotification,
                );
              },
            ),
    );
  }
}
