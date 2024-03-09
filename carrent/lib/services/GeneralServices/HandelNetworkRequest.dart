import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Models/ResponseResult.dart';

class HandelNetworkRequest {
  static Future<bool> handelRequest(ResponseResult res) async {
    if (res.success) {
      return true;
    }
    if (!res.internet) return false;
    if (res.msg != null) {
      await Helper.showMessage(
        'Error',
        res.msg!,
        icon: res.icon,
      );
    }
    return false;
  }
}
