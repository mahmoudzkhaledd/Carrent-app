import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:carrent/Models/Car.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/add_new_car_cubit.dart';
import '../Widgets/AddNewCarBody.dart';

class AddNewCarPage extends StatelessWidget {
  const AddNewCarPage({
    super.key,
    this.car,
  });
  final Car? car;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('Add new car'),
      ),
      body: BlocProvider(
        create: (c) => AddNewCarCubit(car),
        child: const AddNewCarBody(),
      ),
    );
  }
}
