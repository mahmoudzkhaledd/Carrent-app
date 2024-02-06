import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../GeneralWidgets/AppText.dart';
import '../cubit/car_page_cubit.dart';
import '../widgets/CarBody.dart';

class CarPage extends StatelessWidget {
  const CarPage({
    super.key,
    required this.id,
  });
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('My cars'),
      ),
      body: BlocProvider(
        create: (c) => CarPageCubit(id),
        child: const CarPageBody(),
      ),
    );
  }
}
