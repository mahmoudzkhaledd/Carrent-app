import 'dart:io';

import 'package:carrent/Features/Core/Car/CarGalary/cubit/car_galary_cubit.dart';
import 'package:carrent/Helper/Helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../GeneralWidgets/CustomIconButton.dart';
import 'AddImageWidget.dart';

class CarGalaryBody extends StatelessWidget {
  const CarGalaryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CarGalaryCubit>();

    return BlocBuilder<CarGalaryCubit, CarGalaryState>(
      buildWhen: (previous, current) => current is CarGalaryChagneImage,
      builder: (ctx, state) => ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        itemCount: cubit.getFillNumber + 1,
        itemBuilder: (context, idx) {
          if (idx == 0) {
            return AddImageWidget();
          }
          idx--;
          final file = idx >= cubit.car.images.length
              ? File(cubit.chosenImages[idx - cubit.car.images.length])
              : null;
          return Padding(
            key: UniqueKey(),
            padding: EdgeInsets.only(
              bottom: 20,
              top: idx == 0 ? 20 : 0,
            ),
            child: GestureDetector(
              onTap: () => cubit.viewImage(null, file),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: idx < cubit.car.images.length
                        ? Helper.loadNetworkImage(
                            cubit.car.images[idx].url, 'car.png')
                        : Image.file(file!),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CustomIconButton(
                      onTap: () => idx >= cubit.car.images.length
                          ? cubit.removeFileImage(
                              cubit.chosenImages[idx - cubit.car.images.length])
                          : cubit.removeNetworkImage(idx),
                      icon: Icons.clear,
                      backColor: Colors.white,
                      borderRadius: 200,
                      iconSize: 20,
                      verticalPadding: 5,
                      horizontalPadding: 5,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
