import 'package:carrent/Features/Core/Rents/My%20Rents/cubit/my_rents_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/MyRentsBody.dart';

class MyRentsPage extends StatelessWidget {
  const MyRentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("My Rents"),
      ),
      body: BlocProvider(
        create: (context) => MyRentsCubit(),
        child: const MyRentsBody(),
      ),
    );
  }
}
