import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Models/Rent.dart';
import '../cubit/add_rent_car_cubit.dart';
import '../widgets/RentCarBody.dart';

class RentCarPage extends StatelessWidget {
  const RentCarPage({super.key, this.rent});
  final Rent? rent;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddRentCarCubit(rent),
      child: Scaffold(
        appBar: AppBar(
          title: const AppText('Rent Car'),
        ),
        body: const RentCarBody(),
      ),
    );
  }
}
