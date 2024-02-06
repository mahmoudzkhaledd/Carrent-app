import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/GeneralWidgets/CustomButton.dart';
import 'package:carrent/Shared/AppColors.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/car_galary_cubit.dart';

class AddImageWidget extends StatelessWidget {
  const AddImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CarGalaryCubit>();

    return Row(
      children: [
        CustomButton(
          text: '',
          icon: const Icon(Icons.add),
          verticalPadding: 5,
          onTap: cubit.choseImage,
        ),
        const Spacer(),
        AppText(
          '${cubit.getFillNumber}/${10}',
          style: FontStyles.body,
        ),
        const Spacer(),
        CustomButton(
          text: '',
          icon: const Icon(Icons.check),
          verticalPadding: 5,
          onTap: cubit.uploadImages,
        ),
      ],
    );
  }
}
