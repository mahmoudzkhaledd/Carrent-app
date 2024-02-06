import 'package:carrent/Features/Core/Car/MyCars/View/widgets/MyCarsBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../GeneralWidgets/AppText.dart';
import '../bloc/my_cars_cubit.dart';

class MyCarsPage extends StatelessWidget {
  const MyCarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('My cars'),
      ),
      body: BlocProvider(
        create: (c) => MyCarsCubit(),
        child: const MyCarsBody(),
      ),
    );
  }
}
