import 'package:carrent/Features/Core/Rents/RentDetailsPage/cubit/rent_details_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/RentDetailsBody.dart';

class RentDetailsPage extends StatelessWidget {
  const RentDetailsPage({super.key, required this.rentId});
  final String rentId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('Rent Details'),
      ),
      body: BlocProvider(
        create: (context) => RentDetailsCubit(rentId),
        child: const RentDetailsBody(),
      ),
    );
  }
}
