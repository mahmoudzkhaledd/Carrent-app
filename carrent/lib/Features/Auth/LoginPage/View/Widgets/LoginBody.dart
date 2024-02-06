import 'package:carrent/GeneralWidgets/Image.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../GeneralWidgets/AppText.dart';
import '../../../../../GeneralWidgets/CustomButton.dart';
import '../../../../../GeneralWidgets/CustomTextBox.dart';
import '../../../../../Helper/Helper.dart';
import '../../../EmailVerification/ForgetPasswordPage/View/ForgetPasswordPage.dart';
import '../../Blocs/LoginCubit/login_cubit.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginCubit cubit = context.read<LoginCubit>();
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: context.read<LoginCubit>().formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomImage(
                width: 100,
                'Logo.png',
              ),
              const Gap(50),
              Center(
                child: AppText(
                  "Login",
                  textAlign: TextAlign.center,
                  style: FontStyles.bigTitle,
                ),
              ),
              const Gap(20),
              CustomTextBox(
                hintText: "Email or Phone number",
                icon: FluentIcons.mail_28_regular,
                onChanged: (e) => cubit.email = e,
                isEmail: true,
                validator: (value) {
                  if (value == null || !Helper.isValidEmail(value)) {
                    return "Please enter a valid email.";
                  }
                  return null;
                },
              ),
              const Gap(10),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return CustomTextBox(
                    hintText: "Password",
                    onChanged: (e) => cubit.password = e,
                    icon: FluentIcons.password_24_regular,
                    isPassword: !context.read<LoginCubit>().showPassword,
                    showEyeIcon: true,
                    isPasswordInput: true,
                    onChangeVisability:
                        context.read<LoginCubit>().changePassword,
                    validator: (txt) => (txt != null && txt.length >= 8)
                        ? null
                        : "Password must be at least 8 charactes",
                  );
                },
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(() => const ForgetPasswordPage());
                    },
                    child: AppText(
                      "Forget your password?",
                      style: FontStyles.p,
                    ),
                  ),
                ],
              ),
              const Gap(20),
              CustomButton(
                text: "Login",
                onTap: context.read<LoginCubit>().login,
              ),
              const Gap(20),
              TextButton(
                onPressed: () {
                  Get.to(() => const ForgetPasswordPage());
                },
                child: AppText(
                  "Signup",
                  style: FontStyles.p,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
