import 'package:carrent/GeneralWidgets/CustomDropDown.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../GeneralWidgets/AppText.dart';
import '../../../../../GeneralWidgets/CustomButton.dart';
import '../../../../../GeneralWidgets/CustomCheckBox.dart';
import '../../../../../GeneralWidgets/CustomDatePicker.dart';
import '../../../../../GeneralWidgets/CustomTextBox.dart';
import '../../../../../Helper/Helper.dart';
import '../../Blocs/SignupCubit/signup_cubit.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              AppText(
                "Welcome to car renting app",
                style: FontStyles.bigTitle,
                textAlign: TextAlign.center,
              ),
              const Gap(10),
              AppText(
                "Please enter your data to create your account",
                style: FontStyles.p,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              CustomTextBox(
                hintText: "Company name",
                icon: FluentIcons.rename_28_regular,
                onChanged: (e) => cubit.user.companyName = e,
                validator: (txt) {
                  if (txt == null || txt.length < 3) {
                    return "Company name must be between 3 and 32 characters";
                  }
                  return null;
                },
              ),
              const Gap(10),
              CustomTextBox(
                hintText: "First name",
                icon: FluentIcons.rename_28_regular,
                onChanged: (e) => cubit.user.firstName = e,
                validator: (txt) {
                  if (txt == null || txt.length < 3) {
                    return "First name must be between 3 and 32 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextBox(
                hintText: "Last name",
                icon: FluentIcons.rename_28_regular,
                onChanged: (e) => cubit.user.lastName = e,
                validator: (txt) {
                  if (txt == null || txt.length < 3) {
                    return "First name must be between 3 and 32 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextBox(
                hintText: "Email",
                icon: FluentIcons.mail_28_regular,
                onChanged: (e) => cubit.user.email = e,
                validator: (txt) {
                  if (txt == null || !Helper.isValidEmail(txt)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<SignupCubit, SignupState>(
                buildWhen: (previous, current) =>
                    previous is SignupInitial ||
                    current is ChangePasswordVisabilityState,
                builder: (context, state) => Column(
                  children: [
                    CustomTextBox(
                      hintText: "Password",
                      icon: FluentIcons.password_24_regular,
                      showEyeIcon: true,
                      isPassword: !cubit.showPassword,
                      onChangeVisability: cubit.changePasswordVisability,
                      onChanged: (e) => cubit.user.password = e,
                      validator: (txt) {
                        if (txt == null || txt.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextBox(
                      hintText: "Confirm password",
                      icon: FluentIcons.password_24_regular,
                      isPassword: true,
                      validator: (txt) {
                        if (txt != cubit.user.password) {
                          return "Passwords does not match!";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomTextBox(
                hintText: "Phone",
                icon: FluentIcons.call_32_regular,
                isNumber: true,
                onChanged: (e) => cubit.user.phone = e,
                validator: (txt) {
                  if (txt == null || txt.isEmpty) {
                    return "Please etner your phone number";
                  }
                  if (txt.length > 30) {
                    return "Plone number is not valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<SignupCubit, SignupState>(
                buildWhen: (previous, current) =>
                    previous is SignupInitial ||
                    current is ChangeBirthdateState,
                builder: (context, state) {
                  return CustomDatePicker(
                    subTitle: "Birthdate",
                    icon: FluentIcons.calendar_32_regular,
                    currentDate: cubit.user.birthdate,
                    onChanged: cubit.changeUserBirthDate,
                  );
                },
              ),
              const Gap(10),
              CustomDropDown(
                items: const [
                  "Male",
                  'Female',
                ],
                selectedValue: "asdasd",
                onSaved: (e) => cubit.user.gender = e == "Male",
                hint: 'Gender',
              ),
              const Gap(10),
              BlocBuilder<SignupCubit, SignupState>(
                buildWhen: (previous, current) =>
                    previous is SignupInitial ||
                    current is ChangeConditionsState,
                builder: (context, state) {
                  return CustomCheckBox(
                    value: cubit.acceptConditions,
                    text: "Accept terms and conditions",
                    onChange: cubit.changeConditions,
                  );
                },
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: "Create account",
                onTap: cubit.signup,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
