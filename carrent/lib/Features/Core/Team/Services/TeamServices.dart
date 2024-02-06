import 'package:carrent/Models/ResponseResult.dart';
import 'package:carrent/Models/Team.dart';

import 'package:carrent/services/GeneralServices/NetworkService.dart';

class TeamServices {
  final dio = NetworkService.instance;
  Future<ResponseResult> getUserTeams() async {
    final res = await NetworkService.handelRequest(
      future: dio.get('teams'),
    );

    if (res == null || res.statusCode != 200) {
      return ResponseResult(
        data: res?.data,
        icon: null,
        msg: 'Error occured, please try again later.',
        success: false,
      );
    }
    return ResponseResult(
      data: res.data,
      icon: null,
      msg: null,
      success: true,
    );
  }

  Future<ResponseResult> createUserTeam(String name) async {
    final res = await NetworkService.handelRequest(
      future: dio.post('teams', data: {"name": name}),
    );

    if (res == null || res.statusCode != 200 || res.data['team'] == null) {
      return ResponseResult(
        data: res?.data,
        icon: null,
        msg: 'Error occured, please try again later.',
        success: false,
      );
    }
    return ResponseResult(
      data: res.data,
      icon: null,
      msg: null,
      success: true,
    );
  }

  Future<Team?> getTeam(String id) async {
    final res = await NetworkService.handelRequest(
      future: dio.get('teams/$id'),
    );
    if (res == null ||
        res.statusCode != 200 ||
        res.data['team'] is! Map<String, dynamic>) {
      return null;
    }
    return Team.fromJson(res.data['team']);
  }

  Future<ResponseResult> inviteUser(String teamId, String userId) async {
    final res = await NetworkService.handelRequest(
      future: dio.get(
        'teams/$teamId/invite',
        data: {"userId": userId},
      ),
    );
    if (res == null ||
        res.statusCode != 200 ||
        res.data['invite'] is! Map<String, dynamic>) {
      return ResponseResult(
        data: res?.data,
        icon: null,
        msg:
            'Error occured while inviting this member, please try again later.',
        success: false,
      );
    }
    return ResponseResult(
      data: res.data,
      icon: null,
      msg: null,
      success: true,
    );
  }
}
