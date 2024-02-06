class AppConfigs {
  int waitingBetweenSends = 0;
  int waitingBetweenEndTrails = 0;
  int defaultSendTrails = 0;
  int defaultSendMistakes = 0;
  int maxFileSize = 0;
  int maxSearch = 0;
  final int maxLoad = 5;

  AppConfigs.fromJson(Map<String, dynamic> json) {
    waitingBetweenSends = json['waitingBetweenSends'];
    waitingBetweenEndTrails = json['waitingBetweenEndTrails'];
    defaultSendTrails = json['defaultSendTrails'];
    defaultSendMistakes = json['defaultSendMistakes'];
    maxFileSize = json['maxFileSize'];
    maxSearch = json['maxSearch'];
  }
}
