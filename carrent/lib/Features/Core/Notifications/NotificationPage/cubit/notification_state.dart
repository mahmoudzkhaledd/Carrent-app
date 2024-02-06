part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoadingState extends NotificationState {}

final class NotificationFailedState extends NotificationState {
  final String message;
  NotificationFailedState(this.message);
}

final class NotificationSuccessState extends NotificationState {}
