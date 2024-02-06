import 'package:bloc/bloc.dart';
import 'package:carrent/Features/Core/Notifications/Services/NotificationServices.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/Invite.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final List<Invitation> notifications = [];
  NotificationCubit() : super(NotificationInitial()) {
    getData();
  }
  final services = NotificationServices();
  void getData() async {
    notifications.clear();
    emit(NotificationLoadingState());
    final res = await services.getNotifications();

    if (res != null) {
      notifications.addAll(res);

      emit(NotificationSuccessState());
    } else {
      emit(NotificationFailedState(
        "Error occured while fetching data, please try again",
      ));
    }
  }

  void onChangeStateNotification(String id, bool accept) async {
    final res = await Helper.showLoading(
      "Please Wait",
      "Please wait unitl the opearion finished",
      () => services.changeInvitationState(id, accept),
    );
    if (!res) {
      await Helper.showMessage(
        "Problem",
        "Can't do this operation, please try again later.",
      );
      return;
    }
    getData();
  }
}
