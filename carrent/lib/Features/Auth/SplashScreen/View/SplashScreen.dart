import 'package:carrent/Shared/AppColors.dart';
import 'package:flutter/material.dart';

import 'Widgets/SplashScreenBody.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.primary,
      body: const SplashScreenBody(),
    );
  }
}
