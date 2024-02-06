import 'package:carrent/Configs.dart';
import 'package:carrent/Features/Auth/SplashScreen/View/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Shared/AppColors.dart';
import 'Shared/Fonts/FontModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configs();

  runApp(const CarRent());
}

class CarRent extends StatelessWidget {
  const CarRent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // locale: Locale(
      //   AppText.defaultLanguage == TextLanguage.arabic ? 'ar' : "en",
      // ),
      supportedLocales: const [
        Locale("ar"),
        Locale("en"),
      ],
      themeMode: AppColors.mode,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.instance.background,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: FontFamily.bold,
            fontSize: 17,
            color: AppColors.instance.text,
          ),
          backgroundColor: AppColors.instance.background,
          foregroundColor: AppColors.instance.text,
          elevation: 0,
        ),
      ),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.instance.background,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: FontFamily.bold,
            fontSize: 17,
            color: AppColors.instance.text,
          ),
          foregroundColor: AppColors.instance.text,
          backgroundColor: AppColors.instance.background,
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
