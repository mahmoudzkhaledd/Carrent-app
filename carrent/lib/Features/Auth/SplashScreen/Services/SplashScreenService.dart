import 'package:dio/dio.dart' as dioPage;
import 'package:get/get.dart';

import '../../../../Models/AppConfigs.dart';
import '../../../../Models/User.dart';
import '../../../../Shared/AppReposetory.dart';
import '../../../../Shared/AppUser.dart';
import '../../../../services/GeneralServices/NetworkService.dart';

class SplashScreenService {
  final dioPage.Dio dio = NetworkService.instance;
  Future<bool> checkAuth() async {
    try {
      dioPage.Response res = await dio.post(
        'login/token',
        data: {
          'deviceToken': Get.find<AppUser>().deviceToken,
        },
      );
      if (res.statusCode == 200) {
        Get.find<AppUser>().user = User.fromJson(res.data['user']);
        if (res.data['appConfigs'] != null) {
          AppRepository.appConfigs =
              AppConfigs.fromJson(res.data['appConfigs']);
        }

        return true;
      }

      return false;
    } on dioPage.DioException catch (_) {
      return false;
    }
  }
}
