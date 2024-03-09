import '../../Models/HistoryRecord.dart';
import 'NetworkService.dart';

class HistoryServices {
  final dio = NetworkService.instance;
  Future<List<HistoryRecord>?> getUserHistory(int? max) async {
    final res = await NetworkService.handelRequest(
      future: dio.get(
        'history${max == null ? "" : "?max=$max"}',
      ),
    );
    if (res == null) {
      return null;
    }
    switch (res.statusCode) {
      case 200:
        return (res.data['histories'] as List<dynamic>)
            .map((e) => HistoryRecord.fromJson(e))
            .toList();
    }
    return null;
  }
}
