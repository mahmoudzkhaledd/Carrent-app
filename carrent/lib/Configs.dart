import 'package:carrent/Shared/AppColors.dart';
import 'package:carrent/Shared/Secrets.dart';
import 'package:carrent/services/GeneralServices/NetworkService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Shared/AppUser.dart';
import 'firebase_options.dart';
import 'GeneralWidgets/AppText.dart';

import 'services/GeneralServices/NotificationService.dart';
import 'services/GeneralServices/StorageService.dart';

Future<void> handelMsgs(RemoteMessage message) async {
  //print(message.data);
}

Future<void> configs() async {
  Secrets.appMode = kDebugMode ? ApplicationMode.dev : ApplicationMode.run;
  AppText.defaultLanguage = TextLanguage.english;
  await StorageServices.instance.initPrefs();
  NetworkService.initDio();
  // AppColors.mode = StorageServices.instance.getTheme() == "dark"
  //     ? ThemeMode.dark
  //     : ThemeMode.light;
  AppColors.mode = ThemeMode.light;
  AppColors.init();
  Get.put(AppUser());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission();
  Get.find<AppUser>().deviceToken =
      await FirebaseMessaging.instance.getToken() ?? "";

  FirebaseMessaging.onMessage.listen((event) {
    NotifiactionServices.instance.sendNotification(
      event.notification!.title!,
      event.notification!.body!,
    );
  });
  FirebaseMessaging.onBackgroundMessage(handelMsgs);
  await NotifiactionServices.instance.init();

  //PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // String appName = packageInfo.appName;
  // String packageName = packageInfo.packageName;
  // String version = packageInfo.version;
  // String buildNumber = packageInfo.buildNumber;
}
