import 'package:carrent/Features/Core/Car/CarGalary/cubit/car_galary_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/Models/Car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/CarGalaryBody.dart';

class CarGalary extends StatelessWidget {
  const CarGalary({super.key, required this.car});
  final Car car;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('Your Car Photo Galary'),
      ),
      body: BlocProvider(
        create: (context) => CarGalaryCubit(car),
        child: const SafeArea(
          child: CarGalaryBody(),
        ),
      ),
    );
  }
}
