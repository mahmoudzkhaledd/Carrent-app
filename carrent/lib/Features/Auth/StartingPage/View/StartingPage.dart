import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../GeneralWidgets/AppText.dart';
import '../../../../GeneralWidgets/CustomButton.dart';
import 'package:gap/gap.dart';
import '../../LoginPage/View/LoginPage.dart';
import '../../SignupPage/View/SignupPage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              AppText(
                "Welcome back",
                style: FontStyles.bigTitle,
                textAlign: TextAlign.center,
              ),
              const Gap(7),
              AppText(
                "Welcome to car rent app ",
                textAlign: TextAlign.center,
                style: FontStyles.p,
              ),
              const Gap(20),
              CustomButton(
                text: "Login",
                onTap: () {
                  Get.to(() => const LoginPage());
                },
              ),
              const Gap(10),
              CustomButton(
                text: "Create new account",
                onTap: () {
                  Get.to(() => const SignupPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
