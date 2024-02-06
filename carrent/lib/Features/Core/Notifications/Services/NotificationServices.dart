import 'package:carrent/Models/Invite.dart';
import 'package:carrent/services/GeneralServices/NetworkService.dart';

class NotificationServices {
  final dio = NetworkService.instance;
  Future<List<Invitation>?> getNotifications() async {
    final res = await NetworkService.handelRequest(
      future: dio.get('/teams/invitations'),
    );

    if (res == null) {
      return null;
    }
    print(res.data);
    switch (res.statusCode) {
      case 200:
        return (res.data['invitations'] as List<dynamic>)
            .map((e) => Invitation.fromJson(e))
            .toList();
    }
    return null;
  }

  Future<bool> changeInvitationState(String id, bool accept) async {
    final res = await NetworkService.handelRequest(
      future: dio.post(
        '/teams/invitations/$id/accept',
        data: {
          "accept": accept,
        },
      ),
    );

    if (res == null || res.statusCode != 200) {
      return false;
    }
    return true;
  }
}
